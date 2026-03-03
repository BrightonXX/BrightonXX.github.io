const STORAGE_KEY = 'focus:latest';
const DEFAULT_ALLOWED_ORIGINS = 'https://brightonxx.github.io,http://localhost:1313';

function jsonResponse(data, status, corsHeaders) {
  return new Response(JSON.stringify(data), {
    status,
    headers: {
      'content-type': 'application/json; charset=utf-8',
      'cache-control': 'no-store',
      ...corsHeaders
    }
  });
}

function parseAllowedOrigins(env) {
  const raw = String(env.FOCUS_ALLOWED_ORIGINS || DEFAULT_ALLOWED_ORIGINS);
  return raw
    .split(',')
    .map((item) => item.trim())
    .filter(Boolean);
}

function buildCorsHeaders(request, env) {
  const origins = parseAllowedOrigins(env);
  const requestOrigin = String(request.headers.get('Origin') || '');
  let allowOrigin = origins[0] || '*';

  if (origins.includes('*')) {
    allowOrigin = '*';
  } else if (requestOrigin && origins.includes(requestOrigin)) {
    allowOrigin = requestOrigin;
  }

  return {
    'access-control-allow-origin': allowOrigin,
    'access-control-allow-methods': 'GET,POST,OPTIONS',
    'access-control-allow-headers': 'content-type,authorization',
    'access-control-max-age': '86400',
    vary: 'Origin'
  };
}

function normalizeBoolean(value) {
  if (typeof value === 'boolean') return value;
  if (typeof value === 'number') return value !== 0;
  if (typeof value !== 'string') return null;
  const normalized = value.trim().toLowerCase();
  if (['true', '1', 'on', 'active', 'enabled', 'focus', 'focused', 'busy'].includes(normalized)) return true;
  if (['false', '0', 'off', 'inactive', 'disabled', 'idle', 'available'].includes(normalized)) return false;
  return null;
}

function validateToken(request, env) {
  const configured = String(env.FOCUS_API_TOKEN || '').trim();
  if (!configured) return false;
  const authHeader = String(request.headers.get('Authorization') || '');
  const matched = authHeader.match(/^Bearer\s+(.+)$/i);
  return Boolean(matched && matched[1] === configured);
}

export default {
  async fetch(request, env) {
    const url = new URL(request.url);
    const corsHeaders = buildCorsHeaders(request, env);

    if (request.method === 'OPTIONS') {
      return new Response(null, { status: 204, headers: corsHeaders });
    }

    if (request.method === 'GET' && url.pathname === '/v1/focus/latest') {
      const latest = await env.FOCUS_KV.get(STORAGE_KEY, 'json');
      if (!latest) {
        return jsonResponse(
          {
            focus_mode: false,
            focus_name: '',
            updated_at: null,
            source: 'worker-default'
          },
          200,
          corsHeaders
        );
      }
      return jsonResponse(latest, 200, corsHeaders);
    }

    if (request.method === 'POST' && url.pathname === '/v1/focus/update') {
      if (!validateToken(request, env)) {
        return jsonResponse({ error: 'Unauthorized' }, 401, corsHeaders);
      }

      let payload = null;
      try {
        payload = await request.json();
      } catch (error) {
        return jsonResponse({ error: 'Invalid JSON body' }, 400, corsHeaders);
      }

      const focusMode = normalizeBoolean(payload && payload.focus_mode);
      if (focusMode == null) {
        return jsonResponse({ error: 'focus_mode must be a boolean-like value' }, 400, corsHeaders);
      }

      const focusName = String((payload && payload.focus_name) || '').trim().slice(0, 80);
      const device = String((payload && payload.device) || 'mac').trim().slice(0, 40);
      const source = String((payload && payload.source) || 'script').trim().slice(0, 40);

      // Core fields
      const stored = {
        focus_mode: focusMode,
        focus_name: focusName,
        device,
        source,
        updated_at: new Date().toISOString()
      };

      // Preserve extra fields from payload (e.g., battery, location, music, etc.)
      const coreKeys = ['focus_mode', 'focus_name', 'device', 'source', 'updated_at'];
      if (payload && typeof payload === 'object') {
        for (const key of Object.keys(payload)) {
          if (!coreKeys.includes(key)) {
            const value = payload[key];
            // Only store serializable values, max 500 chars for strings
            if (typeof value === 'string') {
              stored[key] = value.slice(0, 500);
            } else if (typeof value === 'number' || typeof value === 'boolean') {
              stored[key] = value;
            } else if (value === null) {
              stored[key] = null;
            } else if (typeof value === 'object') {
              // Store objects as JSON string (e.g., device_details)
              try {
                stored[key] = JSON.stringify(value).slice(0, 2000);
              } catch (e) {
                // Skip non-serializable
              }
            }
          }
        }
      }

      await env.FOCUS_KV.put(STORAGE_KEY, JSON.stringify(stored));
      return jsonResponse({ ok: true, ...stored }, 200, corsHeaders);
    }

    return jsonResponse({ error: 'Not found' }, 404, corsHeaders);
  }
};
