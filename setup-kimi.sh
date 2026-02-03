#!/bin/bash

# Setup script for Moltworker with Kimi/Moonshot AI
# This script configures all necessary secrets and deploys to Cloudflare Workers

set -e

echo "======================================"
echo "Moltworker Kimi API Setup Script"
echo "======================================"
echo ""

# Configuration variables
KIMI_API_KEY="sk-kimi-HLEEHqgmxjmzAP1etHD7EdvICVcQR9Cimb3xKQPfoCKNYzt1D7N1gsS3Ys4GfynM"
KIMI_BASE_URL="https://api.moonshot.cn/v1"
GATEWAY_TOKEN="7fd1fba03d6e798bc64a11d9a34bab65993acd5d0f82e73f922f0e5e96b182c7"
CF_ACCOUNT_ID="ae2e0cf3da72c7c1b71824e551315705"
R2_ACCESS_KEY_ID="8de8b229e570b71345f70b168506d26a"
R2_SECRET_ACCESS_KEY="a977d5e379f6ffbb15399d89a5d14789c435c5d0399467629a770d5849dabc11"

echo "Step 1: Setting OPENAI_API_KEY (Kimi API Key)..."
echo "$KIMI_API_KEY" | npx wrangler secret put OPENAI_API_KEY

echo ""
echo "Step 2: Setting OPENAI_BASE_URL (Kimi API Endpoint)..."
echo "$KIMI_BASE_URL" | npx wrangler secret put OPENAI_BASE_URL

echo ""
echo "Step 3: Setting MOLTBOT_GATEWAY_TOKEN..."
echo "$GATEWAY_TOKEN" | npx wrangler secret put MOLTBOT_GATEWAY_TOKEN

echo ""
echo "Step 4: Setting R2_ACCESS_KEY_ID..."
echo "$R2_ACCESS_KEY_ID" | npx wrangler secret put R2_ACCESS_KEY_ID

echo ""
echo "Step 5: Setting R2_SECRET_ACCESS_KEY..."
echo "$R2_SECRET_ACCESS_KEY" | npx wrangler secret put R2_SECRET_ACCESS_KEY

echo ""
echo "Step 6: Setting CF_ACCOUNT_ID..."
echo "$CF_ACCOUNT_ID" | npx wrangler secret put CF_ACCOUNT_ID

echo ""
echo "======================================"
echo "Secrets configured successfully!"
echo "======================================"
echo ""
echo "Step 7: Building and deploying to Cloudflare Workers..."
npm run deploy

echo ""
echo "======================================"
echo "Deployment complete!"
echo "======================================"
echo ""
echo "Your Moltworker is now configured with Kimi AI and deployed to:"
echo "https://moltbot-sandbox.mmcdonald.workers.dev"
echo ""
echo "Available Kimi models:"
echo "  - moonshot-v1-128k (default)"
echo "  - moonshot-v1-32k"
echo "  - moonshot-v1-8k"
echo ""
echo "Gateway Token: $GATEWAY_TOKEN"
echo ""
