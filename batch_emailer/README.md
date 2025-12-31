# Batch Emailer Project

This project demonstrates how to send batch emails using Python's SMTP protocol with HTML templates and environment variable security.

## What You'll Learn

- SMTP protocols and email sending
- HTML email templates
- Environment variable security for passwords
- Python's smtplib and email modules

## How to Create This Project

### 1. Set up your project structure
```
batch_emailer/
├── send_emails.py
├── email_template.html
├── recipients.csv
└── .env
```

### 2. Install required packages
```bash
pip install python-dotenv
```

### 3. Create your environment file (.env)
```
EMAIL_USER=your_email@gmail.com
EMAIL_PASS=your_app_password
```

### 4. Create an HTML email template (email_template.html)
```html
<!DOCTYPE html>
<html>
<head>
    <title>Newsletter</title>
</head>
<body>
    <h1>Hello {name}!</h1>
    <p>This is a personalized message for {name}.</p>
</body>
</html>
```

### 5. Write the Python script (send_emails.py)
```python
import smtplib
import csv
from email.mime.text import MIMEText
from email.mime.multipart import MIMEMultipart
from dotenv import load_dotenv
import os

load_dotenv()

def send_batch_emails():
    # Get email credentials from environment variables
    email_user = os.getenv('EMAIL_USER')
    email_pass = os.getenv('EMAIL_PASS')
    
    # Connect to server
    server = smtplib.SMTP('smtp.gmail.com', 587)
    server.starttls()
    server.login(email_user, email_pass)
    
    # Read recipients from CSV
    with open('recipients.csv', newline='') as csvfile:
        reader = csv.DictReader(csvfile)
        for row in reader:
            msg = MIMEMultipart()
            msg['Subject'] = 'Your Subject Here'
            msg['From'] = email_user
            msg['To'] = row['email']
            
            # Read HTML template and personalize
            with open('email_template.html', 'r') as template_file:
                html_content = template_file.read()
                html_content = html_content.replace('{name}', row['name'])
            
            msg.attach(MIMEText(html_content, 'html'))
            
            # Send email
            server.send_message(msg)
            print(f"Email sent to {row['name']} at {row['email']}")
    
    server.quit()

if __name__ == "__main__":
    send_batch_emails()
```

### 6. Create a recipients CSV file (recipients.csv)
```
name,email
John,john@example.com
Jane,jane@example.com
```

### 7. Run the script
```bash
python send_emails.py
```

## Security Best Practices

- Never hardcode passwords in your source code
- Use environment variables or .env files
- For Gmail, use App Passwords instead of your regular password
- Add .env to your .gitignore file to prevent committing secrets