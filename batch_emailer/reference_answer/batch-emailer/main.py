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
