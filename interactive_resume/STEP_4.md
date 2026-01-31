# Step 4: Deploy to GitHub Pages

You're almost there! Time to share your resume with the world.

### Step 4.1: Create a GitHub Repository

1. Go to [github.com](https://github.com) and sign in
2. Click the **+** icon → **New repository**
3. Name it something like `interactive_resume` or `my-resume`
4. Make it **Public** (required for free GitHub Pages)
5. Click **Create repository**

### Step 4.2: Clone and Add Your Project

```bash
# Clone the empty repo
git clone https://github.com/YOUR_USERNAME/interactive_resume.git

# Copy your project files into the cloned folder
cp -r interactive_resume/* ./interactive_resume/

# Or if you built in place, just initialize git
cd interactive_resume
git init
git remote add origin https://github.com/YOUR_USERNAME/interactive_resume.git
```

### Step 4.3: Commit and Push

```bash
git add .
git commit -m "Initial commit - interactive resume"
git push -u origin main
```

### Step 4.4: Enable GitHub Pages

1. Go to your repository on GitHub
2. Click **Settings** → **Pages** (in the left sidebar)
3. Under "Source", select **main** branch
4. Select **/ (root)** folder
5. Click **Save**

Wait 1-2 minutes, then visit: `https://YOUR_USERNAME.github.io/interactive_resume/`

### Final Checklist

- [ ] Resume loads correctly on the live URL
- [ ] All links work (LinkedIn, GitHub, email)
- [ ] PDF download works
- [ ] Mobile view looks good
- [ ] Dark/light mode toggle works

### Congratulations!

You've deployed your interactive resume! Share the link on your LinkedIn profile, email signature, or business card.

> [!TIP]
> **See a finished example:** [STEP_4_COMPLETED.md](./reference_answer/STEP_4_COMPLETED.md)

---
[← Step 3: Testing](STEP_3.md) | [Back to Overview](README.md)
