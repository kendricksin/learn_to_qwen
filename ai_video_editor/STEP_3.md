# Step 3: Configure OSS (Object Storage Service)

Object Storage Service (OSS) is where you'll store input files (images, videos) and output videos. This step covers setting up OSS buckets and configuring service accounts with proper permissions.

## Why Do We Need OSS?

The WAN Animate Mix API requires:
1. **Input files** (image and video) to be accessible via URL
2. **Output videos** to be stored somewhere for users to download

OSS provides:
- ✅ Reliable storage for large video files
- ✅ Direct HTTP/HTTPS URLs for API access
- ✅ Fast upload/download speeds
- ✅ Access control and security

---

## Create an OSS Bucket

### 1. Navigate to OSS Console

1. Log in to [Alibaba Cloud Console](https://www.alibabacloud.com/console)
2. Search for "Object Storage Service" or "OSS"
3. Click **Buckets** → **Create Bucket**

### 2. Configure Your Bucket

**Prompt for AI:**
> *"What are the recommended OSS bucket settings for storing user-uploaded videos and images for a web app?"*

**Recommended settings:**
- **Bucket Name**: Choose something unique (e.g., `my-video-editor-bucket`)
- **Region**: Choose same region as your API (Singapore or Beijing)
- **Storage Class**: Standard (for frequently accessed files)
- **Access Control**: Private (we'll use signed URLs)
- **Versioning**: Disabled (to save costs)
- **Server-Side Encryption**: Enabled (for security)

### 3. Create the Bucket

Click **Create** and wait for confirmation.

---

## Set Up Service Account (RAM User)

For security, **never use your main account credentials** in your application. Create a dedicated service account with limited permissions.

### 1. Create RAM User

1. Go to **Resource Access Management (RAM)** in console
2. Click **Users** → **Create User**
3. **User Name**: `video-editor-service`
4. **Access Mode**: Check **Programmatic access**
5. Click **OK** and **save the AccessKey ID and AccessKey Secret**

> [!WARNING]
> **Save these credentials immediately** - you can't retrieve the Secret later!

### 2. Attach Permissions to RAM User

The service account needs specific OSS permissions:

1. Go to **Users** → Select your RAM user → **Add Permissions**
2. Attach policy: **AliyunOSSFullAccess** (for development)
3. For production, create a custom policy with minimal permissions:

**Prompt for AI:**
> *"Create a minimal IAM policy for Alibaba Cloud RAM user that can only read/write to a specific OSS bucket."*

Example minimal policy:
```json
{
  "Version": "1",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "oss:PutObject",
        "oss:GetObject",
        "oss:DeleteObject",
        "oss:ListObjects"
      ],
      "Resource": [
        "acs:oss:*:*:my-video-editor-bucket/*"
      ]
    }
  ]
}
```

---

## Configure OSS Credentials

Add your OSS credentials to your `.env` file (not `.env.example`!):

```bash
# .env
DASHSCOPE_API_KEY=sk-your-api-key-here
DASHSCOPE_REGION=singapore

# OSS Configuration
OSS_ACCESS_KEY_ID=your-ram-access-key-id  # Replace with your actual RAM user key!
OSS_ACCESS_KEY_SECRET=your-ram-access-key-secret  # Replace with your actual secret!
OSS_REGION=oss-ap-southeast-1  # Singapore region
OSS_BUCKET=my-video-editor-bucket  # Replace with your actual bucket name!
```

> [!WARNING]
> **Double-check before committing:**
> ```bash
> git status
> ```
> If you see `.env` in the list of files to be committed, **STOP!** Add it to `.gitignore` immediately.

**Region codes:**
- Singapore: `oss-ap-southeast-1`
- Beijing: `oss-cn-beijing`
- [Full list of regions](https://www.alibabacloud.com/help/en/oss/user-guide/regions-and-endpoints)

---

## Test OSS Connection

### Install OSS SDK

```bash
npm install ali-oss dotenv
```

### Create Test Script

**Prompt for AI:**
> *"Create a Node.js script to test OSS connection by uploading a small test file using the ali-oss SDK."*

The AI should give you something like:

```javascript
// test-oss.js
require('dotenv').config();
const OSS = require('ali-oss');

const client = new OSS({
  region: process.env.OSS_REGION,
  accessKeyId: process.env.OSS_ACCESS_KEY_ID,
  accessKeySecret: process.env.OSS_ACCESS_KEY_SECRET,
  bucket: process.env.OSS_BUCKET
});

async function testUpload() {
  try {
    // Create a test file
    const result = await client.put('test.txt', Buffer.from('Hello OSS!'));
    console.log('✓ Upload successful!');
    console.log('URL:', result.url);

    // Try to read it back
    const content = await client.get('test.txt');
    console.log('✓ Download successful!');

    // Clean up
    await client.delete('test.txt');
    console.log('✓ Delete successful!');
  } catch (error) {
    console.error('✗ Error:', error.message);
  }
}

testUpload();
```

Run it:
```bash
node test-oss.js
```

---

## Configure CORS (for Browser Uploads)

If you want users to upload files directly from browser to OSS:

1. Go to your bucket in OSS Console
2. Navigate to **Access Control** → **Cross-Origin Resource Sharing (CORS)**
3. Click **Configure** → **Create Rule**

**CORS Settings:**
```
Allowed Origins: * (or your domain for production)
Allowed Methods: GET, POST, PUT, DELETE, HEAD
Allowed Headers: *
Expose Headers: ETag
Max Age: 3600
```

---

## Organize Your OSS Storage

Create a folder structure in your bucket:

```
my-video-editor-bucket/
├── uploads/           # User uploaded images/videos
│   ├── images/
│   └── videos/
├── results/           # Generated videos from WAN API
└── temp/              # Temporary files (auto-delete after 24h)
```

**Prompt for AI:**
> *"How can I organize files in OSS and automatically delete old files from the temp folder?"*

---

## Set Up Lifecycle Rules (Cost Optimization)

To automatically delete temporary files:

1. Go to your bucket → **Basic Settings** → **Lifecycle**
2. Create a rule to delete files in `temp/` folder after 1 day

---

## Common Issues

### "Access Denied"
- Check RAM user has correct permissions
- Verify AccessKey ID and Secret are correct
- Ensure bucket name matches

### "No Such Bucket"
- Verify bucket name is spelled correctly
- Check region matches between code and bucket location

### "CORS Error" (Browser Uploads)
- Configure CORS settings in OSS console
- Check allowed origins include your domain

---

## Security Best Practices

- ✅ Use **RAM users** instead of root account credentials
- ✅ Enable **server-side encryption** for sensitive data
- ✅ Use **private buckets** with signed URLs for access control
- ✅ Implement **lifecycle rules** to auto-delete old files
- ✅ Enable **access logging** to monitor usage
- ✅ Never commit credentials to Git (use `.env`)

> [!TIP]
> **See a finished example:** [STEP_3_COMPLETED.md](./reference_answer/STEP_3_COMPLETED.md)

---

[← Step 2: Alibaba Cloud Setup](STEP_2.md) | [Next Step: Explore WAN API →](STEP_4.md)
