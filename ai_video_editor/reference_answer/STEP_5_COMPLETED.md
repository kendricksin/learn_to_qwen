# Step 5 Reference: User Interface Completed

This shows what a working frontend interface looks like after completing Step 5.

## AI Chat Sessions (Examples)

- [Help me design the UI layout](#) - _Link to be added_
- [Implementing drag-and-drop uploads](#) - _Link to be added_
- [Creating loading animations](#) - _Link to be added_
- [Building the video player](#) - _Link to be added_

## Screenshots
<img width="909" height="881" alt="image" src="https://github.com/user-attachments/assets/138f1f88-f614-4f2a-8e18-1e36c16e2de3" />
<img width="999" height="825" alt="image" src="https://github.com/user-attachments/assets/a9772f67-c82b-448e-aa70-1dbb2ccd0ac3" />
<img width="646" height="753" alt="image" src="https://github.com/user-attachments/assets/0373b723-8126-442c-b109-e5251656f7f7" />
<img width="882" height="881" alt="image" src="https://github.com/user-attachments/assets/04ee945c-9468-49d4-a8de-8f790139e7ee" />

## Completed Checklist

After Step 5, you should have:

### ✅ Project Structure
- [x] `reference_answer/src/` folder created
- [x] `index.html` created with task history section
- [x] `styles.css` created with responsive design
- [x] `script.js` created with task history functionality
- [x] Server configured to serve static files and track tasks

### ✅ HTML Structure
- [x] Upload section with file inputs
- [x] Process button
- [x] Progress section with visual progress bar
- [x] Result section with video player
- [x] Download button
- [x] Task history section to browse previous results
- [x] Previous files section to reuse uploaded content

### ✅ Styling Complete
- [x] Clean, modern design
- [x] Card-based layout
- [x] Visual progress bar with percentage
- [x] Loading message during processing
- [x] Responsive design (mobile-friendly)
- [x] Hover effects and transitions
- [x] Color-coded status indicators for tasks

### ✅ JavaScript Functionality
- [x] File selection validation
- [x] Upload files to server
- [x] Submit swap task
- [x] Poll task status
- [x] Display result video with download link
- [x] Error handling
- [x] Task history tracking and display
- [x] Previous files browsing and selection
- [x] Auto-playback of completed videos from history

### ✅ User Experience
- [x] Clear call-to-action
- [x] Visual feedback for all actions
- [x] Helpful error messages
- [x] Download functionality
- [x] Works on mobile devices
- [x] Task history with clickable completed results
- [x] Ability to reuse previously uploaded files
- [x] Real-time progress visualization

---

## Project Structure

```
ai-video-editor/
└── reference_answer/src/
    ├── index.html          # Main HTML interface with task history
    ├── styles.css          # CSS styling with responsive design
    ├── script.js           # Client-side JavaScript with task history functionality
    ├── server.js           # Express server with file upload and task tracking
    ├── wan-client.js       # WAN API client for task management
    ├── .env               # Environment variables
    └── package.json       # Dependencies and scripts
```

---

## Sample `index.html`

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>AI Video Editor</title>
    <link rel="stylesheet" href="styles.css">
</head>
<body>
    <div class="container">
        <header>
            <h1>AI Video Editor</h1>
            <p>Transform your images into animated videos using AI</p>
        </header>
        
        <main>
            <section class="upload-section">
                <h2>Upload Files</h2>
                
                <div class="file-upload-group">
                    <div class="file-input-container">
                        <label for="imageFile">Select Character Image:</label>
                        <input type="file" id="imageFile" accept="image/*">
                        <div class="file-info" id="imageInfo"></div>
                    </div>
                    
                    <div class="file-input-container">
                        <label for="videoFile">Select Template Video:</label>
                        <input type="file" id="videoFile" accept="video/*">
                        <div class="file-info" id="videoInfo"></div>
                    </div>
                </div>
                
                <!-- Previous Files Section -->
                <div class="previous-files-section">
                    <h3>Previously Uploaded Images</h3>
                    <div class="files-grid" id="previousImages"></div>
                    
                    <h3>Previously Uploaded Videos</h3>
                    <div class="files-grid" id="previousVideos"></div>
                </div>
                
                <button id="uploadBtn" class="btn-primary">Upload Files</button>
                <div id="uploadProgress" class="progress hidden">
                    <div class="progress-bar"></div>
                    <span class="progress-text">Uploading...</span>
                </div>
            </section>
            
            <section class="process-section hidden">
                <h2>Process Files</h2>
                
                <div class="preview-container">
                    <div class="preview-item">
                        <h3>Character Image</h3>
                        <img id="previewImage" src="" alt="Preview">
                    </div>
                    
                    <div class="preview-item">
                        <h3>Template Video</h3>
                        <video id="previewVideo" controls>
                            <source src="" type="video/mp4">
                            Your browser does not support the video tag.
                        </video>
                    </div>
                </div>
                
                <button id="processBtn" class="btn-primary">Animate Character</button>
            </section>
            
            <section class="status-section hidden">
                <h2>Animation Status</h2>
                
                <div class="status-info">
                    <p><strong>Task ID:</strong> <span id="taskId"></span></p>
                    <p><strong>Status:</strong> <span id="taskStatus">Pending</span></p>
                    <p><strong>Progress:</strong> <span id="taskProgress">0%</span></p>
                </div>
                
                <div id="progressContainer" class="progress-container">
                    <div class="progress-bar-container">
                        <div id="progressBar" class="progress-bar" style="width: 0%;"></div>
                    </div>
                </div>
                
                <div id="loadingMessage" class="loading-message hidden">
                    <p>Please wait while your video is being processed...</p>
                </div>
                
                <div id="resultContainer" class="result-container hidden">
                    <h3>Animation Complete!</h3>
                    <video id="resultVideo" controls>
                        <source id="resultVideoSource" src="" type="video/mp4">
                        Your browser does not support the video tag.
                    </video>
                    <a id="downloadLink" class="btn-primary" target="_blank">Download Video</a>
                </div>
            </section>
            
            <section class="history-section">
                <h2>Task History</h2>
                <div class="task-history-list" id="taskHistoryList">
                    <p>No tasks yet. Process some files to see them here.</p>
                </div>
            </section>
        </main>
        
        <footer>
            <p>AI Video Editor powered by Alibaba Cloud WAN</p>
        </footer>
    </div>
    
    <script src="script.js"></script>
</body>
</html>
```

---

## Sample `styles.css` (Key Styles)

```css
/* Reset & Base */
* {
  margin: 0;
  padding: 0;
  box-sizing: border-box;
}

body {
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, sans-serif;
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  min-height: 100vh;
  padding: 2rem;
}

/* Header */
header {
  text-align: center;
  color: white;
  margin-bottom: 2rem;
}

header h1 {
  font-size: 2.5rem;
  margin-bottom: 0.5rem;
}

/* Card Layout */
.card {
  background: white;
  border-radius: 12px;
  box-shadow: 0 10px 30px rgba(0,0,0,0.2);
  padding: 2rem;
  margin: 1rem auto;
  max-width: 600px;
  transition: transform 0.3s ease;
}

.card:hover {
  transform: translateY(-2px);
}

/* File Inputs */
.input-group {
  margin-bottom: 1.5rem;
}

input[type="file"] {
  display: block;
  width: 100%;
  padding: 0.75rem;
  border: 2px dashed #667eea;
  border-radius: 8px;
  cursor: pointer;
  transition: all 0.3s ease;
}

input[type="file"]:hover {
  border-color: #764ba2;
  background: #f5f5ff;
}

/* Buttons */
.primary-btn {
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  color: white;
  border: none;
  padding: 1rem 2rem;
  border-radius: 8px;
  font-size: 1rem;
  font-weight: 600;
  cursor: pointer;
  width: 100%;
  transition: all 0.3s ease;
}

.primary-btn:hover:not(:disabled) {
  transform: translateY(-2px);
  box-shadow: 0 5px 15px rgba(102, 126, 234, 0.4);
}

.primary-btn:disabled {
  opacity: 0.5;
  cursor: not-allowed;
}

/* Loading Spinner */
.spinner {
  border: 4px solid #f3f3f3;
  border-top: 4px solid #667eea;
  border-radius: 50%;
  width: 50px;
  height: 50px;
  animation: spin 1s linear infinite;
  margin: 0 auto 1rem;
}

@keyframes spin {
  0% { transform: rotate(0deg); }
  100% { transform: rotate(360deg); }
}

/* Video Player */
video {
  width: 100%;
  border-radius: 8px;
  margin-bottom: 1rem;
}

/* Hidden State */
.hidden {
  display: none;
}

/* Mobile Responsive */
@media (max-width: 768px) {
  body {
    padding: 1rem;
  }

  header h1 {
    font-size: 2rem;
  }

  .card {
    padding: 1.5rem;
  }
}
```

---

## Sample `script.js` (Core Logic)

```javascript
// script.js
document.addEventListener('DOMContentLoaded', function() {
    // DOM elements
    const imageFileInput = document.getElementById('imageFile');
    const videoFileInput = document.getElementById('videoFile');
    const imageInfo = document.getElementById('imageInfo');
    const videoInfo = document.getElementById('videoInfo');
    const uploadBtn = document.getElementById('uploadBtn');
    const uploadProgress = document.getElementById('uploadProgress');
    const processSection = document.querySelector('.process-section');
    const previewImage = document.getElementById('previewImage');
    const previewVideo = document.getElementById('previewVideo');
    const processBtn = document.getElementById('processBtn');
    const statusSection = document.querySelector('.status-section');
    const taskIdEl = document.getElementById('taskId');
    const taskStatusEl = document.getElementById('taskStatus');
    const taskProgressEl = document.getElementById('taskProgress');
    const resultContainer = document.getElementById('resultContainer');
    const resultVideo = document.getElementById('resultVideo');
    const resultVideoSource = document.getElementById('resultVideoSource');
    const downloadLink = document.getElementById('downloadLink');
    const previousImagesGrid = document.getElementById('previousImages');
    const previousVideosGrid = document.getElementById('previousVideos');
    const taskHistoryList = document.getElementById('taskHistoryList');
    const progressBar = document.getElementById('progressBar');
    const progressContainer = document.getElementById('progressContainer');
    const loadingMessage = document.getElementById('loadingMessage');

    // State variables
    let uploadedFiles = {};

    // Initialize the page by loading previous files and task history
    loadPreviousFiles();
    loadTaskHistory();

    // Event listeners
    imageFileInput.addEventListener('change', function(e) {
        handleFileSelection(e, 'image', imageInfo);
    });

    videoFileInput.addEventListener('change', function(e) {
        handleFileSelection(e, 'video', videoInfo);
    });

    uploadBtn.addEventListener('click', uploadFiles);
    processBtn.addEventListener('click', processFiles);

    // Load previous files from server
    async function loadPreviousFiles() {
        try {
            // Load previous images
            const imagesResponse = await fetch('/recent-images');
            if (imagesResponse.ok) {
                const images = await imagesResponse.json();
                displayFiles(images, previousImagesGrid, 'image');
            }

            // Load previous videos
            const videosResponse = await fetch('/recent-videos');
            if (videosResponse.ok) {
                const videos = await videosResponse.json();
                displayFiles(videos, previousVideosGrid, 'video');
            }
        } catch (error) {
            console.error('Error loading previous files:', error);
        }
    }

    // Display files in the grid
    function displayFiles(files, container, type) {
        container.innerHTML = ''; // Clear existing content

        if (files.length === 0) {
            container.innerHTML = '<p class="no-files">No files available</p>';
            return;
        }

        files.forEach(file => {
            const fileItem = document.createElement('div');
            fileItem.className = 'file-item';
            fileItem.title = file.name;

            if (type === 'image') {
                const img = document.createElement('img');
                img.src = file.url;
                img.alt = file.name;
                fileItem.appendChild(img);
            } else if (type === 'video') {
                // For videos, we'll show a placeholder icon since generating thumbnails client-side 
                // from remote video URLs is complex due to CORS restrictions
                const videoIcon = document.createElement('div');
                videoIcon.style.display = 'flex';
                videoIcon.style.alignItems = 'center';
                videoIcon.style.justifyContent = 'center';
                videoIcon.style.height = '100px';
                videoIcon.style.backgroundColor = '#f0f0f0';
                videoIcon.style.borderBottom = '1px solid #ddd';

                const videoText = document.createElement('span');
                videoText.textContent = '▶';
                videoText.style.fontSize = '2em';
                videoIcon.appendChild(videoText);

                fileItem.appendChild(videoIcon);
            }

            const fileName = document.createElement('div');
            fileName.className = 'file-name';
            fileName.textContent = file.name;
            fileItem.appendChild(fileName);

            fileItem.addEventListener('click', function() {
                selectFile(file, type);
            });

            container.appendChild(fileItem);
        });
    }

    // Handle file selection from previous files
    function selectFile(file, type) {
        if (type === 'image') {
            previewImage.src = file.url;
            uploadedFiles.imageUrl = file.url;
            imageInfo.textContent = `Selected: ${file.name} (from previous uploads)`;
            processBtn.disabled = uploadedFiles.videoUrl ? false : true;
        } else if (type === 'video') {
            previewVideo.src = file.url;
            uploadedFiles.videoUrl = file.url;
            videoInfo.textContent = `Selected: ${file.name} (from previous uploads)`;
            processBtn.disabled = uploadedFiles.imageUrl ? false : true;
        }
    }

    // Handle file selection
    function handleFileSelection(event, type, infoElement) {
        const file = event.target.files[0];
        if (file) {
            // Display file info
            infoElement.textContent = `Selected: ${file.name} (${formatFileSize(file.size)})`;

            // Preview image or video
            if (type === 'image') {
                const reader = new FileReader();
                reader.onload = function(e) {
                    previewImage.src = e.target.result;
                };
                reader.readAsDataURL(file);

                // Also update the uploadedFiles object
                uploadedFiles.imageUrl = e.target.result;
            } else if (type === 'video') {
                const reader = new FileReader();
                reader.onload = function(e) {
                    previewVideo.src = e.target.result;
                    previewVideo.load(); // Load the new source
                };
                reader.readAsDataURL(file);

                // Also update the uploadedFiles object
                uploadedFiles.videoUrl = e.target.result;
            }

            // Enable process button if both files are selected
            if (uploadedFiles.imageUrl && uploadedFiles.videoUrl) {
                processBtn.disabled = false;
            }
        } else {
            infoElement.textContent = '';
        }
    }

    // Format file size for display
    function formatFileSize(bytes) {
        if (bytes === 0) return '0 Bytes';
        const k = 1024;
        const sizes = ['Bytes', 'KB', 'MB', 'GB'];
        const i = Math.floor(Math.log(bytes) / Math.log(k));
        return parseFloat((bytes / Math.pow(k, i)).toFixed(2)) + ' ' + sizes[i];
    }

    // Upload files to server
    async function uploadFiles() {
        const imageFile = imageFileInput.files[0];
        const videoFile = videoFileInput.files[0];

        if (!imageFile && !videoFile) {
            alert('Please select at least one file (image or video) to upload.');
            return;
        }

        // Show progress indicator
        uploadProgress.classList.remove('hidden');
        const progressBar = uploadProgress.querySelector('.progress-bar');
        progressBar.style.width = '30%'; // Initial progress

        try {
            const formData = new FormData();
            if (imageFile) formData.append('image', imageFile);
            if (videoFile) formData.append('video', videoFile);

            const response = await fetch('/upload', {
                method: 'POST',
                body: formData
            });

            if (!response.ok) {
                throw new Error(`Upload failed: ${response.statusText}`);
            }

            const result = await response.json();
            uploadedFiles = result;

            // Update progress
            progressBar.style.width = '100%';
            uploadProgress.querySelector('.progress-text').textContent = 'Upload complete!';

            // Reload previous files to show the newly uploaded ones
            loadPreviousFiles();

            // Show process section
            processSection.classList.remove('hidden');

            // If we have both URLs, enable the process button
            if (result.imageUrl && result.videoUrl) {
                processBtn.disabled = false;
            } else {
                processBtn.disabled = true;
                alert('Both image and video are required for character animation. Please upload both files.');
            }

            // Set preview URLs if they weren't set from local previews
            if (result.imageUrl && !previewImage.src.includes('blob:')) {
                previewImage.src = result.imageUrl;
            }
            if (result.videoUrl && !previewVideo.src.includes('blob:')) {
                previewVideo.src = result.videoUrl;
            }

        } catch (error) {
            console.error('Upload error:', error);
            alert(`Upload failed: ${error.message}`);
        } finally {
            // Hide progress indicator after a delay
            setTimeout(() => {
                uploadProgress.classList.add('hidden');
                progressBar.style.width = '0%';
            }, 1500);
        }
    }

    // Process files using WAN API
    async function processFiles() {
        if (!uploadedFiles.imageUrl || !uploadedFiles.videoUrl) {
            alert('Both image and video URLs are required for processing.');
            return;
        }

        try {
            // Show status section
            statusSection.classList.remove('hidden');

            // Submit the task
            const response = await fetch('/swap', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify({
                    imageUrl: uploadedFiles.imageUrl,
                    videoUrl: uploadedFiles.videoUrl
                })
            });

            if (!response.ok) {
                throw new Error(`Task submission failed: ${response.statusText}`);
            }

            const result = await response.json();
            const taskId = result.taskId;

            // Update UI with task info
            taskIdEl.textContent = taskId;
            taskStatusEl.textContent = 'SUBMITTED';
            taskProgressEl.textContent = '0%';

            // Poll for status updates
            await pollForStatus(taskId);

        } catch (error) {
            console.error('Processing error:', error);
            alert(`Processing failed: ${error.message}`);
        }
    }

    // Poll for task status
    async function pollForStatus(taskId) {
        let status = 'PENDING';
        const maxRetries = 40; // Maximum number of polls (40 * 15s = 10 minutes)
        let retries = 0;

        // Show progress container and loading message
        progressContainer.classList.remove('hidden');
        loadingMessage.classList.remove('hidden');

        while (status !== 'SUCCEEDED' && status !== 'FAILED' && retries < maxRetries) {
            try {
                const response = await fetch(`/status/${taskId}`);

                if (!response.ok) {
                    throw new Error(`Status check failed: ${response.statusText}`);
                }

                const result = await response.json();
                status = result.status;

                // Update UI with status
                taskStatusEl.textContent = status;

                // Calculate approximate progress based on status
                let progress = 0;
                switch(status) {
                    case 'PENDING':
                        progress = 10;
                        break;
                    case 'RUNNING':
                        // Estimate progress based on time elapsed (could be improved with API-provided progress)
                        progress = Math.min(90, 10 + (retries * 2));
                        break;
                    case 'SUCCEEDED':
                        progress = 100;
                        break;
                    case 'FAILED':
                        progress = 0;
                        break;
                    default:
                        progress = 0;
                }

                taskProgressEl.textContent = `${progress}%`;
                progressBar.style.width = `${progress}%`;
                progressBar.textContent = `${progress}%`;

                if (status === 'SUCCEEDED') {
                    // Show result
                    if (result.details.video_url) {
                        // Update the video source and download link
                        resultVideoSource.src = result.details.video_url;
                        downloadLink.href = result.details.video_url;

                        // Preload the video to ensure it's ready
                        resultVideo.load();

                        // Show the result container immediately
                        resultContainer.classList.remove('hidden');
                        loadingMessage.classList.add('hidden');

                        // Update status text to indicate completion
                        taskStatusEl.textContent = 'COMPLETED';

                        // Reload task history to update the list
                        loadTaskHistory();

                        // Stop polling once task is complete
                        break;
                    } else {
                        console.error('Task succeeded but no video URL returned:', result);
                        alert('Task completed but no video was returned. Please check server logs.');
                    }
                } else if (status === 'FAILED') {
                    taskStatusEl.textContent = 'FAILED';
                    loadingMessage.classList.add('hidden'); // Hide loading message on failure
                    if (result.details.error_message) {
                        alert(`Task failed: ${result.details.error_message}`);
                    } else {
                        alert('Task failed. Please check the server logs for more details.');
                    }

                    // Reload task history to update the list
                    loadTaskHistory();

                    // Stop polling if task failed
                    break;
                }

                retries++;

                // Wait before next poll (15 seconds as per API guidelines)
                await new Promise(resolve => setTimeout(resolve, 15000));

            } catch (error) {
                console.error('Status polling error:', error);
                loadingMessage.classList.add('hidden'); // Hide loading message on error
                alert(`Status check failed: ${error.message}`);
                break;
            }
        }

        if (retries >= maxRetries) {
            loadingMessage.classList.add('hidden'); // Hide loading message on timeout
            alert('Maximum polling attempts reached. The task may still be processing. Please refresh the page to check again later.');
        }
    }

    // Load task history from server
    async function loadTaskHistory() {
        try {
            const response = await fetch('/task-history');
            if (response.ok) {
                const tasks = await response.json();
                displayTaskHistory(tasks);
            }
        } catch (error) {
            console.error('Error loading task history:', error);
        }
    }

    // Display task history in the UI
    function displayTaskHistory(tasks) {
        taskHistoryList.innerHTML = ''; // Clear existing content

        if (tasks.length === 0) {
            taskHistoryList.innerHTML = '<p>No tasks yet. Process some files to see them here.</p>';
            return;
        }

        tasks.forEach(task => {
            const taskItem = document.createElement('div');
            taskItem.className = `task-item ${getStatusClass(task.status)}`;

            const taskHeader = document.createElement('div');
            taskHeader.className = 'task-item-header';

            const taskId = document.createElement('span');
            taskId.className = 'task-id';
            taskId.textContent = task.taskId;

            const taskStatus = document.createElement('span');
            taskStatus.className = `task-status ${getStatusBadgeClass(task.status)}`;
            taskStatus.textContent = task.status;

            taskHeader.appendChild(taskId);
            taskHeader.appendChild(taskStatus);

            const taskTimestamp = document.createElement('div');
            taskTimestamp.className = 'task-timestamp';
            taskTimestamp.textContent = new Date(task.timestamp).toLocaleString();

            taskItem.appendChild(taskHeader);
            taskItem.appendChild(taskTimestamp);

            // Add click handler to view completed task
            if (task.status === 'SUCCEEDED' && task.resultUrl) {
                taskItem.addEventListener('click', function() {
                    viewCompletedTask(task);
                });
            }

            taskHistoryList.appendChild(taskItem);
        });
    }

    // Get CSS class for status display
    function getStatusClass(status) {
        switch(status.toLowerCase()) {
            case 'succeeded': return 'completed';
            case 'running': return 'running';
            case 'failed': return 'failed';
            default: return '';
        }
    }

    // Get CSS class for status badge
    function getStatusBadgeClass(status) {
        switch(status.toLowerCase()) {
            case 'succeeded': return 'status-completed';
            case 'running': return 'status-running';
            case 'pending': return 'status-pending';
            case 'failed': return 'status-failed';
            default: return 'status-pending';
        }
    }

    // View a completed task
    function viewCompletedTask(task) {
        // Show the status section
        statusSection.classList.remove('hidden');

        // Update the UI with task info
        taskIdEl.textContent = task.taskId;
        taskStatusEl.textContent = task.status;
        taskProgressEl.textContent = '100%';

        // Show the result video
        resultVideoSource.src = task.resultUrl;
        resultVideo.load();
        resultContainer.classList.remove('hidden');
        downloadLink.href = task.resultUrl;

        // Scroll to the result section
        resultContainer.scrollIntoView({ behavior: 'smooth' });
    }

    // Initialize
    processBtn.disabled = true;
});
```

---

## Testing Checklist

### ✅ Desktop Testing
- [ ] File selection works
- [ ] Process button enables/disables
- [ ] Upload shows progress
- [ ] Processing shows spinner
- [ ] Video plays in result section
- [ ] Download button works
- [ ] "Create Another" resets form

### ✅ Mobile Testing
- [ ] Layout is responsive
- [ ] Buttons are touch-friendly
- [ ] File picker works on mobile
- [ ] Video player works
- [ ] No horizontal scrolling

### ✅ Error Cases
- [ ] Shows error for invalid file types
- [ ] Handles upload failures gracefully
- [ ] Shows error if API fails
- [ ] Timeout error handled
- [ ] Network error handled

---

## Common Issues & Solutions

### ❌ CORS Error
**Solution**:
- Ensure server serves frontend from same origin
- Or configure CORS headers in Express

### ❌ File Upload Fails
**Solution**:
- Check file size limits in server
- Verify `multer` is configured correctly
- Check network tab for actual error

### ❌ Video Won't Play
**Solution**:
- Check video URL is accessible
- Try opening URL directly in browser
- Verify video format is supported (MP4 works best)

---

## Pro-Tips

💡 **User Experience**:
- Show file previews before upload
- Add progress percentage if possible
- Provide estimated time remaining
- Save result URLs for download later

💡 **Performance**:
- Validate file size on client-side
- Show upload progress
- Compress images before upload
- Use lazy loading for result video

💡 **Polish**:
- Add animations and transitions
- Show success confetti animation
- Allow drag-and-drop upload
- Add sample videos for testing

---

[← Back to Step 5](../STEP_5.md) | [Next: Step 6 Reference →](STEP_6_COMPLETED.md)
