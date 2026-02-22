# AI Video Editor Server

This is a Node.js server implementation for the AI Video Editor using Alibaba Cloud's WAN (Wonder Animation Network) API.

## Features

- Upload images and videos for processing
- Integrate with WAN API for character animation
- Monitor task status with polling mechanism
- Express.js REST API endpoints
- Complete web-based frontend interface

## Setup

1. Install dependencies:
```bash
npm install
```

2. Copy the example environment file:
```bash
cp .env.example .env
```

3. Update `.env` with your Alibaba Cloud credentials:
```env
DASHSCOPE_API_KEY=your-api-key-here
OSS_ACCESS_KEY_ID=your-oss-access-key
OSS_ACCESS_KEY_SECRET=your-oss-secret-key
OSS_REGION=oss-ap-southeast-1
OSS_BUCKET=your-bucket-name
```

## Running the Server

Start the server:
```bash
npm start
```

Or for development with auto-restart:
```bash
npm run dev
```

Access the web interface at `http://localhost:3000`

## API Endpoints

- `GET /` - Health check
- `POST /upload` - Upload image and video files
- `POST /swap` - Submit character swap task
- `GET /status/:taskId` - Check task status

## Frontend Interface

The application includes a complete web-based frontend:

- **User-friendly interface** for uploading image and video files
- **Real-time preview** of uploaded content
- **Browse previous uploads** - Access the last 5 uploaded images and videos for quick reuse
- **Status tracking** for ongoing animation tasks
- **Direct playback** of completed animations in the browser
- **Direct download** of completed animations
- **Responsive design** that works on desktop and mobile devices

To use the frontend, simply navigate to `http://localhost:3000` after starting the server.

## Testing

Run the basic test script to verify server functionality:
```bash
npm run test
```

Or run the API endpoint test to test with actual sample files:
```bash
node test-api-endpoints.js
```

To test with real sample files, create a `samples` directory with test image and video files:
```bash
mkdir samples
# Add your sample-image.jpg and sample-video.mp4 to this directory
```

## Project Structure

```
src/
├── index.html             # Main HTML interface
├── styles.css             # CSS styling
├── script.js              # Client-side JavaScript
├── server.js              # Main Express server
├── wan-client.js          # WAN API client
├── .env                   # Environment variables
└── package.json           # Dependencies and scripts
```