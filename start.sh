#!/usr/bin/env bash
set -e
export PORT="${PORT:-8080}"
export OPENCLAW_GATEWAY_PORT="${PORT}"
echo "[start.sh] PORT=$PORT"
echo "[start.sh] NODE_VERSION: $(node -v)"
echo "[start.sh] OPENCLAW_HOME: ${OPENCLAW_HOME:-/data/.openclaw}"
echo "[start.sh] OPENCLAW_STATE_DIR: ${OPENCLAW_STATE_DIR:-/data/.openclaw/state}"
echo "[start.sh] OPENCLAW_CONFIG_PATH: ${OPENCLAW_CONFIG_PATH:-/data/.openclaw/openclaw.json}"
echo "[start.sh] Token configured: $([ -n "$OPENCLAW_GATEWAY_TOKEN" ] && echo yes || echo NO)"
echo "[start.sh] Anthropic key: $([ -n "$ANTHROPIC_API_KEY" ] && echo "set (${#ANTHROPIC_API_KEY} chars)" || echo MISSING)"

# 准备数据目录（Railway 的 /data 是持久化卷）
mkdir -p /data/.openclaw/state
mkdir -p /data/workspace

# 如果 config 路径是默认且仓库里有 openclaw.json，复制到 data 目录
if [ "$OPENCLAW_CONFIG_PATH" = "/data/.openclaw/openclaw.json" ] && [ -f /app/openclaw.json ] && [ ! -f /data/.openclaw/openclaw.json ]; then
    echo "[start.sh] seeding openclaw.json from repo to /data/.openclaw/"
    cp /app/openclaw.json /data/.openclaw/openclaw.json
fi

echo "[start.sh] launching: openclaw gateway --port $PORT --bind lan --verbose"
exec openclaw gateway --port "$PORT" --bind lan --verbose