# OpenClaw Cloud (Railway 部署)

24/7 在线版 OpenClaw，配 WeChat Webhook 接入。

## 当前状态
- 平台：Railway
- 仓库：https://github.com/qds147/openclaw-ytt
- 计划：手机 24h 可用微信通道

## Railway 必填环境变量

去 Railway → openclaw-ytt 服务 → Variables，加：

| 变量 | 必填 | 说明 |
|------|------|------|
| `ANTHROPIC_API_KEY` | ✅ | 从 https://console.anthropic.com/settings/keys 申请 |
| `OPENCLAW_GATEWAY_TOKEN` | ✅ | 自定一个长字符串（防止外人访问 gateway） |
| `OPENCLAW_GATEWAY_PORT` | 自动 | Railway 自动注入 PORT，脚本里自动转 |
| `OPENCLAW_CONFIG_PATH` | 可选 | 留空走默认 `/data/.openclaw/openclaw.json` |
| `TAILSCALE_AUTHKEY` | 暂缓 | Tailscale 接入时再加 |

## 启动流程
1. 用户点 "Apply 3 changes"
2. NIXPACKS 构建（装 openclaw 包，2-3 分钟）
3. start.sh 启动 gateway
4. 看 Deploy Logs 应有 "Gateway listening on 0.0.0.0:8080"

## 本地命令对照
```bash
# 本地
openclaw gateway --port 18789
# Railway（容器内）
openclaw gateway --port 8080 --bind lan --verbose
```

## 故障排查
- `Unknown command: openclaw start` → 旧版脚本，已修
- `refusing to bind gateway without auth` → 检查 OPENCLAW_GATEWAY_TOKEN 是否设
- `EADDRINUSE` → Railway 自动 restart，忽略

## 后续
- Tailscale 隧道（手机直连）
- Sleep 插件（23:00-07:00 休眠，省 Railway 小时数）
- WeChat Webhook 通道（核心需求）