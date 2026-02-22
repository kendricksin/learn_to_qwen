// server.js
require('dotenv').config();
const express = require('express');
const cors = require('cors');
const multer = require('multer');
const path = require('path');
const fs = require('fs');
const OSS = require('ali-oss');

// Import the WAN client
const WANClient = require('./wan-client');

// Logging utility
function logRequest(req, res, next) {
    const timestamp = new Date().toISOString();
    console.log(`[${timestamp}] ${req.method} ${req.path} - Query: ${JSON.stringify(req.query)}, Body: ${JSON.stringify(req.body)}`);
    next();
}

const app = express();
const PORT = process.env.PORT || 3000;

// Middleware
app.use(logRequest); // Add logging middleware
app.use(express.json());
app.use(cors());
app.use(express.static(__dirname)); // Serve static files from src directory

// Set up OSS client
const ossClient = new OSS({
  region: process.env.OSS_REGION,
  accessKeyId: process.env.OSS_ACCESS_KEY_ID,
  accessKeySecret: process.env.OSS_ACCESS_KEY_SECRET,
  bucket: process.env.OSS_BUCKET
});

// Configure multer for temporary file storage before uploading to OSS
const storage = multer.diskStorage({
  destination: (req, file, cb) => {
    const uploadDir = 'temp-uploads/';
    if (!fs.existsSync(uploadDir)) {
      fs.mkdirSync(uploadDir, { recursive: true });
    }
    cb(null, uploadDir);
  },
  filename: (req, file, cb) => {
    // Generate unique filename
    cb(null, `${file.fieldname}-${Date.now()}${path.extname(file.originalname)}`);
  }
});

const upload = multer({ 
  storage: storage,
  limits: {
    fileSize: parseInt(process.env.MAX_FILE_SIZE_MB || 200) * 1024 * 1024 // Convert MB to bytes
  },
  fileFilter: (req, file, cb) => {
    // Accept only image and video files based on MIME type or file extension
    const allowedMimes = ['image/jpeg', 'image/jpg', 'image/png', 'image/gif', 'image/webp', 'video/mp4', 'video/mpeg', 'video/mov', 'video/avi', 'video/wmv', 'video/flv', 'video/swf', 'video/quicktime'];
    const allowedExtensions = ['.jpg', '.jpeg', '.png', '.gif', '.webp', '.mp4', '.mpeg', '.mov', '.avi', '.wmv', '.flv', '.swf', '.qt'];
    
    const ext = path.extname(file.originalname).toLowerCase();
    
    if (allowedMimes.includes(file.mimetype) || allowedExtensions.includes(ext)) {
      cb(null, true);
    } else {
      cb(new Error('Only image and video files are allowed'));
    }
  }
});

// Initialize WAN client
const wanClient = new WANClient(
  process.env.DASHSCOPE_API_KEY,
  process.env.DASHSCOPE_REGION
);

// In-memory storage for tracking uploaded files and tasks (in production, use a database)
let uploadedFiles = {
  images: [],
  videos: []
};

let taskHistory = [];

// Helper function to store uploaded file info
function recordUploadedFile(type, fileName, url, timestamp = new Date()) {
  const fileInfo = {
    name: fileName,
    url: url,
    timestamp: timestamp
  };
  
  if (type === 'image') {
    uploadedFiles.images.unshift(fileInfo);
    // Keep only the last 5 images
    if (uploadedFiles.images.length > 5) {
      uploadedFiles.images = uploadedFiles.images.slice(0, 5);
    }
  } else if (type === 'video') {
    uploadedFiles.videos.unshift(fileInfo);
    // Keep only the last 5 videos
    if (uploadedFiles.videos.length > 5) {
      uploadedFiles.videos = uploadedFiles.videos.slice(0, 5);
    }
  }
}

