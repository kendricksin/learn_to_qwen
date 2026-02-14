# Step 1: Fill out your plan.md

A good plan is the foundation of a successful AI-assisted project. This project is more complex than a simple static website because it involves cloud services, APIs, and asynchronous operations.

Use AI to help you answer each question:

## Question 1: What are you trying to build?

Ask the AI to help you define your goals:

> *"I want to build a video editing tool that swaps characters in videos for personalized marketing. What features should I include?"*

**Key considerations:**
- **User Flow**: How do users interact with your tool?
- **Input Requirements**: What files/data do users need to provide?
- **Output Format**: What do users get back (video URL, download link, etc.)?
- **Use Cases**: Who is this for? (Small businesses, content creators, marketers?)

## Question 2: What does 'done' look like?

Put yourself in the user's perspective:

> *"What makes a good video editing web app? What should happen when a user uploads files?"*

**Success criteria:**
- ✅ Users can upload an image (character) and video (template)
- ✅ System processes the video using WAN API without errors
- ✅ Results are stored securely and accessible to the user
- ✅ Processing status is clearly communicated (loading states)
- ✅ Users can download or share the final video
- ✅ Error messages are helpful and actionable

## Question 3: What technologies will you use?

Ask AI for recommendations:

> *"What tech stack should I use for a video processing web app that uses Alibaba Cloud APIs? Consider backend, frontend, and cloud services."*

**Consider:**
- **Backend**: Node.js (JavaScript) is great for async operations and has good OSS SDK support
- **Frontend**: Start simple (HTML/CSS/JS), can upgrade to React later
- **Cloud Services**: WAN Animate Mix API + OSS for storage
- **Deployment**: Where will this run? (Local dev vs cloud hosting)

---

## Question 4: What are the technical challenges?

This project has unique challenges compared to simpler projects:

> *"What are common challenges when building apps that use cloud APIs and handle large file uploads?"*

**Key challenges:**
1. **Authentication**: Managing API keys and service account credentials securely
2. **Async Processing**: Videos take time to process - how to handle this UX-wise?
3. **File Uploads**: Large video files need special handling
4. **Cost Control**: API calls cost money - how to prevent abuse?
5. **Error Handling**: Network issues, API failures, invalid files

---

## Create Your `plan.md`

Create a file named `plan.md` in your project folder. Here's a template:

```markdown
## Project Overview
I want to build an AI-powered video editing tool that uses character swap technology to create personalized promotional campaigns.

## 1. What are you trying to build?
- A web app where users upload a character image and template video
- The system swaps the character in the video using WAN Animate Mix API
- Users can download the personalized video result
- Designed for marketers and content creators making personalized campaigns

## 2. What does 'done' look like?
- Clean web interface with drag-and-drop file upload
- Real-time progress updates during processing
- Secure storage of user videos in OSS
- Downloadable results with shareable links
- Clear error messages for failed uploads/processing
- Basic usage tracking to prevent cost overruns

## 3. What technologies will you use?
- Backend: Node.js with Express
- Frontend: HTML, CSS, Vanilla JavaScript (or React if I want to learn it)
- API: Alibaba Cloud WAN Animate Mix API
- Storage: Alibaba Cloud OSS
- Environment: Environment variables for API keys

## Additional Requirements
- Security: Never expose API keys in client-side code
- UX: Show loading indicators for long-running tasks
- Cost Control: Limit requests per user/session
- File Validation: Check file types and sizes before upload

## Specific Questions
- How do I set up OSS service accounts with minimal permissions?
- What's the best way to poll the WAN API for task completion?
- Should I store videos temporarily or use direct OSS upload from browser?
- How can I implement a simple queue for multiple video requests?
```

---

## Pro-Tips

- **Start Simple**: Get the basic flow working first (upload → API call → result), then add polish
- **Security First**: Never commit API keys to Git. Use environment variables from day one.
- **Cost Awareness**: Understand pricing before building. Set up billing alerts in Alibaba Cloud console.
- **Ask for Examples**: Request sample code for OSS upload and WAN API calls from the AI

> [!TIP]
> **See a finished example:** [STEP_1_COMPLETED.md](./reference_answer/STEP_1_COMPLETED.md)

---

[← Back to Overview](README.md) | [Next Step: Alibaba Cloud Setup →](STEP_2.md)
