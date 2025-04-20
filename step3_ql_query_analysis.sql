-- sales_analysis.sql
-- Purpose: Analyze monthly revenue and order volume from online sales data
-- Created: 20-04-25
-- Author: Samyak Paul

-- =============================================
-- Basic Monthly Sales Analysis
-- =============================================

-- This query provides the fundamental monthly sales metrics
SELECT 
    year,
    month,
    COUNT(DISTINCT order_id) as order_volume,  -- Count unique orders only
    SUM(total) as monthly_revenue,             -- Total revenue for the month
    ROUND(AVG(total), 2) as avg_order_value,   -- Average order value
    COUNT(DISTINCT cust_id) as unique_customers -- Number of unique customers
FROM sales
GROUP BY year, month
ORDER BY year, month;

-- =============================================
-- Top 3 Months by Revenue
-- =============================================

-- This query identifies the three months with highest revenue
SELECT 
    year,
    month,
    SUM(total) as monthly_revenue
FROM sales
GROUP BY year, month
ORDER BY monthly_revenue DESC
LIMIT 3;

-- =============================================
-- Comprehensive Monthly Analysis with Rankings
-- =============================================

-- This query combines multiple metrics and includes revenue rankings
WITH monthly_stats AS (
    -- First CTE: Calculate basic monthly statistics
    SELECT 
        year,
        month,
        COUNT(DISTINCT order_id) as order_volume,
        SUM(total) as monthly_revenue,
        ROUND(AVG(total), 2) as avg_order_value,
        COUNT(DISTINCT cust_id) as unique_customers,
        SUM(discount_amount) as total_discounts,
        ROUND(AVG(qty_ordered), 2) as avg_items_per_order
    FROM sales
    GROUP BY year, month
),
ranked_months AS (
    -- Second CTE: Add revenue rankings
    SELECT 
        *,
        RANK() OVER (ORDER BY monthly_revenue DESC) as revenue_rank
    FROM monthly_stats
)
-- Final selection with all metrics
SELECT 
    year,
    month,
    order_volume,
    monthly_revenue,
    avg_order_value,
    unique_customers,
    total_discounts,
    avg_items_per_order,
    revenue_rank as revenue_rank_overall
FROM ranked_months
ORDER BY year, month;

-- =============================================
-- Category-wise Monthly Analysis
-- =============================================

-- This query breaks down sales by product category
SELECT 
    year,
    month,
    category,
    COUNT(DISTINCT order_id) as order_count,
    SUM(total) as category_revenue,
    ROUND(AVG(total), 2) as avg_category_order_value
FROM sales
GROUP BY year, month, category
ORDER BY year, month, category;

-- =============================================
-- Customer Segment Analysis
-- =============================================

-- This query analyzes customer purchasing patterns
SELECT 
    year,
    month,
    COUNT(DISTINCT cust_id) as unique_customers,
    SUM(total) / COUNT(DISTINCT cust_id) as revenue_per_customer,
    SUM(discount_amount) / COUNT(DISTINCT cust_id) as avg_discount_per_customer,
    COUNT(DISTINCT order_id) / COUNT(DISTINCT cust_id) as orders_per_customer
FROM sales
GROUP BY year, month
ORDER BY year, month;

-- =============================================
-- Discount Impact Analysis
-- =============================================

-- This query analyzes the impact of discounts on sales
SELECT 
    year,
    month,
    SUM(total) as total_revenue,
    SUM(discount_amount) as total_discounts,
    ROUND(SUM(discount_amount) * 100.0 / SUM(total), 2) as discount_percentage,
    COUNT(CASE WHEN discount_amount > 0 THEN 1 END) as orders_with_discount,
    COUNT(DISTINCT order_id) as total_orders,
    ROUND(COUNT(CASE WHEN discount_amount > 0 THEN 1 END) * 100.0 / 
          COUNT(DISTINCT order_id), 2) as percent_orders_with_discount
FROM sales
GROUP BY year, month
ORDER BY year, month;

-- =============================================
-- Payment Method Analysis
-- =============================================

-- This query analyzes sales by payment method
SELECT 
    year,
    month,
    payment_method,
    COUNT(DISTINCT order_id) as number_of_orders,
    SUM(total) as total_revenue,
    ROUND(AVG(total), 2) as avg_order_value
FROM sales
GROUP BY year, month, payment_method
ORDER BY year, month, total_revenue DESC;

-- =============================================
-- Regional Sales Analysis
-- =============================================

-- This query breaks down sales by region
SELECT 
    year,
    month,
    region,
    COUNT(DISTINCT order_id) as number_of_orders,
    SUM(total) as total_revenue,
    COUNT(DISTINCT cust_id) as unique_customers,
    ROUND(SUM(total) / COUNT(DISTINCT cust_id), 2) as revenue_per_customer
FROM sales
GROUP BY year, month, region
ORDER BY year, month, total_revenue DESC;

-- =============================================
-- Year-over-Year Growth Analysis
-- =============================================

-- This query calculates year-over-year growth
WITH yearly_totals AS (
    SELECT 
        year,
        month,
        SUM(total) as monthly_revenue
    FROM sales
    GROUP BY year, month
)
SELECT 
    t1.year,
    t1.month,
    t1.monthly_revenue as current_revenue,
    t2.monthly_revenue as previous_year_revenue,
    ROUND((t1.monthly_revenue - t2.monthly_revenue) * 100.0 / 
          NULLIF(t2.monthly_revenue, 0), 2) as yoy_growth_percentage
FROM yearly_totals t1
LEFT JOIN yearly_totals t2 
    ON t1.month = t2.month 
    AND t1.year = t2.year + 1
ORDER BY t1.year, t1.month;