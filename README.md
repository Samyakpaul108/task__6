```markdown
# E-commerce Sales Analysis Project

## Overview
This project analyzes e-commerce sales data to derive insights about revenue trends, customer behavior, and product performance. The analysis includes comprehensive SQL queries for various business metrics across different dimensions like time, region, and product categories.

## Project Structure
```
project/
├── step1_create_schema_sales.sql    # Database schema definition
├── step2_sales_sql_data_insertion.sql # Sample data insertion
├── step3_sql_query_analysis.sql     # Analysis queries
└── README.md                        # Project documentation
```

## Database Schema

### Sales Table
The sales table contains transaction data with the following structure:

```sql
CREATE TABLE sales (
    order_id INTEGER,              -- Unique order identifier
    order_date VARCHAR(50),        -- Date of order
    status VARCHAR(50),            -- Order status (received, complete, canceled, etc.)
    item_id REAL,                 -- Product identifier
    sku VARCHAR(50),              -- Stock Keeping Unit
    qty_ordered REAL,             -- Quantity ordered
    price REAL,                   -- Unit price
    value REAL,                   -- Total value before discount
    discount_amount REAL,         -- Discount amount applied
    total REAL,                   -- Final total after discount
    category VARCHAR(50),         -- Product category
    payment_method VARCHAR(50),    -- Payment method used
    bi_st VARCHAR(50),            -- Business status
    cust_id REAL,                -- Customer identifier
    year INTEGER,                 -- Year of order
    month VARCHAR(50),            -- Month of order
    -- Customer Demographics
    "Name Prefix" VARCHAR(50),    
    "First Name" VARCHAR(50),
    "Middle Initial" VARCHAR(50),
    "Last Name" VARCHAR(50),
    Gender VARCHAR(50),
    age REAL,
    -- Contact Information
    "E Mail" VARCHAR(50),
    "Phone No. " VARCHAR(50),
    -- Location Information
    "Place Name" VARCHAR(50),
    County VARCHAR(50),
    City VARCHAR(50),
    State VARCHAR(50),
    Zip INTEGER,
    Region VARCHAR(50),
    -- Additional Fields
    "User Name" VARCHAR(50),
    Discount_Percent REAL
);
```

## Sample Data
Example of a sales record:
```sql
INSERT INTO sales VALUES (
    100354678,                    -- order_id
    '2020-10-01',                -- order_date
    'received',                  -- status
    574772.0,                    -- item_id
    'oasis_Oasis-064-36',        -- sku
    21.0,                        -- qty_ordered
    89.9,                        -- price
    1798.0,                      -- value
    0.0,                         -- discount_amount
    1798.0,                      -- total
    'Men''s Fashion',            -- category
    'cod',                       -- payment_method
    'Valid',                     -- bi_st
    60124.0                      -- cust_id
    -- ... other fields ...
);
```

## Analysis Components

### 1. Basic Monthly Sales Analysis
```sql
SELECT 
    year,
    month,
    COUNT(DISTINCT order_id) as order_volume,
    SUM(total) as monthly_revenue,
    ROUND(AVG(total), 2) as avg_order_value,
    COUNT(DISTINCT cust_id) as unique_customers
FROM sales
GROUP BY year, month
ORDER BY year, month;
```

### 2. Sales Performance Analysis
- Monthly revenue trends
- Top performing months
- Year-over-year growth
- Order volume analysis

### 3. Product Category Analysis
- Category-wise revenue
- Product performance metrics
- Category seasonality

### 4. Customer Analysis
- Purchase patterns
- Customer segmentation
- Revenue per customer
- Order frequency

### 5. Regional Performance
- Geographic distribution of sales
- Regional revenue analysis
- Customer concentration by region

### 6. Payment and Discount Analysis
- Payment method preferences
- Discount impact on sales
- Discount utilization patterns

## Key Features

### Advanced SQL Techniques Used
1. Common Table Expressions (CTEs)
2. Window Functions
3. Aggregate Functions
4. Case Statements
5. Joins
6. Date/Time Functions

### Performance Metrics
- Order Volume
- Revenue
- Average Order Value
- Customer Count
- Discount Impact
- Regional Distribution

## How to Use

### Prerequisites
- SQL Database (PostgreSQL/MySQL/SQLite)
- Database client or command-line tool

### Setup Instructions

1. Create the database schema:
```bash
psql -d your_database -f step1_create_schema_sales.sql
```

2. Load sample data:
```bash
psql -d your_database -f step2_sales_sql_data_insertion.sql
```

3. Run analysis queries:
```bash
psql -d your_database -f step3_sql_query_analysis.sql
```

## Query Examples

### Monthly Revenue Analysis
```sql
WITH monthly_stats AS (
    SELECT 
        year,
        month,
        COUNT(DISTINCT order_id) as order_volume,
        SUM(total) as monthly_revenue
    FROM sales
    GROUP BY year, month
)
SELECT * FROM monthly_stats ORDER BY year, month;
```

### Category Performance
```sql
SELECT 
    category,
    COUNT(DISTINCT order_id) as orders,
    SUM(total) as revenue,
    ROUND(AVG(total), 2) as avg_order_value
FROM sales
GROUP BY category;
```

## Author
- Created by: Samyak Paul
- Created on: 20-04-25

## Contributing
Contributions are welcome! Please feel free to submit a Pull Request.

## License
This project is licensed under the MIT License.

---
For questions or suggestions, please open an issue or contact the maintainers.
```

This README.md provides:
1. Clear project structure
2. Detailed schema documentation
3. Sample data examples
4. Analysis components
5. Setup instructions
6. Query examples
7. Usage guidelines


