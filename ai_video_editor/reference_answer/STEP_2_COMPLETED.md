# Step 2 Reference: Alibaba Cloud Setup Completed

This shows what a successful Alibaba Cloud setup looks like after completing Step 2.

## AI Chat Sessions (Examples)

- [How to create alibaba cloud account and start using the various cloud services?](https://chat.qwen.ai/s/t_c0ecfb10-1409-4e73-b940-bf6b284a4b8b?fev=0.2.7)
- [How do i get my API keys and make sure that it is securely stored?](https://chat.qwen.ai/s/t_510c1313-b8ba-4460-bc8f-c801b8a0ef83?fev=0.2.7)
- [How do I make sure to stay within free tier usage?](https://chat.qwen.ai/s/t_a1bdbce8-49da-42b5-b937-521fdf7b8083?fev=0.2.7)

### Account Setup
![6109499075309800932](https://github.com/user-attachments/assets/58ed0258-73ec-493d-bc3f-0d8072f5975c)
![6109499075309800931](https://github.com/user-attachments/assets/7d407903-c79b-45a7-9ff3-01d99192926b)
![6109499075309800933](https://github.com/user-attachments/assets/90b5435b-4fbc-417b-bf82-73ed97ba311e)
![6109499075309800934](https://github.com/user-attachments/assets/ed81f071-9d45-42cb-af5d-6e41b6a515fb)
![6109499075309800924](https://github.com/user-attachments/assets/e6c04872-d04b-4cee-acf4-21a1596a9feb)
![6109499075309800916](https://github.com/user-attachments/assets/3c4fdcf4-1fb3-465c-8ed6-de3eec054ad9)

### API Key Generation
![6109499075309800918](https://github.com/user-attachments/assets/010e05d2-0010-4cfc-99a8-c021343d7a4e)
![6109499075309800920](https://github.com/user-attachments/assets/f2782e01-d140-4ac8-86ad-f13f9bc69982)
<img width="1920" height="856" alt="image" src="https://github.com/user-attachments/assets/faf87fe1-86ed-4d1c-aca2-aa30388843ef" />

### OSS Activation
![6109499075309800921](https://github.com/user-attachments/assets/c05081f7-0e23-4d2a-8e45-0c2a621e7c16)
![6109499075309800919](https://github.com/user-attachments/assets/46e3a559-31ff-45cd-8f4b-b86087bc5624)


### Environment Configuration
<img width="1548" height="997" alt="image" src="https://github.com/user-attachments/assets/852d37b5-2fee-46d3-a684-14672988cd87" />
<img width="1540" height="929" alt="image" src="https://github.com/user-attachments/assets/9866f3a2-7cb2-4f78-90e3-d8294e726794" />


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
