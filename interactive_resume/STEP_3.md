# Step 3: Run the Setup Script & Test Locally

Time to bring your project to life! Follow these steps to set up and test your resume website.

### Step 3.1: Create the Setup Script

1. Create a new file called `create.sh` in your project folder
2. Paste the shell script from the AI into this file
3. Save the file

### Step 3.2: Run the Script

Open your terminal and run:

```bash
chmod +x create.sh
./create.sh
```

This will create your project folder with all the necessary files.

### Step 3.3: Test Locally

Navigate to your project folder and start a local server:

```bash
cd interactive_resume
npx serve .
```

Or if you prefer Python:

```bash
cd interactive_resume
python -m http.server 8000
```

### Step 3.4: View in Browser

Open your browser and go to:
- `http://localhost:3000` (if using npx serve)
- `http://localhost:8000` (if using Python)

You should see your resume website!

### Troubleshooting

If something doesn't work, copy the error and ask the AI:

> *"I'm getting this error when running my setup script: [paste error]. How do I fix it?"*

### Pro-Tips

- Keep your terminal open to see any errors
- Use browser DevTools (F12) to debug CSS/JS issues
- Make small changes and refresh to see results

> [!TIP]
> **See a finished example:** [STEP_3_COMPLETED.md](./reference_answer/STEP_3_COMPLETED.md)

---
[← Step 2: Prompting](STEP_2.md) | [Next Step: Deploy to GitHub Pages →](STEP_4.md)
