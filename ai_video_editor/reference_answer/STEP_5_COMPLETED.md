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
- [x] `public/` folder created
- [x] `index.html` created
- [x] `styles.css` created
- [x] `app.js` created
- [x] Server configured to serve static files

### ✅ HTML Structure
- [x] Upload section with file inputs
- [x] Process button
- [x] Progress section (hidden by default)
- [x] Result section with video player
- [x] Download button

### ✅ Styling Complete
- [x] Clean, modern design
- [x] Card-based layout
- [x] Loading spinner animation
- [x] Responsive design (mobile-friendly)
- [x] Hover effects and transitions

### ✅ JavaScript Functionality
- [x] File selection validation
- [x] Upload files to server
- [x] Submit swap task
- [x] Poll task status
- [x] Display result video
- [x] Error handling

### ✅ User Experience
- [x] Clear call-to-action
- [x] Visual feedback for all actions
- [x] Helpful error messages
- [x] Download functionality
- [x] Works on mobile devices

---

## Project Structure

```
ai-video-editor/
├── server/
│   ├── server.js
│   ├── wan-client.js
│   └── package.json
└── public/
    ├── index.html
    ├── styles.css
    └── app.js
```

---

## Sample `index.html`

```html
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>AI Video Editor - Character Swap</title>
  <link rel="stylesheet" href="styles.css">
</head>
<body>
  <header>
    <h1>🎬 AI Video Editor</h1>
    <p>Personalize your videos with AI character swap</p>
  </header>

  <main>
    <!-- Upload Section -->
    <section id="upload-section" class="card">
      <h2>Upload Your Files</h2>
      <div class="file-inputs">
        <div class="input-group">
          <label for="character-image">
            📸 Character Image
            <span class="hint">(JPG, PNG, max 50MB)</span>
          </label>
          <input type="file" id="character-image" accept="image/*">
          <div id="image-preview" class="preview"></div>
        </div>

        <div class="input-group">
          <label for="template-video">
            🎥 Template Video
            <span class="hint">(MP4, max 200MB)</span>
          </label>
          <input type="file" id="template-video" accept="video/*">
          <div id="video-preview" class="preview"></div>
        </div>
      </div>
      <button id="process-btn" class="primary-btn" disabled>
        Process Video
      </button>
    </section>

    <!-- Progress Section -->
    <section id="progress-section" class="card hidden">
      <div class="spinner"></div>
      <p id="status-text">Processing your video...</p>
      <p class="hint">This may take a few minutes</p>
    </section>

    <!-- Result Section -->
    <section id="result-section" class="card hidden">
      <h2>✨ Your Video is Ready!</h2>
      <video id="result-video" controls></video>
      <div class="actions">
        <button id="download-btn" class="primary-btn">
          Download Video
        </button>
        <button id="new-btn" class="secondary-btn">
          Create Another
        </button>
      </div>
    </section>
  </main>

  <footer>
    <p>Powered by Alibaba Cloud WAN Animate Mix API</p>
  </footer>

  <script src="app.js"></script>
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

## Sample `app.js` (Core Logic)

```javascript
// app.js

// DOM Elements
const characterInput = document.getElementById('character-image');
const videoInput = document.getElementById('template-video');
const processBtn = document.getElementById('process-btn');
const uploadSection = document.getElementById('upload-section');
const progressSection = document.getElementById('progress-section');
const resultSection = document.getElementById('result-section');
const statusText = document.getElementById('status-text');
const resultVideo = document.getElementById('result-video');
const downloadBtn = document.getElementById('download-btn');
const newBtn = document.getElementById('new-btn');

// Enable process button when both files selected
characterInput.addEventListener('change', checkFiles);
videoInput.addEventListener('change', checkFiles);

function checkFiles() {
  const hasImage = characterInput.files.length > 0;
  const hasVideo = videoInput.files.length > 0;
  processBtn.disabled = !(hasImage && hasVideo);
}

// Main processing flow
processBtn.addEventListener('click', async () => {
  try {
    processBtn.disabled = true;

    // Step 1: Upload files
    const urls = await uploadFiles();

    // Step 2: Submit swap task
    const taskId = await submitSwapTask(urls);

    // Step 3: Poll for completion
    const result = await pollTaskStatus(taskId);

    // Step 4: Display result
    displayResult(result.video_url);
  } catch (error) {
    handleError(error);
  }
});

// Upload files to server
async function uploadFiles() {
  showProgress('Uploading files...');

  const formData = new FormData();
  formData.append('image', characterInput.files[0]);
  formData.append('video', videoInput.files[0]);

  const response = await fetch('/upload', {
    method: 'POST',
    body: formData
  });

  if (!response.ok) throw new Error('Upload failed');
  return await response.json();
}

// Submit character swap task
async function submitSwapTask(urls) {
  showProgress('Starting AI processing...');

  const response = await fetch('/swap', {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify(urls)
  });

  if (!response.ok) throw new Error('Task submission failed');
  const data = await response.json();
  return data.taskId;
}

// Poll task status until complete
async function pollTaskStatus(taskId) {
  showProgress('Processing video (this may take 2-5 minutes)...');

  while (true) {
    const response = await fetch(`/status/${taskId}`);
    const data = await response.json();

    if (data.status === 'SUCCEEDED') {
      return data;
    } else if (data.status === 'FAILED') {
      throw new Error('Video processing failed');
    }

    // Update status text
    statusText.textContent = `Processing... (${data.status})`;

    // Wait 5 seconds before next check
    await new Promise(resolve => setTimeout(resolve, 5000));
  }
}

// Show progress section
function showProgress(message) {
  uploadSection.classList.add('hidden');
  progressSection.classList.remove('hidden');
  resultSection.classList.add('hidden');
  statusText.textContent = message;
}

// Display result video
function displayResult(videoUrl) {
  progressSection.classList.add('hidden');
  resultSection.classList.remove('hidden');
  resultVideo.src = videoUrl;

  // Setup download button
  downloadBtn.onclick = () => {
    window.open(videoUrl, '_blank');
  };
}

// Handle errors
function handleError(error) {
  console.error('Error:', error);
  alert('❌ Error: ' + error.message + '\n\nPlease try again.');

  // Reset to upload state
  uploadSection.classList.remove('hidden');
  progressSection.classList.add('hidden');
  resultSection.classList.add('hidden');
  processBtn.disabled = false;
}

// Create another video
newBtn.addEventListener('click', () => {
  // Reset form
  characterInput.value = '';
  videoInput.value = '';
  resultVideo.src = '';

  // Show upload section
  uploadSection.classList.remove('hidden');
  resultSection.classList.add('hidden');
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
