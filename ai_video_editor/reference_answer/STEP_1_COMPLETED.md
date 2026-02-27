# Step 1 Reference: Completed Plan

This is how a finalized `plan.md` should look before you start setting up cloud services.

## AI Chat Sessions (Examples)

- [Example Prompt with minimal background knowledge #1](https://chat.qwen.ai/s/t_f82d2759-6a33-47c6-8433-5511691582e7?fev=0.2.7)
- [Example Prompt with minimal background knowledge #2](https://chat.qwen.ai/s/t_293138f3-c4d0-4f3e-90ba-15d196359d7f?fev=0.2.7)
<img width="892" height="720" alt="image" src="https://github.com/user-attachments/assets/5984a18c-ee0a-47ee-ae2a-3892267e26a2" />

- [Example Advanced Prompt with some engineering knowledge](https://chat.qwen.ai/s/t_6f78bf9d-1d97-4650-a4b6-577cfc85411e?fev=0.2.7)
<img width="900" height="414" alt="image" src="https://github.com/user-attachments/assets/ea2a7f47-a2c5-4e37-a217-57f2fe75dd82" />
---

## Sample Completed `plan.md`

```markdown
## Project Overview
I want to build an AI-powered video editing tool that uses character swap technology to create personalized promotional campaigns using Alibaba Cloud's WAN Animate Mix API.

## 1. What are you trying to build?
- A web app where users upload a character image and template video
- The system swaps the character in the video using WAN Animate Mix API
- Users can download the personalized video result
- Designed for marketers and content creators making personalized campaigns

## 2. What does 'done' look like?
- Clean web interface with drag-and-drop file upload
- Real-time progress updates during processing
- Secure storage of user videos in OSS
- Downloadable results with shareable links
- Clear error messages for failed uploads/processing
- Basic usage tracking to prevent cost overruns

## 3. What technologies will you use?
- Backend: Node.js with Express
- Frontend: HTML, CSS, Vanilla JavaScript
- API: Alibaba Cloud WAN Animate Mix API
- Storage: Alibaba Cloud OSS
- Environment: Environment variables for API keys

## Additional Requirements
- Security: Never expose API keys in client-side code
- UX: Show loading indicators for long-running tasks
- Cost Control: Limit requests per user/session
- File Validation: Check file types and sizes before upload

## Specific Questions
- How do I set up OSS service accounts with minimal permissions?
- What's the best way to poll the WAN API for task completion?
- Should I store videos temporarily or use direct OSS upload from browser?
- How can I implement a simple queue for multiple video requests?

## Technical Challenges to Address
1. Service Account Setup: Configuring OSS with proper permissions
2. API Integration: Understanding the async task workflow
3. File Management: Handling large file uploads
4. User Experience: Making async processing feel smooth
5. Cost Management: Tracking API usage and implementing safeguards
```

---

## Key Takeaways

- ✅ **Be Specific**: Detail what "personalized promotional campaigns" means
- ✅ **Think About UX**: Real-time progress updates are critical for long tasks
- ✅ **Security First**: Mentioned environment variables early in planning
- ✅ **Cost Awareness**: Included usage tracking as a requirement
- ✅ **Ask Questions**: Listed specific technical questions for the AI

## Next Steps

After completing your plan:
1. ✅ Save it as `plan.md` in your project folder
2. ✅ Review it - does it clearly define your project?
3. ✅ Move to Step 2 to set up Alibaba Cloud account

---

## Sample of advanced plan.md

```markdown
## Project Overview
I want to build an AI-powered video editing tool that uses character swap technology to create personalized promotional campaigns using Alibaba Cloud's WAN Animate Mix API.

## 1. What are you trying to build?
- A web app where users upload a character image and template video
- The system swaps the character in the video using WAN Animate Mix API
- Users can download the personalized video result
- Designed for marketers and content creators making personalized campaigns

## 2. What does 'done' look like?
- ✅ Clean web interface with drag-and-drop file upload
- ✅ Real-time progress updates during processing (with exponential backoff polling)
- ✅ Secure storage of user videos in OSS
- ✅ Downloadable results with shareable links
- ✅ Clear error messages for failed uploads/processing by parsing API json output
- ✅ Basic usage tracking to prevent cost overruns (rate limiting implemented)

## 3. What technologies will you use?
- Backend: Node.js with Express
- Frontend: HTML, CSS, Vanilla JavaScript
- API: Alibaba Cloud WAN Animate Mix API (Singapore region)
- Storage: Alibaba Cloud OSS (for input files and permanent results)
- Environment: Environment variables for API keys

## Additional Requirements
- ✅ Security: Never expose API keys in client-side code
- ✅ UX: Show loading indicators for long-running tasks (progress bar + status text)
- ✅ Cost Control: Limit requests per user/session (10 requests/hour default)
- ✅ File Validation: Check file types and sizes before upload (client + server)

## Specific Questions - ANSWERED

### Q: How do I set up OSS service accounts with minimal permissions?
**A:** Use RAM users with scoped permissions:
OSS_ACCESS_KEY_ID=LTAI...      # RAM user key, not master key
OSS_ACCESS_KEY_SECRET=...
OSS_BUCKET=your-bucket-name
OSS_REGION=oss-ap-southeast-7   # Match your bucket region
**Permissions needed:**
- `oss:PutObject` - Upload files
- `oss:GetObject` - Download results
- **Do NOT grant:** Delete permissions, bucket configuration

---

## Technical Challenges and Solutions

### 1. ✅ Service Account Setup: Configuring OSS with proper permissions
**Solution:** RAM user with `oss:PutObject` and `oss:GetObject` permissions only.

### 2. ✅ API Integration: Understanding the async task workflow
**Solution:** 
- Step 1: POST to create task → get `task_id`
- Step 2: GET `/api/v1/tasks/{task_id}` → poll until `SUCCEEDED`
- Step 3: Download video from returned URL (valid 24 hours only!)

### 3. ✅ File Management: Handling large file uploads
**Solution:** 
- Multer for multipart uploads
- Client-side validation (file type, size, duration)
- Server-side validation (double-check everything)
- OSS for permanent storage

### 4. ✅ User Experience: Making async processing feel smooth
**Solution:**
- Progress bar with gradual updates
- Status text showing current polling frequency
- Time estimates that update based on progress
- Exponential backoff (don't spam API)
- Clear error messages with retry option

---

## Additional Lessons Learned

### ⚠️ Critical: External APIs Need Public URLs
**Problem:** Localhost URLs (`http://localhost:3000/uploads/...`) don't work with external APIs.

**Solution:** Always upload to cloud storage (OSS/S3) first, then use those public URLs.

---

### ⚠️ Critical: Map API Response Fields Correctly
**Problem:** WAN API returns `task_status`, frontend expected `status` → showed "undefined"

**Solution:** Use fallback parsing.
---

### ⚠️ Critical: Log Everything During Development
**Problem:** Hard to trace where data was getting lost.

**Solution:** Comprehensive logging at every step:
- Server: Request params, extracted values, full responses
- Frontend: Response data, field types, polling URLs
- Debug tools: Direct API testing scripts

---

### ⚠️ Critical: Handle Rate Limiting Gracefully
**Problem:** Aggressive polling (every 15s) triggered rate limits.

**Solution:** 
- Exponential backoff strategy
- Detect HTTP 429 and wait 60 seconds
- Show user when rate limited

---

## Production Checklist

### Before Launch
- [ ] Set up production OSS bucket with CORS
- [ ] Configure RAM user with minimal permissions
- [ ] Set up monitoring for API usage
- [ ] Configure alerts for cost thresholds
- [ ] Test with production API key (not free tier)
- [ ] Set up HTTPS (Let's Encrypt or cloud provider)
- [ ] Configure domain and SSL
- [ ] Set up log aggregation (e.g., CloudWatch)
- [ ] Implement database for task persistence
- [ ] Add user authentication (if needed)
- [ ] Set up email notifications for completion
```


[← Back to Step 1](../STEP_1.md) | [Next: Step 2 Reference →](STEP_2_COMPLETED.md)
