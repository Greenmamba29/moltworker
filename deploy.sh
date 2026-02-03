#!/bin/bash

# Quick Deploy Script for Moltworker with Kimi AI
# Run this on your LOCAL MACHINE

set -e

echo "🚀 Deploying Moltworker with Kimi AI..."
echo ""

# Set the Cloudflare API token
export CLOUDFLARE_API_TOKEN="54Gmw-FZGZoM0Hn1hrirg5CrB2mJUbS7ZebtHcsh"

# Configuration
KIMI_API_KEY="sk-kimi-HLEEHqgmxjmzAP1etHD7EdvICVcQR9Cimb3xKQPfoCKNYzt1D7N1gsS3Ys4GfynM"
KIMI_BASE_URL="https://api.moonshot.cn/v1"
GATEWAY_TOKEN="7fd1fba03d6e798bc64a11d9a34bab65993acd5d0f82e73f922f0e5e96b182c7"
CF_ACCOUNT_ID="ae2e0cf3da72c7c1b71824e551315705"
R2_ACCESS_KEY_ID="8de8b229e570b71345f70b168506d26a"
R2_SECRET_ACCESS_KEY="a977d5e379f6ffbb15399d89a5d14789c435c5d0399467629a770d5849dabc11"

echo "📦 Step 1/8: Setting OPENAI_API_KEY..."
echo "$KIMI_API_KEY" | npx wrangler secret put OPENAI_API_KEY

echo "📦 Step 2/8: Setting OPENAI_BASE_URL..."
echo "$KIMI_BASE_URL" | npx wrangler secret put OPENAI_BASE_URL

echo "📦 Step 3/8: Setting MOLTBOT_GATEWAY_TOKEN..."
echo "$GATEWAY_TOKEN" | npx wrangler secret put MOLTBOT_GATEWAY_TOKEN

echo "📦 Step 4/8: Setting R2_ACCESS_KEY_ID..."
echo "$R2_ACCESS_KEY_ID" | npx wrangler secret put R2_ACCESS_KEY_ID

echo "📦 Step 5/8: Setting R2_SECRET_ACCESS_KEY..."
echo "$R2_SECRET_ACCESS_KEY" | npx wrangler secret put R2_SECRET_ACCESS_KEY

echo "📦 Step 6/8: Setting CF_ACCOUNT_ID..."
echo "$CF_ACCOUNT_ID" | npx wrangler secret put CF_ACCOUNT_ID

echo ""
echo "🏗️  Step 7/8: Building project..."
npm run build

echo ""
echo "🚀 Step 8/8: Deploying to Cloudflare Workers..."
npx wrangler deploy

echo ""
echo "✅ Deployment complete!"
echo ""
echo "🌐 Your worker is live at:"
echo "   https://moltbot-sandbox.mmcdonald.workers.dev"
echo ""
echo "🔑 Gateway Token:"
echo "   $GATEWAY_TOKEN"
echo ""
echo "🤖 Available Kimi Models:"
echo "   - moonshot-v1-128k (128k context) - Default"
echo "   - moonshot-v1-32k (32k context)"
echo "   - moonshot-v1-8k (8k context)"
echo ""
echo "🧪 Test your deployment:"
echo "   curl https://moltbot-sandbox.mmcdonald.workers.dev/models \\"
echo "     -H \"Authorization: Bearer $GATEWAY_TOKEN\""
echo ""
