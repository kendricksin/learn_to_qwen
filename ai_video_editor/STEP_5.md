# Step 5: Create the User Interface

Now that your backend server is working, it's time to build a simple web interface where users can interact with your AI video editor.

## What We're Building

A single-page web application with:
- 📤 **File upload area** for character image and template video
- ⏳ **Progress indicator** showing processing status
- 🎥 **Video player** to preview the result
- 💾 **Download button** for the final video

---

## Design Your UI (Ask AI for Ideas)

### Prompt for AI:

> *"I need a simple HTML/CSS/JavaScript interface for a video editing web app. Users should be able to:
> 1. Drag and drop or select a character image (JPG/PNG)
> 2. Drag and drop or select a template video (MP4)
> 3. Click a button to start processing
> 4. See a loading spinner while processing
> 5. Watch the result video and download it
>
> Make it clean, modern, and mobile-friendly. Use vanilla JavaScript (no frameworks)."*

The AI should provide you with HTML, CSS, and JavaScript files.

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
    ├── app.js
    └── assets/
        └── icons/
```

---

## Create the HTML Structure

### Prompt for AI:

> *"Create an index.html for my video editor with these sections:
> 1. Header with title and logo
> 2. Upload section with two file inputs (image and video)
> 3. Submit button
> 4. Progress section (hidden by default)
> 5. Result section with video player (hidden by default)
>
> Use semantic HTML5 and include meta tags for mobile responsiveness."*

### Expected Output:

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
          <label for="character-image">Character Image</label>
          <input type="file" id="character-image" accept="image/*">
        </div>
        <div class="input-group">
          <label for="template-video">Template Video</label>
          <input type="file" id="template-video" accept="video/*">
        </div>
      </div>
      <button id="process-btn" disabled>Process Video</button>
    </section>

    <!-- Progress Section -->
    <section id="progress-section" class="card hidden">
      <div class="spinner"></div>
      <p id="status-text">Processing your video...</p>
    </section>

    <!-- Result Section -->
    <section id="result-section" class="card hidden">
      <h2>Your Video is Ready!</h2>
      <video id="result-video" controls></video>
      <button id="download-btn">Download Video</button>
    </section>
  </main>

  <script src="app.js"></script>
</body>
</html>
```

---

## Style Your Interface

### Prompt for AI:

> *"Create modern CSS styling for my video editor interface with:
> - Clean, minimalist design
> - Card-based layout with shadows
> - Smooth transitions and hover effects
> - Loading spinner animation
> - Mobile-responsive (works on phones)
> - Use a color scheme of blue and white"*

### Key CSS Features to Include:

```css
/* styles.css */

/* Modern card design */
.card {
  background: white;
  border-radius: 12px;
  box-shadow: 0 4px 6px rgba(0,0,0,0.1);
  padding: 2rem;
  margin: 1rem auto;
  max-width: 600px;
}

/* Loading spinner */
.spinner {
  border: 4px solid #f3f3f3;
  border-top: 4px solid #3498db;
  border-radius: 50%;
  width: 50px;
  height: 50px;
  animation: spin 1s linear infinite;
}

@keyframes spin {
  0% { transform: rotate(0deg); }
  100% { transform: rotate(360deg); }
}

/* Responsive video */
video {
  width: 100%;
  border-radius: 8px;
}
```

---

## Implement the Frontend Logic

### Prompt for AI:

> *"Create JavaScript code (app.js) that:
> 1. Enables the process button only when both files are selected
> 2. Uploads files to /upload endpoint when process is clicked
> 3. Submits a swap request to /swap endpoint with the URLs
> 4. Polls /status/:taskId every 5 seconds to check progress
> 5. Shows the result video when complete
> 6. Handles errors gracefully with user-friendly messages
>
> Use async/await and fetch API. Add comments explaining each step."*

### Expected JavaScript Structure:

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

// Enable button when both files selected
characterInput.addEventListener('change', checkFiles);
videoInput.addEventListener('change', checkFiles);

function checkFiles() {
  processBtn.disabled = !(characterInput.files[0] && videoInput.files[0]);
}

// Main processing flow
processBtn.addEventListener('click', async () => {
  try {
    // 1. Upload files
    const urls = await uploadFiles();

    // 2. Submit swap task
    const taskId = await submitSwapTask(urls);

    // 3. Poll for completion
    const result = await pollTaskStatus(taskId);

    // 4. Show result
    displayResult(result.videoUrl);
  } catch (error) {
    handleError(error);
  }
});

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

