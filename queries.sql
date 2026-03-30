-- ==================================================================================================
-- Superstore Sales Analysis
-- Dataset: Superstore Sales (Kaggle)
-- Author: Sofia Hernandez Bellone
-- Description: Exploratory sales analysis using SQL, covering revenue, sales trends, logistics and
--              customer segmentation.
-- ==================================================================================================


-- ==================================================================================================
-- 1. OVERVIEW
-- ==================================================================================================

-- 1.1 Total Sales
-- Provides a high-level snapshot of total revenue across all orders.
SELECT 
    ROUND(SUM(Sales), 2) AS total_sales
FROM train;

-- 1.2 Sales by Category
-- The Technology category generates the highest revenue, indicating strong demand for tech products.
SELECT 
    Category,
    ROUND(SUM(Sales), 2) AS total_sales
FROM train
GROUP BY Category
ORDER BY total_sales DESC;

-- 1.3 Sales by Sub-Category
-- Breaks down revenue within each category to identify top-performing product lines.
SELECT 
    Category,
    `Sub-Category`,
    ROUND(SUM(Sales), 2) AS total_sales
FROM train
GROUP BY Category, `Sub-Category`
ORDER BY total_sales DESC;

-- 1.4 Top 10 Products by Sales
-- A small number of products drive a large portion of total sales, indicating a potential product
-- concentration strategy.
SELECT 
    `Product Name`,
    Category,
    ROUND(SUM(Sales), 2) AS total_sales
FROM train
GROUP BY `Product Name`, Category
ORDER BY total_sales DESC
LIMIT 10;

-- 1.5 Sales by Region
-- Identifies which geographic regions contribute most to total revenue.
SELECT 
    Region,
    ROUND(SUM(Sales), 2) AS total_sales
FROM train
GROUP BY Region
ORDER BY total_sales DESC;

-- 1.6 Monthly Sales Trend
-- Sales show monthly variation, with potential seasonal peaks that could be leveraged for 
-- marketing strategies.
SELECT 
    DATE_FORMAT(STR_TO_DATE(`Order Date`, '%m/%d/%Y'), '%Y-%m') AS month,
    ROUND(SUM(Sales), 2) AS total_sales
FROM train
GROUP BY month
ORDER BY month;

-- 1.7 Top 10 Customers by Sales
-- Quick overview of the highest-revenue customers.
SELECT 
    `Customer Name`,
    Segment,
    ROUND(SUM(Sales), 2) AS total_sales
FROM train
GROUP BY `Customer Name`, Segment
ORDER BY total_sales DESC
LIMIT 10;

-- ==================================================================================================
-- 2. CUSTOMER ANALYSIS
-- ==================================================================================================

-- 2.1 Total Customers
-- Provides a high-level snapshot of the customer base.
SELECT 
    COUNT(DISTINCT `Customer ID`)   AS total_customers,
    COUNT(DISTINCT `Order ID`)      AS total_orders,
    ROUND(SUM(Sales), 2)            AS total_sales,
    ROUND(SUM(Sales) / COUNT(DISTINCT `Order ID`), 2) AS avg_order_value
FROM train;

-- 2.2 Sales by Customer Segment
-- The Consumer segment leads in total sales, while Corporate and Home Office represent smaller
-- but relevant shares.
SELECT 
    Segment,
    COUNT(DISTINCT `Customer ID`)   AS total_customers,
    COUNT(DISTINCT `Order ID`)      AS total_orders,
    ROUND(SUM(Sales), 2)            AS total_sales,
    ROUND(SUM(Sales) / COUNT(DISTINCT `Order ID`), 2) AS avg_order_value
FROM train
GROUP BY Segment
ORDER BY total_sales DESC;

-- 2.3 Top 10 Customers by Sales
-- A small group of customers contributes significantly to total revenue, suggesting 
-- opportunities for loyalty and retention strategies.
SELECT 
    `Customer Name`,
    Segment,
    COUNT(DISTINCT `Order ID`)      AS total_orders,
    ROUND(SUM(Sales), 2)            AS total_sales,
    ROUND(SUM(Sales) / COUNT(DISTINCT `Order ID`), 2) AS avg_order_value
FROM train
GROUP BY `Customer Name`, Segment
ORDER BY total_sales DESC
LIMIT 10;

-- 2.4 Customer Purchase Frequency
-- Most customers (66 out of 69) placed only one order, indicating low customer retention 
-- and limited repeat purchasing behavior.
SELECT 
    orders_placed,
    COUNT(*) AS total_customers
