#!/usr/bin/env bash
set -euo pipefail

# Usage:
#   report_focus_status.sh on "Deep Work"
#   report_focus_status.sh off
#   report_focus_status.sh --heartbeat
#
# Notes:
#   --heartbeat only replays cached state from FOCUS_STATE_FILE.
#   It does NOT query macOS Focus mode in real time.
#
# Required env:
#   FOCUS_API_ENDPOINT="https://<worker-domain>/v1/focus/update"
#   FOCUS_API_TOKEN="<token>"
# Optional env:
#   FOCUS_STATE_FILE="$HOME/.focus-status/state.json"

FOCUS_API_ENDPOINT="${FOCUS_API_ENDPOINT:-}"
FOCUS_API_TOKEN="${FOCUS_API_TOKEN:-}"
FOCUS_STATE_FILE="${FOCUS_STATE_FILE:-$HOME/.focus-status/state.json}"
FOCUS_DEVICE_NAME="${FOCUS_DEVICE_NAME:-$(scutil --get ComputerName 2>/dev/null || hostname)}"

if [[ -z "$FOCUS_API_ENDPOINT" || -z "$FOCUS_API_TOKEN" ]]; then
  echo "Missing env: FOCUS_API_ENDPOINT and FOCUS_API_TOKEN are required." >&2
  exit 1
fi

mkdir -p "$(dirname "$FOCUS_STATE_FILE")"

normalize_mode() {
  local raw="$1"
  local lower
  lower="$(echo "$raw" | tr '[:upper:]' '[:lower:]')"
  case "$lower" in
    on|true|1|focus|focused|active) echo "true" ;;
    off|false|0|idle|inactive|available) echo "false" ;;
    *)
      echo "Invalid mode: $raw. Use on/off or --heartbeat." >&2
      exit 1
      ;;
  esac
}

escape_json() {
  printf '%s' "$1" | sed -e 's/\\/\\\\/g' -e 's/"/\\"/g'
}

read_cache_or_default() {
  if [[ -f "$FOCUS_STATE_FILE" ]]; then
    cat "$FOCUS_STATE_FILE"
    return
  fi
  echo '{"focus_mode":false,"focus_name":""}'
}

write_cache() {
  local focus_mode="$1"
  local focus_name="$2"
  printf '{"focus_mode":%s,"focus_name":"%s"}\n' \
    "$focus_mode" \
    "$(escape_json "$focus_name")" > "$FOCUS_STATE_FILE"
}

FOCUS_MODE=""
FOCUS_NAME=""
FOCUS_SOURCE="mac-script"

if [[ "${1:-}" == "--heartbeat" ]]; then
  cached="$(read_cache_or_default)"
  # Parse with awk for macOS/BSD compatibility (sed BRE alternation differs).
  FOCUS_MODE="$(printf '%s' "$cached" | awk '
    match($0, /"focus_mode"[[:space:]]*:[[:space:]]*(true|false)/) {
      text = substr($0, RSTART, RLENGTH);
      sub(/.*:/, "", text);
      gsub(/[[:space:]]*/, "", text);
      print text;
      exit;
    }
  ')"
  FOCUS_NAME="$(printf '%s' "$cached" | awk -F'"focus_name"[[:space:]]*:[[:space:]]*"' '
    NF > 1 {
      split($2, arr, "\"");
      print arr[1];
      exit;
    }
  ')"
  FOCUS_MODE="${FOCUS_MODE:-false}"
  FOCUS_NAME="${FOCUS_NAME:-}"
  FOCUS_SOURCE="mac-heartbeat-cache"
else
  if [[ $# -lt 1 ]]; then
    echo "Usage: $0 on|off [focus_name] | --heartbeat" >&2
    exit 1
  fi
  FOCUS_MODE="$(normalize_mode "${1:-}")"
  FOCUS_NAME="${2:-}"
  write_cache "$FOCUS_MODE" "$FOCUS_NAME"
  FOCUS_SOURCE="mac-manual-update"
fi

PAYLOAD="$(printf '{"focus_mode":%s,"focus_name":"%s","device":"%s","source":"%s"}' \
  "$FOCUS_MODE" \
  "$(escape_json "$FOCUS_NAME")" \
  "$(escape_json "$FOCUS_DEVICE_NAME")" \
  "$(escape_json "$FOCUS_SOURCE")")"

curl --fail --silent --show-error \
  --request POST "$FOCUS_API_ENDPOINT" \
  --header "Content-Type: application/json" \
  --header "Authorization: Bearer $FOCUS_API_TOKEN" \
  --data "$PAYLOAD" >/dev/null

echo "Focus status sent: mode=$FOCUS_MODE name='$FOCUS_NAME' source='$FOCUS_SOURCE'"