// Helper function to record a task
function recordTask(taskId, imageUrl, videoUrl, timestamp = new Date()) {
  const taskInfo = {
    taskId: taskId,
    imageUrl: imageUrl,
    videoUrl: videoUrl,
    status: 'SUBMITTED', // Default status when first submitted
    timestamp: timestamp,
    resultUrl: null // Will be populated when task completes
  };
  
  taskHistory.unshift(taskInfo);
  // Keep only the last 10 tasks
  if (taskHistory.length > 10) {
    taskHistory = taskHistory.slice(0, 10);
  }
  
  return taskInfo;
}

// Helper function to update task status
function updateTaskStatus(taskId, status, resultUrl = null) {
  const task = taskHistory.find(t => t.taskId === taskId);
  if (task) {
    task.status = status;
    if (resultUrl) {
      task.resultUrl = resultUrl;
    }
    task.timestamp = new Date(); // Update timestamp when status changes
  }
}

// Routes

// Upload endpoint - handles file uploads (either image, video, or both)
app.post('/upload', upload.fields([
  { name: 'image', maxCount: 1 }, 
  { name: 'video', maxCount: 1 }
]), async (req, res) => {
  try {
    const uploadedFiles = req.files;
    console.log('[UPLOAD] Files received:', Object.keys(uploadedFiles || {}));
    
    if (!uploadedFiles.image && !uploadedFiles.video) {
      console.log('[UPLOAD] No files provided');
      return res.status(400).json({ 
        error: 'At least one file (image or video) is required' 
      });
    }
    
    const result = {};
    
    // Upload image to OSS if provided
    if (uploadedFiles.image) {
      const imageFile = uploadedFiles.image[0];
      console.log('[UPLOAD] Processing image:', imageFile.originalname);
      const imageObjectName = `uploads/images/${imageFile.filename}`;
      const imageResult = await ossClient.put(imageObjectName, imageFile.path);
      console.log('[UPLOAD] Image uploaded to OSS:', imageResult.url);
      
      result.imageUrl = imageResult.url;
      result.imageName = imageFile.originalname;  // Store original filename
      fs.unlinkSync(imageFile.path);  // Clean up temporary file
      
      // Record the uploaded image
      recordUploadedFile('image', imageFile.originalname, imageResult.url);
    }
    
    // Upload video to OSS if provided
    if (uploadedFiles.video) {
      const videoFile = uploadedFiles.video[0];
      console.log('[UPLOAD] Processing video:', videoFile.originalname);
      const videoObjectName = `uploads/videos/${videoFile.filename}`;
      const videoResult = await ossClient.put(videoObjectName, videoFile.path);
      console.log('[UPLOAD] Video uploaded to OSS:', videoResult.url);
      
      result.videoUrl = videoResult.url;
      result.videoName = videoFile.originalname;  // Store original filename
      fs.unlinkSync(videoFile.path);  // Clean up temporary file
      
      // Record the uploaded video
      recordUploadedFile('video', videoFile.originalname, videoResult.url);
    }
    
    result.message = 'Files uploaded to OSS successfully';
    console.log('[UPLOAD] Success:', result);
    
    res.json(result);
  } catch (error) {
    console.error('[UPLOAD] Error:', error);
    
    // Clean up temporary files if error occurs
    if (req.files?.image?.[0]?.path && fs.existsSync(req.files.image[0].path)) {
      fs.unlinkSync(req.files.image[0].path);
    }
    if (req.files?.video?.[0]?.path && fs.existsSync(req.files.video[0].path)) {
      fs.unlinkSync(req.files.video[0].path);
    }
    
    res.status(500).json({ 
      error: 'Upload failed', 
      details: error.message 
    });
  }
});

// Endpoint to get recently uploaded images
app.get('/recent-images', async (req, res) => {
  try {
    res.json(uploadedFiles.images);
  } catch (error) {
    console.error('Error getting recent images:', error);
    res.status(500).json({ error: 'Failed to retrieve recent images' });
  }
});

// Endpoint to get recently uploaded videos
app.get('/recent-videos', async (req, res) => {
  try {
    res.json(uploadedFiles.videos);
  } catch (error) {
    console.error('Error getting recent videos:', error);
    res.status(500).json({ error: 'Failed to retrieve recent videos' });
  }
});

