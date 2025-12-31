# My AI Vibe Coding Workflow  
*A beginner-friendly guide to coding with AI assistance*

> **What is "vibe coding"?**  
> It’s a relaxed, iterative way of building software with the help of AI. Instead of writing everything yourself, you *collaborate* with an AI like Qwen Code to brainstorm, draft, debug, and refine your code—while you stay in control!

This tutorial walks you through the full beginner workflow using tools like **VS Code**, **Qwen Code**, **Python**, **npm**, and **Git**. You’ll go from zero to sharing your first AI-assisted project on GitHub!

---

## 🛠️ Tools You’ll Use (and Why)

| Tool | Purpose | For Beginners |
|------|---------|---------------|
| **VS Code** | A free, powerful code editor | Your “digital notebook” for writing and editing code |
| **Qwen Code** | An AI coding assistant | Your virtual coding buddy that suggests, explains, and helps fix code |
| **Python** | A beginner-friendly programming language | Great for scripts, AI, web apps, and more |
| **npm** | Package manager for JavaScript/Node.js | Helps you install and manage libraries (even if you use Python later) |
| **Git** | Version control system | Saves snapshots of your work so you never lose progress |
| **GitHub** | Online home for your code | Lets you share and back up your projects |

---

## ✅ Step 1: Download and Install the Tools

### 1. Install **VS Code**
- Go to [https://code.visualstudio.com/](https://code.visualstudio.com/)
- Download for your OS (Windows, Mac, or Linux)
- Run the installer (keep defaults)

### 2. Install **Python**
- Go to [https://www.python.org/downloads/](https://www.python.org/downloads/)
- Download the latest version (e.g., Python 3.12+)
- ✅ **Important**: Check “Add Python to PATH” during install!

### 3. Install **Node.js** (includes **npm**)
- Go to [https://nodejs.org/](https://nodejs.org/)
- Download the **LTS** version (recommended for beginners)
- Run the installer

> After installing, open your terminal (Command Prompt on Windows, Terminal on Mac/Linux) and check:
> ```bash
> python --version
> npm --version
> git --version
> ```
> If these return version numbers, you’re good!

### 4. Get **Qwen Code**
- Option A: Use **Tongyi Lingma** (official Qwen Code extension)
  - In VS Code: Go to Extensions → Search “Tongyi Lingma” → Install
- Option B: Use Qwen via web at [https://tongyi.aliyun.com/qianwen/](https://tongyi.aliyun.com/qianwen/)
  - You can copy-paste code between browser and VS Code

---

## 👀 Step 1a: Get Comfortable with VS Code & Qwen Code

### In VS Code:
- **Explorer** (left sidebar): Your files and folders
- **Editor** (center): Where you write code
- **Terminal** (bottom): Type commands like `python your_script.py`
  - Open it with `Ctrl + `` ` (backtick) or `View → Terminal`

### Using Qwen Code (via Tongyi Lingma):
1. Highlight a piece of code or place your cursor where you want help
2. Press `Ctrl + L` (or right-click → “Ask Qwen”)
3. Type a prompt like:
   - “Explain this code”
   - “How do I read a file in Python?”
   - “Fix this error: …”

> 💡 **Tip**: Treat Qwen like a senior dev teammate—be clear, specific, and polite!

---

## 📁 Step 2: Set Up Your Working Folder

1. Open **File Explorer** (Windows) or **Finder** (Mac)
2. Go to your **Documents** folder
3. Create a new folder called `my-first-ai-project`
4. In VS Code: `File → Open Folder` → Select this folder

You now have a clean workspace! Everything you build will live here.

---

## 🎯 Step 3: Plan Your Project (“Architecting & Engineering”)

Before writing code, ask yourself:

### 🔍 What are you trying to build?
- Example: *“A Python script that asks for your name and says hello.”*

### ✅ What does “done” look like? (Define success)
- It runs without errors
- It asks for input and prints a personalized message
- You can show it to a friend

### ⚙️ What technologies will you use?
- Language: **Python** (simple and readable)
- No external libraries needed (keep it beginner-friendly)
- Git for version control

> 🧠 **AI Tip**: Ask Qwen, *“Give me 3 simple Python project ideas for beginners”* if you’re stuck!

---

## 🔄 Step 4: The “Prompt → Test → Commit” Cycle

This is your core workflow. Repeat as needed!

### 1. **Prompt** (Ask Qwen for help)
- Example prompt:  
  *“Write a Python script that asks the user for their name and prints ‘Hello, [name]!’”*

- Paste Qwen’s response into a new file in VS Code: `hello.py`

### 2. **Test** (Run and check)
- In VS Code Terminal:
  ```bash
  python hello.py
  ```
- Try it! Does it work? If not:
  - Read the error
  - Copy it into Qwen: *“Why am I getting this error: …?”*

### 3. **Commit** (Save your progress with Git)
First time only:
```bash
git config --global user.name "Your Name"
git config --global user.email "you@example.com"
git init
```

Then, every time you finish a small working version:
```bash
git add hello.py
git commit -m "Add working hello script"
```

> ✅ Each commit is a safe checkpoint. You can always go back!

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

> You’re not just learning to code—you’re learning to **collaborate with AI** to build cool things. That’s the future. Welcome aboard! 🚀

*— Inspired by your workflow, Sin*