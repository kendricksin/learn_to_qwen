# Step 2 Reference: Alibaba Cloud Setup Completed

This shows what a successful Alibaba Cloud setup looks like after completing Step 2.

## AI Chat Sessions (Examples)

- [Help me understand Alibaba Cloud regions](#) - _Link to be added_
- [How to secure API keys](#) - _Link to be added_
- [Setting up billing alerts](#) - _Link to be added_

## Screenshots

### Account Setup
_Add screenshots of:_
- [ ] Alibaba Cloud sign-up confirmation
- [ ] Payment method added
- [ ] Model Studio activated
- [ ] OSS service activated

### API Key Generation
_Add screenshots of:_
- [ ] DashScope console showing API key
- [ ] API key creation dialog
- [ ] Region selection (Singapore/Beijing)

### Environment Configuration
_Add screenshot of completed `.env` file (with keys redacted)_

---

## Completed Checklist

After Step 2, you should have:

### ✅ Alibaba Cloud Account
- [x] Account created and verified
- [x] Email and phone verified
- [x] Payment method added
- [x] Identity verification completed (if required)

### ✅ Services Activated
- [x] Model Studio (DashScope) activated
- [x] Object Storage Service (OSS) activated
- [x] Region selected (Singapore or Beijing)

### ✅ API Credentials Obtained
- [x] DashScope API key created
- [x] API key copied to safe location
- [x] Region endpoint noted

### ✅ Local Environment Setup
- [x] `.env.example` copied to `.env`
- [x] `DASHSCOPE_API_KEY` added to `.env`
- [x] `DASHSCOPE_REGION` set correctly
- [x] `.gitignore` verified (`.env` is listed)

### ✅ Billing Protection
- [x] Billing alerts configured
- [x] Monthly spending threshold set
- [x] Email notifications enabled

---

## Sample `.env` File

```bash
# Alibaba Cloud DashScope API Configuration
DASHSCOPE_API_KEY=sk-abc123def456...  # ← Your actual key here
DASHSCOPE_REGION=singapore

# OSS Configuration (will be added in Step 3)
# OSS_ACCESS_KEY_ID=
# OSS_ACCESS_KEY_SECRET=
# OSS_REGION=
# OSS_BUCKET=
```

> **Note**: Your actual API key should be ~40+ characters starting with `sk-`

---

## Test Script Results

After running the test script, you should see:

```bash
$ npm install dotenv
$ node test-api.js

API Key loaded: Yes ✓
Region: singapore
```

---

## Common Issues & Solutions

### ❌ "API Key Invalid"
**Solution**:
- Copy the entire key including `sk-` prefix
- Verify no extra spaces in `.env` file
- Check you're using the correct region endpoint

### ❌ "Service Not Activated"
**Solution**:
- Go to Alibaba Cloud console
- Search for "Model Studio" and activate
- Wait 2-3 minutes for activation
- Refresh your API key page

### ❌ "Payment Method Required"
**Solution**:
- Add credit/debit card in Billing Management
- Some regions may require identity verification
- Use international card for Singapore region

---

## Pro-Tips

💡 **API Key Security**:
- Never share your API key in screenshots
- Use environment variables, not hardcoded strings
- Rotate keys regularly for production apps

💡 **Cost Monitoring**:
- Check the DashScope pricing page
- Enable billing alerts at $5, $20, $50 thresholds
- Review usage weekly while testing

💡 **Region Selection**:
- Singapore: Lower latency for international users
- Beijing: Required for China mainland projects
- Can't switch regions without new API key

---

[← Back to Step 2](../STEP_2.md) | [Next: Step 3 Reference →](STEP_3_COMPLETED.md)
