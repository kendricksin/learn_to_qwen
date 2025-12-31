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
