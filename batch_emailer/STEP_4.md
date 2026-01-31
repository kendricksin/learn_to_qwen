# Step 4: Build & Run the Script

Time to bring your batch emailer to life! Follow these steps to set up and test your email sender.

### Step 4.1: Set Up Your Project Files

Organize your project folder with these files:
```
batch_emailer/
├── main.py           # Main Python script
├── .env              # Email credentials (NEVER commit this!)
├── template.html     # Your email template
├── recipients.csv    # List of recipients
└── requirements.txt  # Python dependencies
```

### Step 4.2: Configure Environment Variables

Create a `.env` file with your email credentials:

```env
EMAIL_ADDRESS=your.email@gmail.com
EMAIL_PASSWORD=your_app_password
SMTP_SERVER=smtp.gmail.com
SMTP_PORT=587
```

> **Important:** For Gmail, you need to use an [App Password](https://support.google.com/accounts/answer/185833), not your regular password.

### Step 4.3: Install Dependencies

```bash
pip install -r requirements.txt
```

Or install directly:
```bash
pip install python-dotenv
```

### Step 4.4: Test with a Single Email

Before sending to everyone, test with yourself:

```bash
python main.py --test
```

Or modify `recipients.csv` to only include your email first.

### Step 4.5: Run the Full Script

Once testing is successful:

```bash
python main.py
```

### Troubleshooting

If you get errors, ask the AI:

> *"I'm getting this error when running my email script: [paste error]. How do I fix it?"*

**Common issues:**
- Gmail blocking: Enable "Less secure app access" or use App Passwords
- SMTP authentication failed: Check your credentials in `.env`
- Connection timeout: Check your internet connection and SMTP settings

### Final Checklist

- [ ] Test email received successfully
- [ ] Email template looks correct
- [ ] Personalization (names) working
- [ ] `.env` file is in `.gitignore`

### Congratulations!

You've built a working batch email system!

> [!TIP]
> **See a finished example:** [STEP_4_COMPLETED.md](./reference_answer/STEP_4_COMPLETED.md)

---
[← Step 3: Iterating & Refining](STEP_3.md) | [Back to Overview](README.md)
