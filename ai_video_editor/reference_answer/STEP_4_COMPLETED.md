# Step 4 Reference: WAN API Integration Completed

This shows what a working WAN API integration looks like after completing Step 4.

## AI Chat Sessions (Examples)

- [Help me create a node.js server to test the WAN Animate API endpoint](https://chat.qwen.ai/s/t_c3b2f6ee-f9ee-42df-bf76-147de1bb1b48?fev=0.2.7)
- [Help me write a shell script to test oss upload via cli](https://chat.qwen.ai/s/t_ff6b5bcc-5ad5-4d3b-b7eb-1d39d65fc677?fev=0.2.7)
- [How to install ossutil](https://chat.qwen.ai/s/t_8447d763-186b-4783-90db-0457867428c7?fev=0.2.7)
- [Help me write a script that calls wan 2.2 animate mix api via curl](https://chat.qwen.ai/s/t_7039edb5-8a90-4872-ab0a-41fc3e8bc160?fev=0.2.7)
## Screenshots

### Successful API Test
<img width="1383" height="494" alt="image" src="https://github.com/user-attachments/assets/c884909d-b112-4b99-aa01-dd452e26405a" />

### Server Running
<img width="847" height="283" alt="image" src="https://github.com/user-attachments/assets/bd89bfa8-a89e-4d5d-a039-4c02c04cae61" />

---

## Completed Checklist

After Step 4, you should have:

### ✅ API Integration Testing
- [x] OSS upload tested with `test-oss-upload.sh`
- [x] WAN 2.2 Animate Mix API tested with `test-wan-2.2.sh`
- [x] Individual API components validated

### ✅ Project Initialized
- [x] `ai-video-editor-server` folder created
- [x] `package.json` created with `npm init -y`
- [x] Dependencies installed: express, dotenv, ali-oss, node-fetch, multer

### ✅ WAN API Client Built
- [x] `wan-client.js` file created
- [x] `WANClient` class implemented
- [x] `createTask()` method working
- [x] `getTaskStatus()` method working
- [x] `waitForCompletion()` method with polling

### ✅ Express Server Built
- [x] `server.js` file created
- [x] POST `/upload` endpoint (file uploads to OSS)
- [x] POST `/swap` endpoint (submit task to WAN API)
- [x] GET `/status/:taskId` endpoint (check progress)
- [x] Error handling implemented

### ✅ Server Tested
- [x] Server runs on port 3000
- [x] Upload endpoint accepts files and stores in OSS
- [x] Swap endpoint returns task ID from WAN API
- [x] Status endpoint shows task progress from WAN API

---

## Project Structure

```
ai-video-editor-server/
├── node_modules/
├── uploads/              # Temporary uploaded files
├── .env                  # Your environment variables
├── .gitignore
├── package.json
├── wan-client.js         # WAN API client class
├── test-swap.js          # Test script
└── server.js             # Express server
```

---

## Sample `wan-client.js` (Core Implementation)

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
    const response = await fetch(`${this.baseUrl}/api/v1/services/aigc/image2video/video-synthesis`, {
      method: 'POST',
      headers: {
        'Authorization': `Bearer ${this.apiKey}`,
        'Content-Type': 'application/json',
        'X-DashScope-Async': 'enable'
      },
      body: JSON.stringify({
        model: 'wan2.2-animate-mix',
        input: {
          image_url: imageUrl,
          video_url: videoUrl
        },
        parameters: {
          service_mode: 'wan-std'
        }
      })
    });

    const data = await response.json();
    if (!response.ok) throw new Error(data.message || 'Failed to create task');

    return data.output.task_id;
  }

  async getTaskStatus(taskId) {
    const response = await fetch(`${this.baseUrl}/api/v1/tasks/${taskId}`, {
      headers: {
        'Authorization': `Bearer ${this.apiKey}`
      }
    });

    const data = await response.json();
    return data.output;
  }

  async waitForCompletion(taskId, pollInterval = 15000) {
    while (true) {
      const status = await this.getTaskStatus(taskId);

      if (status.task_status === 'SUCCEEDED') {
        return status;
      } else if (status.task_status === 'FAILED') {
        throw new Error('Task failed');
      }

      console.log(`Task ${taskId}: ${status.task_status}...`);
      await new Promise(resolve => setTimeout(resolve, pollInterval));
    }
  }
}

module.exports = WANClient;
```

---

## Test Results

### Testing Workflow: OSS Upload First, Then WAN API

Before building the server, follow this testing workflow:

#### 1. Test OSS Upload to Server
Use the `test-oss-upload.sh` script to verify OSS upload functionality:

```bash
# Make the script executable
chmod +x test-oss-upload.sh

# Run the OSS upload test
./test-oss-upload.sh
```

This script will:
- Upload local files (`./samples/cutie_wizard.png` and `./samples/dancing.mp4`) to the server
- The server will store them in OSS
- Return public URLs for the uploaded files
- Display the URLs for use with the WAN API

#### 2. Test WAN 2.2 Animate Mix API
Use the `test-wan-2.2.sh` script to verify WAN API functionality:

```bash
# Make the script executable
chmod +x test-wan-2.2.sh

# Run the WAN API test
./test-wan-2.2.sh
```

This script will:
- Use the OSS URLs from your upload
- Call the WAN 2.2 Animate Mix API directly
- Submit a character animation task
- Poll for completion (every 30s for up to 5 minutes)
- Display the final video URL when complete

#### 3. Comprehensive Server Test
After building the server, use the `test-debug.sh` script to test the complete workflow:

```bash
# Make the script executable
chmod +x test-debug.sh

# Run the complete server test
./test-debug.sh
```

This script will:
- Test all server endpoints in sequence
- Upload files to server → OSS
- Submit task to WAN API via server
- Monitor task status via server
- Provide comprehensive debugging output

### Manual Testing Without Scripts

#### 1. Test OSS Upload Manually
```bash
# Upload files to server (server handles OSS upload)
curl -X POST http://localhost:3000/upload \
  -F "image=@./samples/your-character-image.jpg" \
  -F "video=@./samples/your-template-video.mp4"
```

**Expected Response:**
```json
{
  "imageUrl": "https://your-bucket.oss-region.aliyuncs.com/uploads/images/image-12345.jpg",
  "videoUrl": "https://your-bucket.oss-region.aliyuncs.com/uploads/videos/video-67890.mp4",
  "message": "Files uploaded to OSS successfully"
}
```

#### 2. Test WAN API Directly (using URLs from step 1)
```bash
# Use the OSS URLs from the upload response
curl -X POST https://dashscope-intl.aliyuncs.com/api/v1/services/aigc/image2video/video-synthesis \
  -H "Authorization: Bearer YOUR_API_KEY_HERE" \
  -H "Content-Type: application/json" \
  -H "X-DashScope-Async: enable" \
  -d '{
    "model": "wan2.2-animate-mix",
    "input": {
      "image_url": "https://your-oss-image-url.jpg",
      "video_url": "https://your-oss-video-url.mp4"
    },
    "parameters": {
      "service_mode": "wan-std",
      "mode": "wan-std"
    }
  }'
```

**Expected Response:**
```json
{
  "request_id": "fb-123-abc",
  "output": {
    "task_id": "task-abc123def456",
    "task_status": "PENDING"
  }
}
```

#### 3. Check Task Status
```bash
curl -X GET https://dashscope-intl.aliyuncs.com/api/v1/tasks/task-abc123def456 \
  -H "Authorization: Bearer YOUR_API_KEY_HERE"
```

**Expected Response:**
```json
{
  "request_id": "fb-123-abc",
  "output": {
    "task_id": "task-abc123def456",
    "task_status": "SUCCEEDED",
    "video_url": "https://dashscope-result.oss-cn-beijing.aliyuncs.com/video-2024/result.mp4",
    "submit_time": "2024-01-15 10:30:00",
    "end_time": "2024-01-15 10:35:23"
  }
}
```

---

## Common Issues & Solutions

### ❌ "401 Unauthorized"
**Solution**:
- Verify API key in `.env` is correct
- Check `Authorization: Bearer` header format
- Ensure no extra spaces in API key

### ❌ "Task Creation Fails"
**Solution**:
- Verify image and video URLs are publicly accessible
- Check URLs are valid (200 OK response)
- Ensure image is JPG/PNG, video is MP4

### ❌ "Polling Hangs Forever"
**Solution**:
- Add timeout to polling loop
- Check task status manually in DashScope console
- Verify video isn't too long (check API limits)

### ❌ "Cannot Find Module 'node-fetch'"
**Solution**:
```bash
npm install node-fetch@2
```
(Use version 2 for CommonJS compatibility)

---

## API Response Examples

### Task Created Successfully
```json
{
  "request_id": "fb-123-abc",
  "output": {
    "task_id": "task-abc123def456"
  }
}
```

### Task Status: Running
```json
{
  "output": {
    "task_id": "task-abc123def456",
    "task_status": "RUNNING",
    "submit_time": "2024-01-15 10:30:00",
    "scheduled_time": "2024-01-15 10:30:05"
  }
}
```

### Task Status: Succeeded
```json
{
  "output": {
    "task_id": "task-abc123def456",
    "task_status": "SUCCEEDED",
    "video_url": "https://dashscope-result.oss-cn-beijing.aliyuncs.com/video-2024/result.mp4",
    "submit_time": "2024-01-15 10:30:00",
    "end_time": "2024-01-15 10:35:23"
  }
}
```

---

## Pro-Tips

💡 **Error Handling**:
- Always wrap API calls in try-catch
- Log full error responses for debugging
- Implement retry logic for network failures

💡 **Performance**:
- Don't poll more frequently than every 15 seconds
- Cache task results to avoid duplicate API calls
- Use webhooks in production (if available)

💡 **Cost Control**:
- Track number of API calls
- Implement daily/monthly limits
- Log all tasks for billing reconciliation

💡 **Video URL Storage**:
- Download and save to your OSS (result URLs expire in 24h!)
- Generate permanent URLs from your OSS
- Keep task IDs for reference

---

[← Back to Step 4](../STEP_4.md) | [Next: Step 5 Reference →](STEP_5_COMPLETED.md)
