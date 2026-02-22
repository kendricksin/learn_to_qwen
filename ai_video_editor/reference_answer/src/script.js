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
                    alert('Task failed. Please check the server logs for more details.');
                    
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