-- ============================================================
-- Superstore Sales Analysis
-- Dataset: Superstore Sales (Kaggle)
-- Author: Sofia Hernandez Bellone
-- Description: Exploratory sales analysis using SQL, covering
--              revenue, profitability, discounts, logistics,
--              and customer segmentation.
-- ============================================================


-- ============================================================
-- 1. OVERVIEW
-- ============================================================

-- 1.1 Total Sales
-- Provides a high-level snapshot of total revenue across all orders.
SELECT 
    ROUND(SUM(Sales), 2) AS total_sales
FROM train;

-- Sales by Category
-- The Technology category generates the highest revenue, indicating strong demand for tech products.
SELECT 
    Category,
    ROUND(SUM(Sales), 2) AS total_sales
FROM train
GROUP BY Category
ORDER BY total_sales DESC;

-- Top 10 Products
-- A small number of products drive a large portion of total sales,
-- indicating a potential product concentration strategy.
SELECT `Product Name`, SUM(Sales) AS total_sales
FROM train
GROUP BY `Product Name`
ORDER BY total_sales DESC
LIMIT 10;

-- Sales by Country
-- Sales are concentrated in a single country, so further analysis by region or state is recommended.
SELECT `country`, SUM(Sales) AS total_sales
FROM train
GROUP BY `country`
ORDER BY total_sales DESC;

-- Monthly Sales Trend
-- Sales show monthly variation, with potential seasonal peaks that could be leveraged for marketing strategies.
SELECT 
    DATE_FORMAT(`Order Date`, '%Y-%m') AS month,
    SUM(Sales) AS total_sales
FROM train
GROUP BY month
ORDER BY month;

-- Top Customers
-- A small group of customers contributes significantly to total revenue,
-- suggesting opportunities for customer retention strategies.
SELECT `Customer Name`, SUM(Sales) AS total_sales
FROM train
GROUP BY `Customer Name`
ORDER BY total_sales DESC
LIMIT 10;
