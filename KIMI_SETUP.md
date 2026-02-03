# Moltworker - Kimi/Moonshot AI Setup Guide

This guide explains how to configure Moltworker to use Kimi (Moonshot AI) instead of the default Anthropic Claude API.

## Overview

Moltworker now supports OpenAI-compatible APIs, including Kimi/Moonshot AI. The codebase automatically detects when you're using Kimi and configures the appropriate models:

- **moonshot-v1-128k** (128k context window) - Default
- **moonshot-v1-32k** (32k context window)
- **moonshot-v1-8k** (8k context window)

## Your Configuration

### Account Details
- **Account ID**: `ae2e0cf3da72c7c1b71824e551315705`
- **Subdomain**: `mmcdonald.workers.dev`
- **Worker URL**: `https://moltbot-sandbox.mmcdonald.workers.dev`

### API Keys & Secrets
- **Kimi API Key**: `sk-kimi-HLEEHqgmxjmzAP1etHD7EdvICVcQR9Cimb3xKQPfoCKNYzt1D7N1gsS3Ys4GfynM`
- **Kimi Base URL**: `https://api.moonshot.cn/v1`
- **Gateway Token**: `7fd1fba03d6e798bc64a11d9a34bab65993acd5d0f82e73f922f0e5e96b182c7`

### R2 Storage Credentials
- **Access Key ID**: `8de8b229e570b71345f70b168506d26a`
- **Secret Access Key**: `a977d5e379f6ffbb15399d89a5d14789c435c5d0399467629a770d5849dabc11`
- **S3 API Endpoint**: `https://ae2e0cf3da72c7c1b71824e551315705.r2.cloudflarestorage.com`

## Quick Setup (Automated)

Run the provided setup script to automatically configure all secrets and deploy:

```bash
./setup-kimi.sh
```

This script will:
1. Set all required Cloudflare Workers secrets
2. Build the project
3. Deploy to Cloudflare Workers

## Manual Setup

If you prefer to configure secrets manually:

### 1. Install Dependencies

```bash
npm install
```

### 2. Configure Secrets

Set each secret using `wrangler secret put`:

```bash
# Kimi API Configuration
echo "sk-kimi-HLEEHqgmxjmzAP1etHD7EdvICVcQR9Cimb3xKQPfoCKNYzt1D7N1gsS3Ys4GfynM" | npx wrangler secret put OPENAI_API_KEY
echo "https://api.moonshot.cn/v1" | npx wrangler secret put OPENAI_BASE_URL

# Gateway Token
echo "7fd1fba03d6e798bc64a11d9a34bab65993acd5d0f82e73f922f0e5e96b182c7" | npx wrangler secret put MOLTBOT_GATEWAY_TOKEN

# R2 Storage
echo "8de8b229e570b71345f70b168506d26a" | npx wrangler secret put R2_ACCESS_KEY_ID
echo "a977d5e379f6ffbb15399d89a5d14789c435c5d0399467629a770d5849dabc11" | npx wrangler secret put R2_SECRET_ACCESS_KEY
echo "ae2e0cf3da72c7c1b71824e551315705" | npx wrangler secret put CF_ACCOUNT_ID
```

### 3. Build and Deploy

```bash
npm run deploy
```

## Verifying the Setup

After deployment, you can verify your setup by:

1. **Check the worker logs**:
   ```bash
   npx wrangler tail
   ```

2. **Visit the admin UI**:
   ```
   https://moltbot-sandbox.mmcdonald.workers.dev
   ```

3. **Check available models via API**:
   ```bash
   curl https://moltbot-sandbox.mmcdonald.workers.dev/models \
     -H "Authorization: Bearer 7fd1fba03d6e798bc64a11d9a34bab65993acd5d0f82e73f922f0e5e96b182c7"
   ```

   You should see the three Kimi models listed.

## How It Works

### Automatic Kimi Detection

The system automatically detects Kimi/Moonshot AI when:
- `OPENAI_BASE_URL` contains `moonshot.cn`, OR
- The base URL is explicitly set to a Moonshot endpoint

When detected, the system:
1. Configures the OpenAI provider with Moonshot's base URL
2. Loads Kimi-specific models (moonshot-v1-128k, moonshot-v1-32k, moonshot-v1-8k)
3. Sets `moonshot-v1-128k` as the default model

### Code Changes

The following files were modified to support Kimi:

1. **src/types.ts**: Added `OPENAI_BASE_URL` environment variable
2. **src/gateway/env.ts**: Added logic to pass `OPENAI_BASE_URL` to the container
3. **start-moltbot.sh**: Added Kimi detection and model configuration
4. **wrangler.jsonc**: Updated documentation comments

## Switching Between Providers

To switch between different LLM providers:

### Use Anthropic Claude
```bash
echo "your-anthropic-key" | npx wrangler secret put ANTHROPIC_API_KEY
# Remove OPENAI_BASE_URL if set
npx wrangler secret delete OPENAI_BASE_URL
npm run deploy
```

### Use OpenAI
```bash
echo "your-openai-key" | npx wrangler secret put OPENAI_API_KEY
echo "https://api.openai.com/v1" | npx wrangler secret put OPENAI_BASE_URL
npm run deploy
```

### Use Kimi (Moonshot AI)
```bash
echo "your-kimi-key" | npx wrangler secret put OPENAI_API_KEY
echo "https://api.moonshot.cn/v1" | npx wrangler secret put OPENAI_BASE_URL
npm run deploy
```

## Troubleshooting

### Issue: Worker fails to start
- Check wrangler logs: `npx wrangler tail`
- Verify all secrets are set: `npx wrangler secret list`

### Issue: API calls failing
- Verify your Kimi API key is valid
- Check Kimi API usage limits and quota
- Ensure R2 bucket exists: `npx wrangler r2 bucket list`

### Issue: Models not showing up
- Check that `OPENAI_BASE_URL` is set correctly
- Verify the base URL contains `moonshot.cn`
- Check container logs for "Configuring OpenAI provider" message

## Testing

Run the test suite to verify all changes:

```bash
# Type checking
npm run typecheck

# Unit tests
npm test

# Run with coverage
npm run test:coverage
```

All tests should pass (83 tests).

## Additional Resources

- [Kimi API Documentation](https://platform.moonshot.cn/docs)
- [Cloudflare Workers Documentation](https://developers.cloudflare.com/workers/)
- [Wrangler CLI Reference](https://developers.cloudflare.com/workers/wrangler/)
- [Moltbot Repository](https://github.com/Greenmamba29/moltworker)

## Support

If you encounter any issues:
1. Check the troubleshooting section above
2. Review wrangler logs: `npx wrangler tail`
3. Open an issue on GitHub: https://github.com/Greenmamba29/moltworker/issues
