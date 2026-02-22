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
        model: 'wan2.2-animate-mix',  // Keeping the original model
        input: {
          image_url: imageUrl,
          video_url: videoUrl
        },
        parameters: {
          service_mode: 'wan-std',
          mode: 'wan-std'  // Correct mode value according to error message
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
    console.log('[WAN-CLIENT] Task status response:', JSON.stringify(data, null, 2));
    return data.output;
  }

  async waitForCompletion(taskId, pollInterval = 15000) {
    while (true) {
      const status = await this.getTaskStatus(taskId);

      if (status.task_status === 'SUCCEEDED') {
        return status;
      } else if (status.task_status === 'FAILED') {
        throw new Error(`Task failed: ${status.message || ''}`);
      }

      console.log(`Task ${taskId}: ${status.task_status}...`);
      await new Promise(resolve => setTimeout(resolve, pollInterval));
    }
  }
}

module.exports = WANClient;