FROM (
    SELECT 
        `Customer ID`,
        COUNT(DISTINCT `Order ID`) AS orders_placed
    FROM train
    GROUP BY `Customer ID`
) AS customer_orders
GROUP BY orders_placed
ORDER BY orders_placed ASC;

-- 2.5 Top 10 States by Number of Customers
-- Identifies where the customer base is most concentrated geographically.
SELECT 
    State,
    COUNT(DISTINCT `Customer ID`)   AS total_customers,
    ROUND(SUM(Sales), 2)            AS total_sales
FROM train
GROUP BY State
ORDER BY total_customers DESC
LIMIT 10;

-- ==================================================================================================
-- 3. GEOGRAPHIC ANALYSIS
-- ==================================================================================================

-- 3.1 Sales by Region
-- The West region leads in total sales, followed by the East. The South region shows the lowest 
-- revenue contribution.
SELECT 
    Region,
    COUNT(DISTINCT `Customer ID`)   AS total_customers,
    COUNT(DISTINCT `Order ID`)      AS total_orders,
    ROUND(SUM(Sales), 2)            AS total_sales,
    ROUND(SUM(Sales) / COUNT(DISTINCT `Order ID`), 2) AS avg_order_value
FROM train
GROUP BY Region
ORDER BY total_sales DESC;

-- 3.2 Top 10 States by Sales
-- A small number of states concentrate the majority of revenue.
SELECT 
    State,
    Region,
    COUNT(DISTINCT `Customer ID`)   AS total_customers,
    COUNT(DISTINCT `Order ID`)      AS total_orders,
    ROUND(SUM(Sales), 2)            AS total_sales
FROM train
GROUP BY State, Region
ORDER BY total_sales DESC
LIMIT 10;

-- 3.3 Bottom 10 States by Sales
-- Identifies the least active states, which could represent untapped markets or low-demand areas.
SELECT 
    State,
    Region,
    COUNT(DISTINCT `Customer ID`)   AS total_customers,
    COUNT(DISTINCT `Order ID`)      AS total_orders,
    ROUND(SUM(Sales), 2)            AS total_sales
FROM train
GROUP BY State, Region
ORDER BY total_sales ASC
LIMIT 10;

-- 3.4 Top 10 Cities by Sales
-- Drills down from state level to identify the most valuable individual markets.
SELECT 
    City,
    State,
    COUNT(DISTINCT `Customer ID`)   AS total_customers,
    COUNT(DISTINCT `Order ID`)      AS total_orders,
    ROUND(SUM(Sales), 2)            AS total_sales
FROM train
GROUP BY City, State
ORDER BY total_sales DESC
LIMIT 10;

-- 3.5 Sales by Region and Category
-- Reveals which product categories drive revenue in each region, useful for regional inventory 
-- and marketing decisions.
SELECT 
    Region,
    Category,
    ROUND(SUM(Sales), 2)            AS total_sales,
    COUNT(DISTINCT `Order ID`)      AS total_orders
FROM train
GROUP BY Region, Category
ORDER BY Region, total_sales DESC;

-- ==================================================================================================
-- 4. LOGISTICS
-- ==================================================================================================

-- 4.1 Orders by Ship Mode
-- Standard Class handles the vast majority of orders.
-- Same Day shipping represents a small share, likely used for urgent or high-value orders.
SELECT 
    `Ship Mode`,
    COUNT(DISTINCT `Order ID`)      AS total_orders,
    ROUND(SUM(Sales), 2)            AS total_sales,
    ROUND(SUM(Sales) / COUNT(DISTINCT `Order ID`), 2) AS avg_order_value
FROM train
GROUP BY `Ship Mode`
ORDER BY total_orders DESC;

-- 4.2 Average Shipping Time by Ship Mode
-- Calculates the average number of days between order and shipment for each shipping mode.
-- Helps identify whether each mode is meeting expected delivery standards.
SELECT 
    `Ship Mode`,
    COUNT(DISTINCT `Order ID`)  AS total_orders,
    ROUND(AVG(DATEDIFF(
        STR_TO_DATE(`Ship Date`, '%m/%d/%Y'),
        STR_TO_DATE(`Order Date`, '%m/%d/%Y')
    )), 1)                      AS avg_shipping_days,
    MIN(DATEDIFF(
        STR_TO_DATE(`Ship Date`, '%m/%d/%Y'),
        STR_TO_DATE(`Order Date`, '%m/%d/%Y')
    ))                          AS min_shipping_days,
    MAX(DATEDIFF(
        STR_TO_DATE(`Ship Date`, '%m/%d/%Y'),
        STR_TO_DATE(`Order Date`, '%m/%d/%Y')
    ))                          AS max_shipping_days
