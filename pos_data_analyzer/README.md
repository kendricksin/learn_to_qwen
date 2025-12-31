# POS Data Analyzer with Streamlit

This project demonstrates how to create a web application to analyze Point of Sale (POS) data using Streamlit and SQLite3 database.

## What You'll Learn

- Working with SQLite3 databases in Python
- SQL queries for data analysis
- Creating interactive web apps with Streamlit
- Data visualization with pandas and plotly
- Building analytical dashboards

## How to Create This Project

### 1. Set up your project structure
```
pos_data_analyzer/
├── app.py
├── pos_data.db
├── requirements.txt
└── data/
    └── sales_data.csv
```

### 2. Install required packages
Create a requirements.txt file:
```
streamlit
pandas
plotly
sqlite3
```

Then install:
```bash
pip install -r requirements.txt
```

### 3. Create a sample SQLite database with POS data
```python
import sqlite3
import pandas as pd

# Connect to database (creates it if it doesn't exist)
conn = sqlite3.connect('pos_data.db')
cursor = conn.cursor()

# Create sales table
cursor.execute('''
CREATE TABLE IF NOT EXISTS sales (
    id INTEGER PRIMARY KEY,
    date TEXT,
    product_name TEXT,
    category TEXT,
    quantity INTEGER,
    unit_price REAL,
    total_price REAL,
    customer_id TEXT
)
''')

# Sample data
sample_data = [
    ('2023-01-15', 'Laptop', 'Electronics', 1, 999.99, 999.99, 'CUST001'),
    ('2023-01-15', 'Mouse', 'Accessories', 2, 25.50, 51.00, 'CUST001'),
    ('2023-01-16', 'Keyboard', 'Accessories', 1, 75.00, 75.00, 'CUST002'),
    ('2023-01-17', 'Monitor', 'Electronics', 1, 299.99, 299.99, 'CUST003'),
    ('2023-01-18', 'Desk Chair', 'Furniture', 1, 149.99, 149.99, 'CUST004'),
    ('2023-01-19', 'Webcam', 'Electronics', 1, 89.99, 89.99, 'CUST005'),
    ('2023-01-20', 'Notebook', 'Stationery', 5, 5.99, 29.95, 'CUST006'),
    ('2023-01-21', 'Pen Set', 'Stationery', 1, 19.99, 19.99, 'CUST007'),
]

# Insert sample data
cursor.executemany('''
INSERT INTO sales (date, product_name, category, quantity, unit_price, total_price, customer_id)
VALUES (?, ?, ?, ?, ?, ?, ?)
''', sample_data)

conn.commit()
conn.close()
```

### 4. Create the Streamlit app (app.py)
```python
import streamlit as st
import sqlite3
import pandas as pd
import plotly.express as px

# Set page config
st.set_page_config(
    page_title="POS Data Analyzer",
    page_icon="📊",
    layout="wide"
)

# Title
st.title("🏪 POS Data Analyzer")
st.markdown("Analyze your Point of Sale data with interactive visualizations")

# Connect to database
@st.cache_data
def load_data():
    conn = sqlite3.connect('pos_data.db')
    df = pd.read_sql_query("SELECT * FROM sales", conn)
    conn.close()
    return df

df = load_data()

# Sidebar filters
st.sidebar.header("Filters")

# Date range filter
dates = pd.to_datetime(df['date'])
min_date = dates.min().date()
max_date = dates.max().date()
date_range = st.sidebar.date_input(
    "Select date range",
    value=(min_date, max_date),
    min_value=min_date,
    max_value=max_date
)

# Category filter
categories = st.sidebar.multiselect(
    'Select categories',
    options=df['category'].unique(),
    default=df['category'].unique()
)

# Apply filters
if len(date_range) == 2:
    start_date, end_date = date_range
    df_filtered = df[
        (pd.to_datetime(df['date']).dt.date >= start_date) & 
        (pd.to_datetime(df['date']).dt.date <= end_date) &
        (df['category'].isin(categories))
    ]
else:
    df_filtered = df[df['category'].isin(categories)]

# Main dashboard
col1, col2, col3, col4 = st.columns(4)

# KPIs
with col1:
    st.metric(
        label="Total Sales",
        value=f"${df_filtered['total_price'].sum():,.2f}"
    )

with col2:
    st.metric(
        label="Total Transactions",
        value=len(df_filtered)
    )

with col3:
    st.metric(
        label="Average Transaction",
        value=f"${df_filtered['total_price'].mean():.2f}"
    )

with col4:
    st.metric(
        label="Top Category",
        value=df_filtered.groupby('category')['total_price'].sum().idxmax() if not df_filtered.empty else "N/A"
    )

# Charts
st.subheader("Sales Analysis")

# Sales by category
sales_by_category = df_filtered.groupby('category')['total_price'].sum().reset_index()
fig1 = px.bar(
    sales_by_category,
    x='category',
    y='total_price',
    title='Sales by Category',
    color='category'
)
st.plotly_chart(fig1, use_container_width=True)

# Sales over time
df_filtered['date'] = pd.to_datetime(df_filtered['date'])
sales_over_time = df_filtered.groupby(df_filtered['date'].dt.date)['total_price'].sum().reset_index()
fig2 = px.line(
    sales_over_time,
    x='date',
    y='total_price',
    title='Sales Over Time'
)
st.plotly_chart(fig2, use_container_width=True)

# Detailed data table
st.subheader("Detailed Sales Data")
st.dataframe(df_filtered, use_container_width=True)

# Download button
st.download_button(
    label="Download filtered data as CSV",
    data=df_filtered.to_csv(index=False).encode('utf-8'),
    file_name='filtered_sales_data.csv',
    mime='text/csv'
)
```

### 5. Create a requirements.txt file
```
streamlit==1.28.0
pandas==1.5.3
plotly==5.15.0
sqlite3
```

### 6. Run the Streamlit app
```bash
streamlit run app.py
```

## Key SQL Queries Used

Here are some example SQL queries you can use to analyze the POS data:

```sql
-- Total sales by category
SELECT category, SUM(total_price) as total_sales
FROM sales
GROUP BY category
ORDER BY total_sales DESC;

-- Top selling products
SELECT product_name, SUM(quantity) as total_quantity
FROM sales
GROUP BY product_name
ORDER BY total_quantity DESC
LIMIT 5;

-- Daily sales trend
SELECT date, SUM(total_price) as daily_sales
FROM sales
GROUP BY date
ORDER BY date;

-- Average transaction value by category
SELECT category, AVG(total_price) as avg_transaction
FROM sales
GROUP BY category;
```

## Features of the App

- Interactive filters for date range and product categories
- Key Performance Indicators (KPIs) dashboard
- Visualizations showing sales by category and over time
- Detailed data table with download capability
- Responsive design that works on different screen sizes