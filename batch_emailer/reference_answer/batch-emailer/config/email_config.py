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
