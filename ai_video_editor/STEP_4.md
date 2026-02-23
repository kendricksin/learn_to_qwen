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

## Test the WAN API Directly

Before building your server, test the WAN API endpoints directly to understand how they work.

### Recommended Testing Workflow

We'll use two shell scripts to test the APIs in sequence:

1. **test-oss-upload.sh** - Tests OSS upload functionality
2. **test-wan-2.2.sh** - Tests WAN 2.2 Animate Mix API

### 1. Test OSS Upload First

Run the OSS upload test script:

```bash
# Make executable and run
chmod +x test-oss-upload.sh
./test-oss-upload.sh
```

This script will:
- Upload local files to the server
- Server stores them in OSS
- Return public URLs for the uploaded files
- Display the URLs for use with the WAN API

### 2. Test WAN 2.2 Animate Mix API

Run the WAN API test script:

```bash
# Make executable and run
chmod +x test-wan-2.2.sh
./test-wan-2.2.sh
```

This script will:
- Use the OSS URLs from your upload
- Call the WAN 2.2 Animate Mix API directly
- Submit a character animation task
- Poll for completion (every 30s for up to 5 minutes)
- Display the final video URL when complete

### Manual Testing (Alternative)

If you prefer to test manually with cURL:

```bash
# Test WAN API task creation (replace with your actual public image/video URLs)
curl -X POST https://dashscope-intl.aliyuncs.com/api/v1/services/aigc/image2video/video-synthesis \
  -H "Authorization: Bearer YOUR_API_KEY_HERE" \
  -H "Content-Type: application/json" \
  -H "X-DashScope-Async: enable" \
  -d '{
    "model": "wan2.2-animate-mix",
    "input": {
      "image_url": "https://your-public-image-url.jpg",
      "video_url": "https://your-public-video-url.mp4"
    },
    "parameters": {
      "service_mode": "wan-std",
      "mode": "wan-std"
    }
  }'
```

> [!NOTE]
> Replace `YOUR_API_KEY_HERE` with your actual API key and use publicly accessible image/video URLs for testing.

### Test Task Status Check

Once you get a task ID from the previous step, test checking the status:

```bash
curl -X GET https://dashscope-intl.aliyuncs.com/api/v1/tasks/TASK_ID_HERE \
  -H "Authorization: Bearer YOUR_API_KEY_HERE"
```

---

## Create Your Node.js Project

Now that you've verified the API works, create your server project:

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
> - Model: wan2.5-character-animator"*