async function submitSwapTask(urls) {
  showProgress('Starting character swap...');

  const response = await fetch('/swap', {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify(urls)
  });

  if (!response.ok) throw new Error('Task submission failed');
  const data = await response.json();
  return data.taskId;
}

async function pollTaskStatus(taskId) {
  showProgress('Processing video (this may take a few minutes)...');

  while (true) {
    const response = await fetch(`/status/${taskId}`);
    const data = await response.json();

    if (data.status === 'SUCCEEDED') {
      return data;
    } else if (data.status === 'FAILED') {
      throw new Error('Video processing failed');
    }

    // Wait 5 seconds before next check
    await new Promise(resolve => setTimeout(resolve, 5000));
  }
}

function showProgress(message) {
  uploadSection.classList.add('hidden');
  progressSection.classList.remove('hidden');
  resultSection.classList.add('hidden');
  statusText.textContent = message;
}

function displayResult(videoUrl) {
  progressSection.classList.add('hidden');
  resultSection.classList.remove('hidden');
  resultVideo.src = videoUrl;
}

function handleError(error) {
  alert('Error: ' + error.message);
  // Reset UI
  uploadSection.classList.remove('hidden');
  progressSection.classList.add('hidden');
}
```

---

## Add Drag-and-Drop Support

### Prompt for AI:

> *"Enhance my file inputs with drag-and-drop functionality. Add visual feedback when users drag files over the upload areas."*

---

## Add File Validation

### Prompt for AI:

> *"Add client-side validation to check:
> - Image files are JPG, PNG, or WEBP
> - Videos are MP4 or AVI
> - File sizes are under 50MB for images and 200MB for videos
> - Show error messages for invalid files"*

---

## Improve User Experience

### Add Features:

1. **File Preview**
   - Show thumbnail of uploaded image
   - Show first frame of uploaded video

2. **Progress Percentage**
   - If your server supports it, show upload progress

3. **Cancel Button**
   - Allow users to cancel processing

4. **Error Recovery**
   - "Try Again" button on errors

### Prompt for AI:

> *"Add a preview feature that shows the uploaded image as a thumbnail and the first frame of the video before processing starts."*

---

## Test Your Interface

### Local Testing:

1. Start your server:
   ```bash
   cd server
   node server.js
   ```

2. Serve the frontend:
   ```bash
   cd public
   npx http-server -p 8080
   ```

3. Visit `http://localhost:8080`

### What to Test:

- ✅ File selection works
- ✅ Process button enables/disables correctly
- ✅ Upload shows progress
- ✅ Processing shows spinner
- ✅ Result video plays correctly
- ✅ Download button works
- ✅ Error messages display properly
- ✅ Works on mobile browsers

---

## Serve Frontend from Express

Update your server to serve static files:

```javascript
// server.js
const path = require('path');

app.use(express.static(path.join(__dirname, '../public')));

// Serve index.html for root path
app.get('/', (req, res) => {
  res.sendFile(path.join(__dirname, '../public/index.html'));
});
```

Now visit `http://localhost:3000` for everything!

---

## Optional Enhancements

### Prompt for AI:

> *"Add these features to my video editor:
> 1. Multiple file queue - process several videos at once
> 2. History page - show previously processed videos
> 3. Sharing - generate shareable links for results
> 4. Templates gallery - pre-loaded template videos to choose from"*

---

## Accessibility Improvements

### Prompt for AI:

> *"Make my video editor more accessible by adding:
> - ARIA labels for screen readers
> - Keyboard navigation support
> - High contrast mode
> - Alt text for all images"*

---

## Pro-Tips

- **Responsive Design**: Test on actual mobile devices, not just browser dev tools
- **Loading States**: Always show feedback for async operations
- **Error Messages**: Be specific - tell users what went wrong and how to fix it
- **Performance**: Compress images before upload on client-side
- **Analytics**: Track usage to understand user behavior

> [!TIP]
> **See a finished example:** [STEP_5_COMPLETED.md](./reference_answer/STEP_5_COMPLETED.md)

---

[← Step 4: Explore WAN API](STEP_4.md) | [Next Step: Deploy and Test →](STEP_6.md)
