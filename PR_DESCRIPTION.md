# Add Kimi/Moonshot AI API Support

## Summary

This PR adds full support for Kimi/Moonshot AI (OpenAI-compatible) API to Moltworker, allowing you to use Kimi's language models instead of or alongside Anthropic Claude.

## Changes

### Core Features
- ✅ Add `OPENAI_BASE_URL` environment variable support for OpenAI-compatible APIs
- ✅ Automatic detection of Kimi/Moonshot AI based on base URL
- ✅ Configure Kimi-specific models with appropriate context windows
- ✅ Maintain backward compatibility with Anthropic and standard OpenAI

### Model Configuration
When Kimi is detected (base URL contains `moonshot.cn`), the system automatically configures:
- **moonshot-v1-128k** (128k context) - Default primary model
- **moonshot-v1-32k** (32k context)
- **moonshot-v1-8k** (8k context)

### Files Modified
- `src/types.ts` - Added `OPENAI_BASE_URL` to environment interface
- `src/gateway/env.ts` - Added logic to pass `OPENAI_BASE_URL` to container
- `start-moltbot.sh` - Added Kimi detection and model configuration logic
- `wrangler.jsonc` - Updated documentation with OpenAI-compatible API instructions

### New Files
- `setup-kimi.sh` - Automated setup script for quick deployment
- `KIMI_SETUP.md` - Comprehensive setup and troubleshooting guide

## Configuration

To use Kimi API, set these secrets:

```bash
echo "your-kimi-api-key" | npx wrangler secret put OPENAI_API_KEY
echo "https://api.moonshot.cn/v1" | npx wrangler secret put OPENAI_BASE_URL
```

Or use the automated setup script:

```bash
./setup-kimi.sh
```

## Testing

- ✅ All TypeScript type checking passed
- ✅ All 83 unit tests passed
- ✅ Verified model configuration logic
- ✅ Tested environment variable mapping

## Deployment

After merging, deploy with your Kimi credentials:

```bash
npm install
./setup-kimi.sh
# OR manually: npm run deploy
```

Your worker will be available at: `https://moltbot-sandbox.mmcdonald.workers.dev`

## Documentation

Complete setup instructions, troubleshooting guide, and configuration details are in `KIMI_SETUP.md`.

---

https://claude.ai/code/session_01S6JNRimtCrDpXQfBBC8S9V
