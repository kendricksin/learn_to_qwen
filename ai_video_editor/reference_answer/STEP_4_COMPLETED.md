# Step 4 Reference: WAN API Integration Completed

This shows what a working WAN API integration looks like after completing Step 4.

## AI Chat Sessions (Examples)

- [Help me build the WAN API client](#) - _Link to be added_
- [How to handle async task polling](#) - _Link to be added_
- [Building Express server endpoints](#) - _Link to be added_
- [Error handling best practices](#) - _Link to be added_

## Screenshots

### Successful API Test
_Add screenshots of:_
- [ ] Test script submitting a task
- [ ] Console showing task ID returned
- [ ] Polling progress messages
- [ ] Final video URL displayed

### Server Running
_Add screenshots of:_
- [ ] Express server started on port 3000
- [ ] API endpoint tests (Postman/curl)
- [ ] Successful upload response
- [ ] Task status response

---

## Completed Checklist

After Step 4, you should have:

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

### ✅ API Integration Tested
- [x] Test files uploaded to OSS
- [x] `test-swap.js` script created
- [x] Successfully submitted a character swap task
- [x] Task completed and video URL received

### ✅ Express Server Built
- [x] `server.js` file created
- [x] POST `/upload` endpoint (file uploads)
- [x] POST `/swap` endpoint (submit task)
- [x] GET `/status/:taskId` endpoint (check progress)
- [x] Error handling implemented

### ✅ Server Tested
- [x] Server runs on port 3000
- [x] Upload endpoint accepts files
- [x] Swap endpoint returns task ID
- [x] Status endpoint shows task progress

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

### Successful Task Submission

```bash
$ node test-swap.js

🚀 Submitting task...
📋 Task ID: task-abc123def456
⏳ Waiting for completion...
Task task-abc123def456: PENDING...
Task task-abc123def456: RUNNING...
Task task-abc123def456: RUNNING...
✅ Done!
🎥 Result URL: https://dashscope-result.oss-cn-beijing.aliyuncs.com/video-2024/result_xyz.mp4
```

### Server Endpoints Working

```bash
# Test upload
$ curl -F "image=@character.jpg" -F "video=@template.mp4" http://localhost:3000/upload

{
  "imageUrl": "https://my-bucket.oss-region.aliyuncs.com/uploads/images/character_123.jpg",
  "videoUrl": "https://my-bucket.oss-region.aliyuncs.com/uploads/videos/template_456.mp4"
}

# Test swap
$ curl -X POST http://localhost:3000/swap \
  -H "Content-Type: application/json" \
  -d '{"imageUrl":"...", "videoUrl":"..."}'

{
  "taskId": "task-abc123def456"
}

# Check status
$ curl http://localhost:3000/status/task-abc123def456

{
  "status": "RUNNING",
  "progress": "Processing..."
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
