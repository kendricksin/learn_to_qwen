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

### Expected Output Structure

The AI should help you create something like:

```javascript
// wan-client.js
require('dotenv').config();
const fetch = require('node-fetch');

class WANClient {
  constructor(apiKey, region = 'singapore') {
    this.apiKey = apiKey;
    this.baseUrl = region === 'singapore'
      ? 'https://dashscope-intl.aliyuncs.com'
      : 'https://dashscope.aliyuncs.com';
  }

  async createTask(imageUrl, videoUrl) {
    // Submit task to WAN API
    // Return task_id
  }

  async getTaskStatus(taskId) {
    // Query task status
    // Return status and result
  }

  async waitForCompletion(taskId, pollInterval = 15000) {
    // Poll until task completes
    // Return final result
  }
}

module.exports = WANClient;
```

---

## Test the API with Sample Files

### 1. Upload Test Files to OSS

**Prompt for AI:**
> *"Create a script to upload a sample image and video to my OSS bucket and get their public URLs for testing the WAN API."*

```javascript
// upload-test-files.js
const OSS = require('ali-oss');
require('dotenv').config();

async function uploadTestFiles() {
  const client = new OSS({
    region: process.env.OSS_REGION,
    accessKeyId: process.env.OSS_ACCESS_KEY_ID,
    accessKeySecret: process.env.OSS_ACCESS_KEY_SECRET,
    bucket: process.env.OSS_BUCKET
  });

  // Upload test image (character)
  const imageResult = await client.put(
    'uploads/images/test-character.jpg',
    './test-character.jpg'
  );

  // Upload test video (template)
  const videoResult = await client.put(
    'uploads/videos/test-template.mp4',
    './test-template.mp4'
  );

  console.log('Image URL:', imageResult.url);
  console.log('Video URL:', videoResult.url);
}

uploadTestFiles();
```

### 2. Run Your First Character Swap

**Prompt for AI:**
> *"Create a test script that uses my WAN API client to swap a character in a video. It should submit the task, poll for completion, and print the result URL."*

```javascript
// test-swap.js
const WANClient = require('./wan-client');
require('dotenv').config();

async function testCharacterSwap() {
  const client = new WANClient(process.env.DASHSCOPE_API_KEY);

  const imageUrl = 'https://your-bucket.oss-region.aliyuncs.com/uploads/images/test-character.jpg';
  const videoUrl = 'https://your-bucket.oss-region.aliyuncs.com/uploads/videos/test-template.mp4';

  console.log('🚀 Submitting task...');
  const taskId = await client.createTask(imageUrl, videoUrl);
  console.log('📋 Task ID:', taskId);

  console.log('⏳ Waiting for completion...');
  const result = await client.waitForCompletion(taskId);

  console.log('✅ Done!');
  console.log('🎥 Result URL:', result.video_url);
}

testCharacterSwap().catch(console.error);
```

Run it:
```bash
node test-swap.js
```

---

## Build a Simple Express Server

Now create a server that exposes the WAN API functionality via HTTP endpoints.

### Prompt for AI

> *"Create an Express server with the following endpoints:
> 1. POST /upload - Accept image and video file uploads, save to OSS
> 2. POST /swap - Submit character swap task, return task_id
> 3. GET /status/:taskId - Check task status
> 4. GET /result/:taskId - Get final video URL when ready
>
> Use environment variables for credentials and include error handling."*

### Expected Server Structure

```javascript
// server.js
const express = require('express');
const multer = require('multer');
const OSS = require('ali-oss');
const WANClient = require('./wan-client');
require('dotenv').config();

const app = express();
const upload = multer({ dest: 'uploads/' });

// Initialize clients
const ossClient = new OSS({ /* config */ });
const wanClient = new WANClient(process.env.DASHSCOPE_API_KEY);

// Endpoints
app.post('/upload', upload.fields([...]), async (req, res) => {
  // Upload files to OSS
  // Return URLs
});

app.post('/swap', async (req, res) => {
  // Submit swap task
  // Return task_id
});

app.get('/status/:taskId', async (req, res) => {
  // Check task status
});

app.listen(3000, () => console.log('Server running on port 3000'));
```

---

## Test Your Server

### Using curl:

```bash
# Upload files
curl -F "image=@character.jpg" -F "video=@template.mp4" http://localhost:3000/upload

# Submit swap task
curl -X POST http://localhost:3000/swap \
  -H "Content-Type: application/json" \
  -d '{"imageUrl":"...","videoUrl":"..."}'

# Check status
curl http://localhost:3000/status/TASK_ID
```

### Using Postman or Thunder Client:

Ask your AI assistant:
> *"How do I test file upload endpoints using Postman?"*

---

## Handle Common API Issues

### Rate Limiting
**Prompt for AI:**
> *"How can I implement rate limiting in my Express server to prevent too many API calls?"*

### Task Timeouts
**Prompt for AI:**
> *"What should I do if a WAN API task takes too long or fails?"*

### Error Responses
**Prompt for AI:**
> *"Help me add comprehensive error handling for WAN API responses and OSS upload failures."*

---

## Understanding API Response Formats

### Successful Task Creation:
```json
{
  "request_id": "abc-123",
  "output": {
    "task_id": "task-xyz-789"
  }
}
```

### Task Status (Processing):
```json
{
  "output": {
    "task_status": "RUNNING",
    "task_id": "task-xyz-789"
  }
}
```

### Task Status (Complete):
```json
{
  "output": {
    "task_status": "SUCCEEDED",
    "task_id": "task-xyz-789",
    "video_url": "https://dashscope-result.oss-cn-beijing.aliyuncs.com/..."
  }
}
```

---

## Save Results to Your OSS

The WAN API returns a temporary URL (expires in 24 hours). Download and save to your OSS:

**Prompt for AI:**
> *"Create a function that downloads a video from a URL and uploads it to my OSS bucket for permanent storage."*

---

## Pro-Tips

- **Logging**: Add detailed logs for debugging API issues
- **Retry Logic**: Implement retries for failed API calls
- **Queue System**: Use a simple queue for handling multiple requests
- **Webhooks**: Consider webhooks instead of polling for production
- **Cost Tracking**: Log each API call to monitor usage

> [!TIP]
> **See a finished example:** [STEP_4_COMPLETED.md](./reference_answer/STEP_4_COMPLETED.md)

---

[← Step 3: Configure OSS](STEP_3.md) | [Next Step: Create User Interface →](STEP_5.md)
