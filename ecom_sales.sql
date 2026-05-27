CREATE database ecommerce_project;
use ecommerce_project;
CREATE TABLE superstore (
    ship_mode VARCHAR(50),
    segment VARCHAR(50),
    country VARCHAR(50),
    city VARCHAR(100),
    state VARCHAR(100),
    postal_code VARCHAR(20),
    region VARCHAR(50),
    category VARCHAR(50),
    sub_category VARCHAR(50),
    sales DECIMAL(10,2),
    quantity INT,
    discount DECIMAL(5,2),
    profit DECIMAL(10,2),
    profit_margin DECIMAL(10,2),
    sales_category VARCHAR(20),
    profitable VARCHAR(10),
    revenue_after_discount DECIMAL(10,2)
);

-- Total Sales, Profit & Quantity
SELECT 
    COUNT(*) AS total_orders,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit,
    SUM(quantity) AS total_quantity,
    ROUND(AVG(sales), 2) AS avg_order_value
FROM superstore;


-- Sales & Profit by Category
SELECT 
    category,
    COUNT(*) AS total_orders,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit,
    ROUND((SUM(profit)/SUM(sales))*100, 2) AS profit_margin_pct
FROM superstore
GROUP BY category
ORDER BY total_sales DESC;


 -- Discount Impact on Profit
SELECT 
    CASE
        WHEN discount = 0 THEN 'No Discount'
        WHEN discount <= 0.2 THEN 'Low (0-20%)'
        WHEN discount <= 0.4 THEN 'Medium (21-40%)'
        ELSE 'High (40%+)'
    END AS discount_category,
    COUNT(*) AS total_orders,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit,
    ROUND(AVG(profit), 2) AS avg_profit
FROM superstore
GROUP BY discount_category
ORDER BY total_profit DESC;

-- Ship Mode Performance
SELECT 
    ship_mode,
    COUNT(*) AS total_orders,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(AVG(sales), 2) AS avg_sale,
    ROUND(SUM(profit), 2) AS total_profit
FROM superstore
GROUP BY ship_mode
ORDER BY total_orders DESC;
