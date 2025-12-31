#!/bin/bash

# Create project directory and navigate into it
mkdir -p batch-emailer
cd batch-emailer

# Create directory structure
mkdir -p config templates data utils

# Create .gitignore file
cat > .gitignore << 'EOF'
# Environment variables
.env

# Python
__pycache__/
*.pyc
*.pyo
*.pyd
.Python
env/
venv/
ENV/
.venv/
.env
.pytest_cache/
.coverage
htmlcov/

# IDE
.vscode/
.idea/
*.swp
*.swo

# OS
.DS_Store
Thumbs.db
EOF

# Create requirements.txt
cat > requirements.txt << 'EOF'
python-dotenv==1.0.1
pandas==2.2.2
jinja2==3.1.4
EOF

# Create main.py
cat > main.py << 'EOF'
from utils.email_sender import send_batch_emails
from config.email_config import load_email_config

def main():
    config = load_email_config()
    # Example usage - customize based on your needs
    send_batch_emails(
        smtp_server=config['smtp_server'],
        smtp_port=config['smtp_port'],
        sender_email=config['email_address'],
        sender_password=config['email_password'],
        recipients_file='data/recipients.csv',
        template_file='templates/email_template.html'
    )

if __name__ == "__main__":
    main()
EOF

# Create config/email_config.py
cat > config/email_config.py << 'EOF'
import os
from dotenv import load_dotenv

def load_email_config():
    """Load email configuration from environment variables."""
    load_dotenv()
    
    return {
        'email_address': os.getenv('EMAIL_ADDRESS'),
        'email_password': os.getenv('EMAIL_PASSWORD'),
        'smtp_server': os.getenv('SMTP_SERVER', 'smtp.gmail.com'),
        'smtp_port': int(os.getenv('SMTP_PORT', '587'))
    }
EOF

# Create templates/email_template.html
cat > templates/email_template.html << 'EOF'
<!DOCTYPE html>
<html>
<head>
    <title>Email Template</title>
</head>
<body>
    <h1>Hello {{ name }}!</h1>
    <p>This is a personalized message for you.</p>
    <p>Best regards,<br>Your Name</p>
</body>
</html>
EOF

# Create data/recipients.csv sample
cat > data/recipients.csv << 'EOF'
name,email
John Doe,john@example.com
Jane Smith,jane@example.com
Bob Johnson,bob@example.com
EOF

# Create utils/email_sender.py
cat > utils/email_sender.py << 'EOF'
import smtplib
import pandas as pd
from email.mime.text import MIMEText
from email.mime.multipart import MIMEMultipart
from jinja2 import Template
import os
from dotenv import load_dotenv

def send_batch_emails(smtp_server, smtp_port, sender_email, sender_password, recipients_file, template_file):
    """Send batch emails to multiple recipients with personalized content."""
    load_dotenv()
    
    # Read recipient data
    df = pd.read_csv(recipients_file)
    
    # Load email template
    with open(template_file, 'r', encoding='utf-8') as f:
        template_content = f.read()
    template = Template(template_content)
    
    # Create SMTP session
    server = smtplib.SMTP(smtp_server, smtp_port)
    server.starttls()  # Enable encryption
    server.login(sender_email, sender_password)
    
    for index, row in df.iterrows():
        # Render personalized email content
        email_body = template.render(name=row['name'])
        
        # Create email message
        msg = MIMEMultipart()
        msg['From'] = sender_email
        msg['To'] = row['email']
        msg['Subject'] = f"Personalized message for {row['name']}"
        
        # Attach HTML content
        msg.attach(MIMEText(email_body, 'html'))
        
        # Send email
        try:
            server.send_message(msg)
            print(f"Email sent successfully to {row['email']}")
        except Exception as e:
            print(f"Failed to send email to {row['email']}: {str(e)}")
    
    server.quit()
    print("All emails processed.")
EOF

# Create .env file (with placeholders)
cat > .env << 'EOF'
EMAIL_ADDRESS=your-email@gmail.com
EMAIL_PASSWORD=your-app-password
SMTP_SERVER=smtp.gmail.com
SMTP_PORT=587
EOF

echo "Batch emailer project structure created successfully!"
echo ""
echo "Next steps:"
echo "1. Fill in your actual email credentials in the .env file"
echo "2. Update the recipients.csv file with your recipient data"
echo "3. Customize the email template as needed"
echo "4. Install dependencies: pip install -r requirements.txt"
echo "5. Run the script: python main.py"