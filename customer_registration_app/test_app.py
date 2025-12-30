import sqlite3
import os
from datetime import datetime
import sys

# Add the current directory to the path so we can import our app
sys.path.append('/home/kendrick/learn_to_qwen')

# Import our application
from customer_app import CustomerRegistrationApp

def test_app():
    print("Testing the Customer Registration Application...")
    
    # Create an instance of the app
    app = CustomerRegistrationApp()
    
    # Test adding customers
    print("\n1. Testing customer addition...")
    result1 = app.add_customer("John Doe", "john@example.com", "123-456-7890")
    result2 = app.add_customer("Jane Smith", "jane@example.com", "098-765-4321")
    result3 = app.add_customer("Bob Johnson", "bob@example.com", None)
    
    print(f"Added John Doe: {result1}")
    print(f"Added Jane Smith: {result2}")
    print(f"Added Bob Johnson: {result3}")
    
    # Test duplicate email
    print("\n2. Testing duplicate email prevention...")
    result_duplicate = app.add_customer("John Doe 2", "john@example.com", "111-222-3333")
    print(f"Attempted to add duplicate email: {result_duplicate}")
    
    # Test viewing all customers
    print("\n3. Testing view all customers...")
    app.view_all_customers()
    
    # Test searching for a customer
    print("\n4. Testing search functionality...")
    app.find_customer("John")
    app.find_customer("jane@example.com")
    
    # Verify database was created
    print("\n5. Verifying database file exists...")
    if os.path.exists('customers.db'):
        print("Database file 'customers.db' exists!")
        
        # Check the contents of the database
        conn = sqlite3.connect('customers.db')
        cursor = conn.cursor()
        cursor.execute("SELECT COUNT(*) FROM customers")
        count = cursor.fetchone()[0]
        print(f"Number of customers in database: {count}")
        conn.close()
    else:
        print("Database file 'customers.db' was not created!")
    
    print("\nTest completed successfully!")

if __name__ == "__main__":
    test_app()