// Character swap endpoint - submits a task to WAN API
app.post('/swap', async (req, res) => {
  try {
    const { imageUrl, videoUrl } = req.body;
    console.log('[SWAP] Received request with URLs:', { imageUrl: !!imageUrl, videoUrl: !!videoUrl });
    
    if (!imageUrl || !videoUrl) {
      console.log('[SWAP] Missing required URLs');
      return res.status(400).json({ 
        error: 'Image URL and Video URL are required' 
      });
    }
    
    // Submit task to WAN API
    console.log('[SWAP] Creating task with URLs:', { imageUrl, videoUrl });
    const taskId = await wanClient.createTask(imageUrl, videoUrl);
    console.log('[SWAP] Task created with ID:', taskId);
    
    // Record the task in history
    recordTask(taskId, imageUrl, videoUrl);
    
    res.json({ 
      taskId,
      message: 'Task submitted successfully'
    });
  } catch (error) {
    console.error('[SWAP] Error:', error);
    res.status(500).json({ 
      error: 'Swap failed', 
      details: error.message 
    });
  }
});

// Status endpoint - checks the status of a task
app.get('/status/:taskId', async (req, res) => {
  try {
    const { taskId } = req.params;
    console.log('[STATUS] Checking status for task:', taskId);
    
    if (!taskId) {
      console.log('[STATUS] No task ID provided');
      return res.status(400).json({ 
        error: 'Task ID is required' 
      });
    }
    
    const status = await wanClient.getTaskStatus(taskId);
    console.log('[STATUS] Full status response:', JSON.stringify(status, null, 2));
    
    // Update task status in history if task exists
    // The video URL might be in results.video_url or video_url at the top level
    let videoUrl = null;
    if (status.results && status.results.video_url) {
      videoUrl = status.results.video_url;
    } else if (status.video_url) {
      videoUrl = status.video_url;
    }
    
    // Update the status log to reflect the correct video URL detection
    console.log('[STATUS] Retrieved status for task:', { taskId, status: status.task_status, hasVideoUrl: !!videoUrl });
    
    if (status.task_status === 'SUCCEEDED' && videoUrl) {
      console.log('[STATUS] Task succeeded with video URL:', videoUrl);
      updateTaskStatus(taskId, status.task_status, videoUrl);
    } else {
      console.log('[STATUS] Updating task status to:', status.task_status);
      updateTaskStatus(taskId, status.task_status);
    }
    
    // Include the video URL in the response to the frontend if available
    // Also include any error codes or messages if present
    const responseDetails = {...status};
    if (videoUrl) {
      responseDetails.video_url = videoUrl;
    }
    
    // If the task failed, include the error information
    if (status.task_status === 'FAILED' && status.code) {
      responseDetails.error_code = status.code;
      responseDetails.error_message = status.message;
    }
    
    res.json({ 
      taskId,
      status: status.task_status,
      details: responseDetails
    });
  } catch (error) {
    console.error('[STATUS] Error checking task status:', error);
    res.status(500).json({ 
      error: 'Status check failed', 
      details: error.message 
    });
  }
});

// Endpoint to get task history
app.get('/task-history', async (req, res) => {
  try {
    console.log('[TASK-HISTORY] Returning', taskHistory.length, 'tasks');
    res.json(taskHistory);
  } catch (error) {
    console.error('[TASK-HISTORY] Error getting task history:', error);
    res.status(500).json({ error: 'Failed to retrieve task history' });
  }
});

// Health check endpoint
app.get('/', (req, res) => {
  res.json({ 
    message: 'AI Video Editor Server is running!',
    timestamp: new Date().toISOString()
  });
});

// Error handling middleware
app.use((err, req, res, next) => {
  console.error(err.stack);
  res.status(500).json({ 
    error: 'Something went wrong!',
    details: err.message 
  });
});

// Start server
app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
  console.log(`Environment: ${process.env.NODE_ENV || 'development'}`);
});

module.exports = app;