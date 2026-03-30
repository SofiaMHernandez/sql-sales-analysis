# Superstore Sales Analysis

## Project Overview
Exploratory sales analysis of a US-based retail company using SQL (MySQL). 
The goal is to identify revenue patterns, customer behavior, logistics performance, 
and seasonal trends to support data-driven business decisions.

---

## Dataset
- **Source:** [Superstore Sales Dataset - Kaggle](https://www.kaggle.com/datasets/vivek468/superstore-dataset-final)
- **Note:** This analysis is based on the `train.csv` subset provided by Kaggle, 
  which contains 397 orders and 69 unique customers (period: 2015–2018)
- **Fields:** Order ID, Order Date, Ship Date, Ship Mode, Customer ID, Customer Name, 
  Segment, Country, City, State, Postal Code, Region, Product ID, Category, 
  Sub-Category, Product Name, Sales

---

## Tools
- **MySQL** — data analysis and querying

---

## File Structure
```
superstore_sales_analysis.sql
│
├── 1. OVERVIEW
├── 2. CUSTOMER ANALYSIS
├── 3. GEOGRAPHIC ANALYSIS
├── 4. LOGISTICS
└── 5. SALES TRENDS
```

---

## Key Findings

### 1. Overview
- Total revenue across all orders: **$28,609.94**
- **Furniture** leads in sales ($13,811.01), followed by Office Supplies ($8,322.77) 
  and Technology ($6,476.15)
- Top product: *Riverside Palais Royal Lawyers Bookcase* with $3,083.43 in sales
- **West** is the highest-revenue region ($10,189.28), while South contributes the least ($4,153.70)

### 2. Customer Analysis
- The analyzed subset contains **69 unique customers** across 397 orders, with an average order 
  value of **$397.36**
- **Consumer** segment leads with $19,343.59 in sales across 36 customers
- **66 out of 69 customers placed only one order**, indicating very low retention and 
  limited repeat purchasing behavior
- Top customer: *Brosina Hoffman* (Consumer) with $3,714.30 in total sales across 3 orders

### 3. Geographic Analysis
- **West region** leads in both customers (21) and revenue ($10,189.28)
- **California** is the top state by sales ($6,019.33), followed by Pennsylvania ($3,476.75) 
  and Texas ($3,424.96)
- **Los Angeles** is the top city ($4,595.46), followed by Philadelphia ($3,476.75) 
  and Houston ($2,065.14)
- Furniture is the top category across all four regions

### 4. Logistics
- **Standard Class** handles the majority of orders (43 out of 55)
- **Consumer** segment is the heaviest user of Standard Class across all segments
- Shipping time analysis was omitted due to inconsistent date formats in the dataset

### 5. Sales Trends
- **2017** was the strongest year with $5,832.29 in revenue across 17 orders
- **September** and **November** are consistently the highest-revenue months, 
  suggesting a seasonal peak in Q4
- **Q4** (quarters 3 and 4 combined) concentrates the majority of annual sales across all years
- Technology showed the strongest growth between 2016 and 2017 ($1,986.54 → $2,625.96)
  
## Business Recommendations
- Improve customer retention strategies, as 66 out of 69 customers placed only one order
- Focus marketing and inventory efforts on the West region, while investigating 
  low performance in the South
- Leverage Q4 seasonality (September and November peaks) with targeted marketing campaigns
- Monitor product-level performance, particularly in Furniture which leads in sales 
  but warrants margin analysis
---
