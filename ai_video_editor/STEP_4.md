# Step 4: Explore the WAN API with Node.js

Now that you have credentials and storage set up, it's time to interact with the WAN Animate Mix API. You'll build a Node.js server to test the video character swap workflow.

## Understanding the WAN API Workflow

The WAN Animate Mix API works asynchronously:

1. **Submit Task**: Send image + video URLs to API → get `task_id`
2. **Poll Status**: Check task status using `task_id` every 15 seconds
3. **Retrieve Result**: When complete, get the output video URL
4. **Download Video**: Save to OSS or provide download link

> [!NOTE]
> Video processing can take **several minutes** depending on video length and queue.

---

## Create Your Node.js Project

### 1. Initialize Project

```bash
mkdir ai-video-editor-server
cd ai-video-editor-server
npm init -y
```

### 2. Install Dependencies

```bash
npm install express dotenv ali-oss node-fetch multer
```

**Packages:**
- `express`: Web server framework
- `dotenv`: Environment variables
- `ali-oss`: Alibaba Cloud OSS SDK
- `node-fetch`: HTTP client for API calls
- `multer`: File upload handling

---

## Build the API Client

### Prompt for AI

> *"Help me create a Node.js module to interact with the WAN Animate Mix API. It should:
> 1. Submit a character swap task with image and video URLs
> 2. Poll the task status until completion
> 3. Return the result video URL
>
> Use the following API endpoints and authentication:
> - Endpoint: https://dashscope-intl.aliyuncs.com/api/v1/services/aigc/image2video/video-synthesis
> - Auth: Bearer token from DASHSCOPE_API_KEY
> - Model: wan2.2-animate-mix"*

