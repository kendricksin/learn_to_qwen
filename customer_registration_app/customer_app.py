import sqlite3
import os
from datetime import datetime

class CustomerRegistrationApp:
    def __init__(self):
        self.db_name = 'customers.db'
        self.init_database()
    
    def init_database(self):
        """Initialize the database and create the customers table if it doesn't exist"""
        conn = sqlite3.connect(self.db_name)
        cursor = conn.cursor()
        
        # Create customers table if it doesn't exist
        cursor.execute('''
            CREATE TABLE IF NOT EXISTS customers (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                name TEXT NOT NULL,
                email TEXT UNIQUE NOT NULL,
                phone TEXT,
                registration_date TEXT NOT NULL
            )
        ''')
        
        conn.commit()
        conn.close()
    
    def add_customer(self, name, email, phone):
        """Add a new customer to the database"""
        try:
            conn = sqlite3.connect(self.db_name)
            cursor = conn.cursor()
            
            # Check if customer with this email already exists
            cursor.execute("SELECT * FROM customers WHERE email = ?", (email,))
            existing_customer = cursor.fetchone()
            
            if existing_customer:
                print(f"Customer with email {email} already exists!")
                return False
            
            # Insert new customer
            cursor.execute('''
                INSERT INTO customers (name, email, phone, registration_date)
                VALUES (?, ?, ?, ?)
            ''', (name, email, phone, datetime.now().strftime('%Y-%m-%d %H:%M:%S')))
            
            conn.commit()
            conn.close()
            
            print(f"Customer {name} added successfully!")
            return True
        except sqlite3.Error as e:
            print(f"Database error: {e}")
            return False
    
    def view_all_customers(self):
        """Display all customers in the database"""
        try:
            conn = sqlite3.connect(self.db_name)
            cursor = conn.cursor()
            
            cursor.execute("SELECT id, name, email, phone, registration_date FROM customers ORDER BY id")
            customers = cursor.fetchall()
            
            if not customers:
                print("No customers found in the database.")
            else:
                print("\n--- Customer List ---")
                print(f"{'ID':<5} {'Name':<20} {'Email':<30} {'Phone':<15} {'Date':<20}")
                print("-" * 85)
                
                for customer in customers:
                    id, name, email, phone, date = customer
                    phone = phone if phone else "N/A"
                    print(f"{id:<5} {name:<20} {email:<30} {phone:<15} {date:<20}")
            
            conn.close()
        except sqlite3.Error as e:
            print(f"Database error: {e}")
    
    def find_customer(self, search_term):
        """Find a customer by name or email"""
        try:
            conn = sqlite3.connect(self.db_name)
            cursor = conn.cursor()
            
            # Search by name or email
            cursor.execute('''
                SELECT id, name, email, phone, registration_date 
                FROM customers 
                WHERE name LIKE ? OR email LIKE ?
            ''', (f'%{search_term}%', f'%{search_term}%'))
            
            customers = cursor.fetchall()
            
            if not customers:
                print(f"No customers found matching '{search_term}'.")
            else:
                print(f"\n--- Search Results for '{search_term}' ---")
                print(f"{'ID':<5} {'Name':<20} {'Email':<30} {'Phone':<15} {'Date':<20}")
                print("-" * 85)
                
                for customer in customers:
                    id, name, email, phone, date = customer
                    phone = phone if phone else "N/A"
                    print(f"{id:<5} {name:<20} {email:<30} {phone:<15} {date:<20}")
            
            conn.close()
        except sqlite3.Error as e:
            print(f"Database error: {e}")
    
    def run(self):
        """Main application loop"""
        print("Welcome to the Customer Registration Application!")
        print("Type 'help' for available commands.")
        
        while True:
            command = input("\nEnter command (add/view/search/quit): ").strip().lower()
            
            if command == 'quit' or command == 'q':
                print("Thank you for using the Customer Registration Application!")
                break
            elif command == 'add':
                print("\n--- Add New Customer ---")
                name = input("Enter customer name: ").strip()
                email = input("Enter customer email: ").strip()
                phone = input("Enter customer phone (optional): ").strip()
                
                if name and email:
                    self.add_customer(name, email, phone if phone else None)
                else:
                    print("Name and email are required!")
                    
            elif command == 'view':
                self.view_all_customers()
                
            elif command == 'search':
                search_term = input("Enter name or email to search: ").strip()
                if search_term:
                    self.find_customer(search_term)
                else:
                    print("Please enter a search term.")
                    
            elif command == 'help':
                print("\nAvailable commands:")
                print("  add    - Add a new customer")
                print("  view   - View all customers")
                print("  search - Search for a customer by name or email")
                print("  quit   - Exit the application")
                
            else:
                print("Unknown command. Type 'help' for available commands.")

if __name__ == "__main__":
    app = CustomerRegistrationApp()
    app.run()