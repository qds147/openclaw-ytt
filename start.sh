#!/usr/bin/env bash
set -e
set -x
export PORT="${PORT:-8080}"
export OPENCLAW_HOME="/data/.openclaw"
export OPENCLAW_STATE_DIR="/data/.openclaw/state"
export OPENCLAW_CONFIG_PATH="/app/openclaw.json"

mkdir -p "$OPENCLAW_STATE_DIR" /data/workspace

echo "[start.sh] === OpenClaw Cloud Gateway ==="
echo "[start.sh] PORT=$PORT"
echo "[start.sh] NODE: $(node -v)"
echo "[start.sh] Config path: $OPENCLAW_CONFIG_PATH"
echo "[start.sh] Config exists: $([ -f "$OPENCLAW_CONFIG_PATH" ] && echo yes || echo NO)"
echo "[start.sh] Token configured: $([ -n "$OPENCLAW_GATEWAY_TOKEN" ] && echo "yes (${#OPENCLAW_GATEWAY_TOKEN} chars)" || echo "NO")"
echo "[start.sh] Anthropic key: $([ -n "$ANTHROPIC_API_KEY" ] && echo "set (${#ANTHROPIC_API_KEY} chars)" || echo "MISSING")"

exec openclaw --dev gateway --port "$PORT" --bind lan --allow-unconfigured --verbose