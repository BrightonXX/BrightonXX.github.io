# Focus Status Integration

This integration makes your Hugo blog fetch Focus status from a third-party API at runtime, so status updates do **not** require `git push` or site rebuilds.

## 1) Deploy the third-party API

Use the Cloudflare Worker template in:

- `/Users/brighton/Desktop/ProjectFinal/Web/blog/integrations/focus-status/cloudflare-worker.js`
- `/Users/brighton/Desktop/ProjectFinal/Web/blog/integrations/focus-status/wrangler.toml.sample`
- `/Users/brighton/Desktop/ProjectFinal/Web/blog/integrations/focus-status/deploy-commands.sh.sample`

Create these Worker bindings/variables:

1. KV binding: `FOCUS_KV`
2. Secret: `FOCUS_API_TOKEN`
3. Variable: `FOCUS_ALLOWED_ORIGINS`
   - Example: `https://brightonxx.github.io,http://localhost:1314,http://localhost:1313`

### Quick Deploy Commands (copy and run)

```bash
cd /Users/brighton/Desktop/ProjectFinal/Web/blog/integrations/focus-status

# 0) one-time setup
npm i -g wrangler
wrangler login

# 1) create KV namespace
wrangler kv namespace create FOCUS_KV

# 2) fill kv id in wrangler.toml
cp wrangler.toml.sample wrangler.toml
# then edit: [[kv_namespaces]].id = "<your id from step 1>"

# 3) set update token
wrangler secret put FOCUS_API_TOKEN

# 4) deploy
wrangler deploy
```

After deploy, your read endpoint is usually:

```text
https://<worker-name>.<subdomain>.workers.dev/v1/focus/latest
```

Optional post-deploy sanity test:

```bash
curl -i https://<worker-domain>/v1/focus/latest
```

### Worker API

1. `GET /v1/focus/latest`
2. `POST /v1/focus/update` (requires `Authorization: Bearer <FOCUS_API_TOKEN>`)

Expected update payload:

```json
{
  "focus_mode": true,
  "focus_name": "Deep Work",
  "device": "MacBook Pro",
  "source": "mac-script"
}
```

## 2) Connect blog frontend to API

Edit `/Users/brighton/Desktop/ProjectFinal/Web/blog/hugo.toml`:

```toml
[params.focus_status]
  enabled = true
  endpoint = "https://<your-worker>.workers.dev/v1/focus/latest"
  refresh_ms = 45000
  request_timeout_ms = 5000
  stale_after_minutes = 8
  offline_after_minutes = 45
  title = "FOCUS MODE"
```

Behavior on the blog:

1. Recent update + `focus_mode=true`: `In Focus`
2. Recent update + `focus_mode=false`: `Available`
3. Update older than `stale_after_minutes`: `Stale`
4. Update older than `offline_after_minutes`: `Offline`

## 3) Send updates from macOS

Use:

- `/Users/brighton/Desktop/ProjectFinal/Web/blog/scripts/report_focus_status.sh`

Prepare env vars:

```bash
export FOCUS_API_ENDPOINT="https://<your-worker>.workers.dev/v1/focus/update"
export FOCUS_API_TOKEN="<same-token-as-worker>"
```

Manual examples:

```bash
/Users/brighton/Desktop/ProjectFinal/Web/blog/scripts/report_focus_status.sh on "Deep Work"
/Users/brighton/Desktop/ProjectFinal/Web/blog/scripts/report_focus_status.sh off
/Users/brighton/Desktop/ProjectFinal/Web/blog/scripts/report_focus_status.sh --heartbeat
```

Important:

- `--heartbeat` only re-sends cached state from `~/.focus-status/state.json`.
- It does not read macOS Focus mode directly.
- Real mode changes must call `on`/`off` (recommended via Shortcuts automations).

### Suggested automation

1. macOS Shortcuts automation (Focus turned ON): run `/Users/brighton/.local/bin/focus_status_push.sh on "<focus-name>"`
2. macOS Shortcuts automation (Focus turned OFF): run `/Users/brighton/.local/bin/focus_status_push.sh off`
3. launchd heartbeat every 5 minutes using:
   - `/Users/brighton/Desktop/ProjectFinal/Web/blog/integrations/focus-status/io.brighton.focus-heartbeat.plist.sample`

This heartbeat prevents false `Offline` status when Focus state stays unchanged for a long time.

### launchd install/reload

```bash
mkdir -p ~/.local/bin
cp /Users/brighton/Desktop/ProjectFinal/Web/blog/scripts/report_focus_status.sh \
  ~/.local/bin/report_focus_status.sh
chmod +x ~/.local/bin/report_focus_status.sh

mkdir -p ~/Library/LaunchAgents
cp /Users/brighton/Desktop/ProjectFinal/Web/blog/integrations/focus-status/io.brighton.focus-heartbeat.plist.sample \
  ~/Library/LaunchAgents/io.brighton.focus-heartbeat.plist

# edit token before loading
sed -i '' 's/replace-with-long-random-token/<your-token>/' \
  ~/Library/LaunchAgents/io.brighton.focus-heartbeat.plist

launchctl bootout gui/$(id -u) ~/Library/LaunchAgents/io.brighton.focus-heartbeat.plist 2>/dev/null || true
launchctl bootstrap gui/$(id -u) ~/Library/LaunchAgents/io.brighton.focus-heartbeat.plist
launchctl kickstart -k gui/$(id -u)/io.brighton.focus-heartbeat
```

Check logs:

```bash
tail -f /tmp/focus-heartbeat.log /tmp/focus-heartbeat.err.log
```
