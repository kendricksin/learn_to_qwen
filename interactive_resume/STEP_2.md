# Step 2: Paste Your Plan into AI Chat

Now that you have a plan, it's time to start collaborating with the AI.

### The Prompt

Copy your `plan.md` and ask the AI to create a setup script:

> Help me build my resume website given the following plan.md input. Create a shell script to setup my project folder.
>
> [Paste your plan.md content here]

### What to Expect

The AI should provide:

1. **A shell script (`create.sh`)** that sets up your entire project:
   - Creates folder structure
   - Generates HTML, CSS, and JS files
   - Creates a sample `resume.json`

2. **Instructions for GitHub Pages deployment**
   - How to create a repository
   - How to enable GitHub Pages
   - How to push your code

### Example Response

The AI will give you something like:

```bash
#!/bin/bash
# create.sh - Sets up the interactive resume project

mkdir -p interactive_resume/src/{css,js}
# ... creates all necessary files
```

### Pro-Tips

- Ask for a **single shell script** that does everything - easier to run and reproduce.
- If the output is too long, ask: *"Can you combine this into one setup script?"*
- Request the script includes a sample `resume.json` with placeholder data.

> [!TIP]
> **See a finished example:** [STEP_2_COMPLETED.md](./reference_answer/STEP_2_COMPLETED.md)

---
[← Step 1: Planning](STEP_1.md) | [Next Step: Run the Setup Script →](STEP_3.md)
