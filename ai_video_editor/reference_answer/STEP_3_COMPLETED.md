# Step 3 Reference: OSS Configuration Completed

This shows what a successful OSS setup looks like after completing Step 3.

## AI Chat Sessions (Examples)

- [What is OSS bucket?](https://chat.qwen.ai/s/t_6c2e43c3-90a0-4665-b281-ce5a11cfad21?fev=0.2.7)
- [What is the AccessKey and how do I secure it? What to do if I commit it?](https://chat.qwen.ai/s/t_e51a15b1-0298-4f72-a434-d28401271f7a?fev=0.2.7)

## Screenshots

### OSS Bucket Creation
_Add screenshots of:_
- [ ] OSS Console showing bucket list
- [ ] Create bucket dialog with settings
- [ ] Bucket successfully created confirmation
- [ ] Bucket overview page

### RAM User Setup
_Add screenshots of:_
- [ ] RAM Console with new user created
- [ ] User permissions/policies attached
- [ ] AccessKey credentials shown (redacted)

### OSS Configuration
_Add screenshots of:_
- [ ] CORS settings configured
- [ ] Lifecycle rules (if set up)
- [ ] Bucket properties/settings

---

## Completed Checklist

After Step 3, you should have:

### ✅ OSS Bucket Created
- [x] Bucket name chosen (e.g., `my-video-editor-bucket`)
- [x] Region matches API region
- [x] Storage class: Standard
- [x] Access control: Private
- [x] Server-side encryption: Enabled

### ✅ RAM User (Service Account) Created
- [x] RAM user created: `video-editor-service`
- [x] Programmatic access enabled
- [x] AccessKey ID obtained
- [x] AccessKey Secret saved securely
- [x] Permissions attached (OSS access)

### ✅ Environment Variables Updated
- [x] `OSS_ACCESS_KEY_ID` added to `.env`
- [x] `OSS_ACCESS_KEY_SECRET` added to `.env`
- [x] `OSS_REGION` set correctly
- [x] `OSS_BUCKET` name added

### ✅ OSS SDK Tested
- [x] `ali-oss` package installed
- [x] Test upload script runs successfully
- [x] File uploaded to bucket
- [x] File downloaded successfully
- [x] File deleted successfully

### ✅ Optional: CORS & Lifecycle
- [x] CORS configured (if using browser uploads)
- [x] Lifecycle rule for temp files (optional)

---

## Sample Updated `.env` File

```bash
# Alibaba Cloud DashScope API Configuration
DASHSCOPE_API_KEY=sk-abc123def456...
DASHSCOPE_REGION=singapore

# OSS Configuration
OSS_ACCESS_KEY_ID=LTAI5t...  # ← Your RAM user AccessKey ID
OSS_ACCESS_KEY_SECRET=xyz789...  # ← Your RAM user Secret
OSS_REGION=oss-ap-southeast-1  # Singapore
OSS_BUCKET=my-video-editor-bucket

# Application Configuration
PORT=3000
NODE_ENV=development
```

---

## Test Script Results

After running the OSS test script, you should see:

```bash
$ npm install ali-oss dotenv
$ node test-oss.js

✓ Upload successful!
URL: https://my-video-editor-bucket.oss-ap-southeast-1.aliyuncs.com/test.txt
✓ Download successful!
✓ Delete successful!
```

---

## OSS Bucket Structure

Your bucket should have this folder structure:

```
my-video-editor-bucket/
├── uploads/
│   ├── images/          # User uploaded character images
│   └── videos/          # User uploaded template videos
├── results/             # Generated videos from WAN API
└── temp/                # Temporary files (auto-delete after 24h)
```

---

## RAM User Permissions (Minimal Policy)

For security, use this minimal permission policy:

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

This allows only:
- Upload files
- Download files
- Delete files
- List files

But NOT create/delete buckets or modify bucket settings.

---

## Common Issues & Solutions

### ❌ "Access Denied"
**Solution**:
- Verify RAM user has OSS permissions attached
- Check AccessKey ID and Secret are correct
- Ensure bucket name matches exactly (case-sensitive)

### ❌ "No Such Bucket"
**Solution**:
- Verify bucket name spelling
- Check region in code matches bucket region
- Confirm bucket exists in OSS console

### ❌ "CORS Error" (Browser Uploads)
**Solution**:
- Go to OSS Console → Your Bucket → Access Control → CORS
- Add rule with allowed origins: `*` (for testing)
- Set allowed methods: GET, POST, PUT, DELETE, HEAD

### ❌ Test Upload Fails
**Solution**:
- Check internet connection
- Verify `.env` file is in the same directory
- Ensure `dotenv` is installed: `npm install dotenv`
- Check for typos in environment variable names

---

## Pro-Tips

💡 **Security Best Practices**:
- Use RAM users (service accounts), never root account
- Follow principle of least privilege
- Enable server-side encryption
- Use private buckets with signed URLs

💡 **Cost Optimization**:
- Set lifecycle rules to auto-delete temp files
- Use standard storage for active files
- Archive old videos to cheaper storage class
- Enable OSS logs to track usage

💡 **File Organization**:
- Use clear folder structure (`uploads/`, `results/`)
- Include timestamps in filenames
- Store metadata separately (database or JSON)

---

[← Back to Step 3](../STEP_3.md) | [Next: Step 4 Reference →](STEP_4_COMPLETED.md)