FROM train
GROUP BY `Ship Mode`
ORDER BY avg_shipping_days ASC;

-- 4.3 Average Shipping Time by Region
-- Detects regional logistics differences that could affect customer satisfaction.
SELECT 
    Region,
    ROUND(AVG(DATEDIFF(
        STR_TO_DATE(`Ship Date`, '%m/%d/%Y'),
        STR_TO_DATE(`Order Date`, '%m/%d/%Y')
    )), 1)                      AS avg_shipping_days
FROM train
GROUP BY Region
ORDER BY avg_shipping_days ASC;

-- 4.4 Average Shipping Time by Region and Ship Mode
-- Combines both dimensions to identify specific region/mode combinations with unusually long or 
-- short shipping times.
-- Note: rows with inconsistent date formats were excluded from this calculation.
SELECT 
    Region,
    `Ship Mode`,
    COUNT(DISTINCT `Order ID`)  AS total_orders,
    ROUND(AVG(DATEDIFF(
        STR_TO_DATE(`Ship Date`, '%m/%d/%Y'),
        STR_TO_DATE(`Order Date`, '%m/%d/%Y')
    )), 1) AS avg_shipping_days
FROM train
WHERE DATEDIFF(
    STR_TO_DATE(`Ship Date`, '%m/%d/%Y'),
    STR_TO_DATE(`Order Date`, '%m/%d/%Y')
) >= 0
GROUP BY Region, `Ship Mode`
ORDER BY Region, avg_shipping_days ASC;

-- 4.5 Ship Mode Preference by Customer Segment
-- Analyzes whether different customer segments tend to use different shipping modes,
-- which could inform segment-specific logistics strategies.
SELECT 
    Segment,
    `Ship Mode`,
    COUNT(DISTINCT `Order ID`)      AS total_orders,
    ROUND(SUM(Sales), 2)            AS total_sales
FROM train
GROUP BY Segment, `Ship Mode`
ORDER BY Segment, total_orders DESC;

-- ==================================================================================================
-- 5. SALES TRENDS
-- ==================================================================================================

-- 5.1 Sales by Year
-- Provides a high-level view of revenue evolution over time.
SELECT 
    YEAR(STR_TO_DATE(`Order Date`, '%m/%d/%Y'))     AS year,
    COUNT(DISTINCT `Order ID`)                      AS total_orders,
    COUNT(DISTINCT `Customer ID`)                   AS total_customers,
    ROUND(SUM(Sales), 2)                            AS total_sales
FROM train
GROUP BY year
ORDER BY year;

-- 5.2 Monthly Sales Trend
-- Sales show monthly variation, with potential seasonal peaks that could be leveraged for 
-- marketing strategies.
SELECT 
    DATE_FORMAT(STR_TO_DATE(`Order Date`, '%m/%d/%Y'), '%Y-%m')     AS month,
    COUNT(DISTINCT `Order ID`)                                      AS total_orders,
    ROUND(SUM(Sales), 2)                                            AS total_sales
FROM train
GROUP BY month
ORDER BY month;

-- 5.3 Sales by Year and Category
-- Tracks how each category has evolved over time, revealing growth trends within the 
-- product mix.
SELECT 
    YEAR(STR_TO_DATE(`Order Date`, '%m/%d/%Y'))     AS year,
    Category,
    ROUND(SUM(Sales), 2)                            AS total_sales
FROM train
GROUP BY year, Category
ORDER BY year, total_sales DESC;

-- 5.4 Sales by Month of Year
-- Identifies which months consistently generate the most revenue across all years,
-- helping detect recurring seasonal patterns.
SELECT 
    MONTH(STR_TO_DATE(`Order Date`, '%m/%d/%Y'))    AS month_number,
    DATE_FORMAT(STR_TO_DATE(`Order Date`, '%m/%d/%Y'), '%M') AS month_name,
    ROUND(SUM(Sales), 2)                            AS total_sales,
    COUNT(DISTINCT `Order ID`)                      AS total_orders
FROM train
GROUP BY month_number, month_name
ORDER BY month_number;

-- 5.5 Sales by Quarter
-- Aggregates revenue by quarter to detect broader seasonal trends.
SELECT 
    YEAR(STR_TO_DATE(`Order Date`, '%m/%d/%Y'))     AS year,
    QUARTER(STR_TO_DATE(`Order Date`, '%m/%d/%Y'))  AS quarter,
    ROUND(SUM(Sales), 2)                            AS total_sales,
    COUNT(DISTINCT `Order ID`)                      AS total_orders
FROM train
GROUP BY year, quarter
ORDER BY year, quarter;
