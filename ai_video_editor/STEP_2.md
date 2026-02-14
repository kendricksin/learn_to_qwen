# Step 2: Set Up Alibaba Cloud Account

Before you can use the WAN Animate Mix API, you need to set up your Alibaba Cloud account and obtain API credentials.

## Prerequisites

- A valid email address
- A phone number for verification
- A credit/debit card for account verification (required for API access)

---

## Create Your Alibaba Cloud Account

### 1. Sign Up

Visit [Alibaba Cloud](https://www.alibabacloud.com/) and click "Free Account" or "Sign Up"

- Use your email to create an account
- Verify your email address
- Complete phone verification

### 2. Add Payment Method

> [!IMPORTANT]
> Alibaba Cloud requires a payment method to activate API services, even if you're using free tier.

- Go to **Billing Management** in the console
- Add a credit/debit card
- Some services may require identity verification (passport/ID)

### 3. Activate Required Services

You'll need to activate two services:

1. **Model Studio** (for WAN Animate Mix API)
   - Search for "Model Studio" in the console
   - Click "Activate" and accept terms

2. **Object Storage Service (OSS)**
   - Search for "OSS" in the console
   - Click "Activate" and accept terms

---

## Get Your API Key

### For WAN Animate Mix API:

1. Go to [Alibaba Cloud Console](https://www.alibabacloud.com/console)
2. Navigate to **DashScope** or **Model Studio**
3. Find the **API Keys** section
4. Click "Create API Key" or copy existing key
5. **Important**: Choose the correct region
   - **Singapore Region**: For international use
   - **Beijing Region**: For China mainland use

> [!WARNING]
> **Keep your API key secret!** Never commit it to Git or share it publicly.

### Save Your API Key Securely

> [!IMPORTANT]
> If you haven't already, copy the environment template:
> ```bash
> cp .env.example .env
> ```

Now edit your `.env` file and add your actual API key:

```bash
# .env
DASHSCOPE_API_KEY=sk-your-actual-api-key-here  # Replace with your real key!
DASHSCOPE_REGION=singapore  # or 'beijing'
```

**Verify your `.gitignore` includes `.env`** (it should already be there):

```bash
cat .gitignore | grep .env
```

You should see `.env` listed. This prevents accidental commits of your secrets.

---

## Understanding Regions and Endpoints

The WAN API has different endpoints based on region:

### Singapore Region (International)
```
Create Task: POST https://dashscope-intl.aliyuncs.com/api/v1/services/aigc/image2video/video-synthesis
Query Task: GET https://dashscope-intl.aliyuncs.com/api/v1/tasks/{task_id}
```

### Beijing Region (China Mainland)
```
Create Task: POST https://dashscope.aliyuncs.com/api/v1/services/aigc/image2video/video-synthesis
Query Task: GET https://dashscope.aliyuncs.com/api/v1/tasks/{task_id}
```

> [!NOTE]
> **API keys are region-specific** - a Singapore key won't work with Beijing endpoints and vice versa.

---

## Set Up Billing Alerts (Recommended)

To avoid unexpected costs:

1. Go to **Billing Management** → **Billing Alerts**
2. Set a monthly spending threshold (e.g., $10)
3. Add your email for notifications
4. Monitor usage regularly

---

## Test Your API Key

Ask your AI assistant to create a simple test script:

> *"Create a Node.js script to test my DashScope API key by making a simple API call."*

The AI should provide something like:

```javascript
// test-api.js
require('dotenv').config();
const apiKey = process.env.DASHSCOPE_API_KEY;

console.log('API Key loaded:', apiKey ? 'Yes ✓' : 'No ✗');
console.log('Region:', process.env.DASHSCOPE_REGION);

// Test API connection (basic health check)
```

Run it:
```bash
npm install dotenv
node test-api.js
```

---

## Common Issues

### "API Key Invalid"
- Check you copied the entire key (starts with `sk-`)
- Verify you're using the correct region endpoint
- Ensure the key hasn't been deleted or deactivated

### "Service Not Activated"
- Go back to console and activate Model Studio
- Wait a few minutes for activation to complete
- Try refreshing your API key

### "Payment Method Required"
- Add a valid credit/debit card to your account
- Some services require identity verification

---

## Pro-Tips

- **Multiple Keys**: Create separate API keys for development and production
- **Key Rotation**: Regularly rotate your API keys for security
- **Environment Variables**: Use different `.env` files for different environments
- **Documentation**: Bookmark the [WAN API Docs](https://www.alibabacloud.com/help/en/model-studio/wan-animate-mix-api)

> [!TIP]
> **See a finished example:** [STEP_2_COMPLETED.md](./reference_answer/STEP_2_COMPLETED.md)

---

[← Step 1: Planning](STEP_1.md) | [Next Step: Configure OSS Storage →](STEP_3.md)
