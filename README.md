# AI Coding Workflow (Qwen)
*A beginner-friendly guide, with minimal setup to start coding with AI assistance*

> **What is "vibe coding"?**  

> *Vibe coding is a hilarious slang for using generative AI for software projects "This programmer is making software with nothing but vibes!". While there are lots of criticism about this approach, from an engineering perspective it has solved a significant bottleneck of software development - the learning curve.*

> *For myself, a practical and measured take on vibe coding is to treat it as if learning from a patient and kind software expert, applying what you learn, and solving real world problems all-in-one all in real-time.*

> *Code is a means to an end, real engineering comes from learning and applying - these fundementals are timeless and would apply with or without generative AI. This tutorial is less about generative AI, and much more about setting up a learning workflow.*


This tutorial walks you through the full beginner workflow using tools like **VS Code**, **Qwen Code**, **Python**, **npm**, and **Git**. You'll go from zero to sharing your first AI-assisted project on GitHub!

---

## 📋 Table of Contents
- [🛠️ Tools You'll Use (and Why)](#️-tools-youll-use-and-why)
- [✅ Step 1: Download and Install the Tools](#-step-1-download-and-install-the-tools)
- [📁 Step 1a: Set Up Your Working Folder](#-step-1a-set-up-your-working-folder)
- [👀 Step 1b (Optional): Get Comfortable with VS Code & Qwen Code](#-step-1b-optional-get-comfortable-with-vs-code--qwen-code)
- [🎯 Step 2: Plan Your Project ("Architecting & Engineering")](#-step-2-plan-your-project-architecting--engineering)
- [🔄 Step 3: The "Prompt → Test → Commit" Cycle](#-step-3-the-prompt--test--commit-cycle)
- [🌐 Share Your Work on GitHub](#-share-your-work-on-github)
- [🧘 Final Tips for Vibe Coding Success](#-final-tips-for-vibe-coding-success)

---

## 🛠️ Tools You'll Use (and Why)

<div align="center">
  
  
  
  
  
</div>

| Tool / Technology | Purpose | For Beginners |
|-------------------|---------|---------------|
| **<a href="https://code.visualstudio.com/"><img src="https://cdn.jsdelivr.net/gh/devicons/devicon/icons/vscode/vscode-original.svg" alt="VS Code" width="16" height="16" /> VS Code** | A free, powerful code editor | Your “digital notebook” for writing and editing code |
| **<a href="https://chat.qwen.ai/"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/lobehub/lobe-icons/refs/heads/master/packages/static-png/dark/qwen-color.png" /><img height="16px" width="16px" src="https://raw.githubusercontent.com/lobehub/lobe-icons/refs/heads/master/packages/static-png/light/qwen-color.png" /></picture> Qwen Code** | An AI coding assistant | Your virtual coding buddy that suggests, explains, and helps fix code |
| **<a href="https://www.python.org/downloads/"><img src="https://cdn.jsdelivr.net/gh/devicons/devicon/icons/python/python-original.svg" alt="Python" width="16" height="16" /> Python** | A beginner-friendly programming language | Great for scripts, AI, web apps, and more |
| **<a href="https://nodejs.org/"><img src="https://cdn.jsdelivr.net/gh/devicons/devicon/icons/npm/npm-original-wordmark.svg" alt="npm" width="16" height="16" /> npm** | Package manager for JavaScript/Node.js | Helps you install and manage libraries (even if you use Python later) |
| **<a href="https://git-scm.com/install/windows"><img src="https://cdn.jsdelivr.net/gh/devicons/devicon/icons/git/git-original.svg" alt="Git" width="16" height="16" /> Git** | Version control system | Saves snapshots of your work so you never lose progress |
| **<a href="https://github.com/"><img src="https://cdn.jsdelivr.net/gh/devicons/devicon/icons/github/github-original.svg" alt="GitHub" width="16" height="16" /> GitHub** | Online home for your code | Lets you share and back up your projects |

---

## ✅ Step 1: Download and Install the Tools

### 1. Install **VS Code** (or any IDE)
- Go to [VS Code Homepage](https://code.visualstudio.com/)
- Download for your OS (Windows, Mac, or Linux)
- Run the installer (keep defaults)
- Start VS Code (this is our core tool)


<img width="747" height="400" alt="image" src="https://github.com/user-attachments/assets/67ba2e09-dea2-4d76-91a8-9be96a22f191" />
<img width="742" height="400" alt="image" src="https://github.com/user-attachments/assets/15083683-5a6d-449b-9786-3df1c1472e86" />


### 2. Install **Python**
- Go to [Python Homepage](https://www.python.org/downloads/)
- Download the latest version
- ✅ **Important**: Check “Add Python to PATH” during install!
- Python is a intepreter for the coding language, we dont have to "start a program"

<img width="950" height="390" alt="image" src="https://github.com/user-attachments/assets/a96290e7-58a1-4f70-9cd4-705eac5dc656" />


### 3. Install **Node.js** (includes **npm**)
- Go to [Node.js Homepage](https://nodejs.org/)
- Download the **LTS** version (recommended for beginners)
- Run the installer
- Node.js is a runtime environment, and JIT compiler, we also do not technically run any exe file.

<img width="1142" height="400" alt="image" src="https://github.com/user-attachments/assets/83f2b96f-d1e4-4648-b8df-a8842ff9325d" />


> After installing, open VSC Terminal (Bash) and type the following:
> ```bash
> python --version
> npm --version
> git --version
> ```
> If these return version numbers, you’re good!

<img width="335" height="107" alt="image" src="https://github.com/user-attachments/assets/0109865d-2f8d-49f1-9ee0-3d1b92303208" />


### 4 (Optional). Get **Qwen Code**
- Option A: Use Qwen via web at [Qwen Chat](chat.qwen.ai)
  - You can copy-paste code between browser and VS Code
- Option B: Use **Qwen Code** (official Qwen Code extension)
  - Visit the official Qwen Code github repo for more details https://github.com/QwenLM/qwen-code

<img width="978" height="400" alt="image" src="https://github.com/user-attachments/assets/bca83e70-fb7f-4c9a-8ee4-6b8f84064520" />

---

## 📁 Step 1a: Set Up Your Working Folder

1. Open **File Explorer** ([Windows](https://support.microsoft.com/en-us/windows/file-explorer-in-windows-ef370130-1cca-9dc5-e0df-2f7416fe1cb1)) or **Finder** ([Mac](https://support.apple.com/en-sg/guide/mac-help/mchlp2605/mac))
2. Go to your **Documents** folder
3. Create a new folder called `my-first-ai-project`
4. In VS Code: `File → Open Folder` → Select this folder

<img width="539" height="496" alt="image" src="https://github.com/user-attachments/assets/d303df3b-5ea9-45dc-9ed9-9e5d2897dee2" />


You now have a clean workspace! Everything you build will live here.

---

## 👀 Step 1b (Optional): Get Comfortable with VS Code & Qwen Code

### In VS Code:
- **Explorer** (left sidebar): Your files and folders
- **Editor** (center): Where you write code
- **Terminal** (bottom): Type commands like `python your_script.py`
  - Open it with `Ctrl + `` ` (backtick) or `View → Terminal`

<img width="744" height="400" alt="image" src="https://github.com/user-attachments/assets/6d959832-2588-4a33-bc9a-414927eb3afa" />

### Using Qwen Code (via https://chat.qwen.ai/):
1. Highlight a piece of code or place your cursor where you want help
2. Press `Ctrl + L` (or right-click → “Ask Qwen”)
3. Type a prompt like:
   - “Explain this code”
   - “How do I read a file in Python?”
   - “Fix this error: …”

---

## 🎯 Step 2: Plan Your Project (“Architecting & Engineering”)

Before writing code, ask yourself:

### 🔍 What are you trying to build?
- Example: *“Make a batch emailer script that when run will send emails to my list of clients.”*
- Or try one of these sample projects:
  - **[Batch Emailer](./batch_emailer/README.md)** - STATUS: In Progress
  - **[Interactive Resume Page](./interactive_resume/README.md)** - STATUS: TBC
  - **[POS Data Analyzer](./pos_data_analyzer/README.md)** - STATUS: TBC

### ✅ What does “done” look like? (Define success)
- It runs without errors
- It reads my input files and sends emails with my selected template
- I can send it to any email including my friends email

### ⚙️ What technologies will you use?
- Language: **Python** (simple and readable)
- No external libraries needed (keep it beginner-friendly)
- Git for version control

> 💡 **AI Tip**: Treat Qwen like a senior dev teammate—be clear, specific, and polite!
> 🧠 **Learning**: Ask AI what are the technologies availabe to choose and weigh the pros and cons before making a decision.

### 📚 Sample Projects to Try
Here are some sample projects you can create using vibe coding to practice your skills:

- **[Batch Emailer](./batch_emailer/README.md)**: Learn about SMTP protocols and securing passwords with environment variables while creating a tool to send batch emails with HTML templates
- **[Interactive Resume Page](./interactive_resume/README.md)**: Build a dynamic resume web page using Node.js, npm packages, and Markdown parsing
- **[POS Data Analyzer](./pos_data_analyzer/README.md)**: Create a data visualization app to analyze Point of Sale data using Streamlit and SQLite3

---

## 🔄 Step 3: The “Prompt → Test → Commit” Cycle

This is your core workflow. Repeat as needed!

### 1. **Prompt** (Ask Qwen for help)
- Example prompt:  
  *“Write a python scripts that uses SMTP to send my email template to my friends email using my email.”*
- Paste Qwen’s response into a new file in VS Code: `email_script.py`

### 2. **Test** (Run and check)
- In VS Code Terminal:
  ```bash
  python email_script.py
  ```
- Try it! Does it work? If not:
  - Read the error
  - Copy it into Qwen: *“Why am I getting this error: …?”*

### 3. **Commit** (Save your progress with Git)
Every time you finish a small working version:
```bash
git add .
git commit -m "I added a new button"
```

> ✅ Each commit is a safe checkpoint. You can always go back!
> 🧠 **Learning**: Ask any AI Chatbot what Git is and "how to use Git like a pro"!

---

## 🌐 Share Your Work on GitHub

1. Go to [https://github.com](https://github.com) → Sign up (free)
2. Click **+ → New repository**
   - Name: `my-first-ai-project`
   - ✅ **Initialize with a README** (optional but helpful)
   - Click **Create**
3. Back in your VS Code terminal:
   ```bash
   git remote add origin https://github.com/YOUR_USERNAME/my-first-ai-project.git
   git branch -M main
   git push -u origin main
   ```
4. Visit your GitHub repo in the browser—you’ll see your code online!

> 🎉 Now you can share the link with friends or your future self!

---

## 🧘 Final Tips for Vibe Coding Success

- **Start tiny**: Build a 5-line script before a full app
- **Embrace errors**: They’re clues, not failures
- **Ask Qwen to explain**, not just give answers
- **Commit often**: “It works!” → commit. “Added color” → commit.
- **Have fun**: Coding + AI = creative superpower

---

> *Vibe coding is 50% Learning 40% Engineering Work 10% **Collaborating with AI** to build cool things. Congratulations on being part of shaping the future of software engineering!* 🚀
