# 📊 Brazilian E-Commerce Revenue, Pricing & Seller Performance Analysis

## 📌 Project Overview
This project analyzes **116,387 order items** across **98,666 unique orders** from the Brazilian E-Commerce (Olist) dataset using **MySQL 8.0** and **Power BI**. The objective is to uncover revenue distribution, shipping cost (freight) burdens, order basket sizes (Single vs. Bulk buyers), and top-performing sellers using advanced SQL techniques.

---

## 🛠️ Tech Stack & Skills Demonstrated
- **Database:** MySQL 8.0 Workbench
- **SQL Techniques:** Common Table Expressions (`WITH` CTEs), Window Functions (`DENSE_RANK`), Conditional Aggregation (`CASE WHEN`), and Composite `B-Tree Indexing` for Query Optimization.
- **BI Tool:** Microsoft Power BI Desktop

---

## 📈 Executive KPIs & Key Findings

### 1. Overall Business Metrics
- **Total Unique Orders:** `98,666`
- **Total Items Sold:** `116,387`
- **Total Revenue:** `14,060,194.27 BRL` (~14.06M BRL)
- **Total Freight (Shipping) Cost:** `2,327,630.32 BRL` (~2.33M BRL)
- **Average Item Price:** `120.81 BRL`
- **Overall Freight-to-Price Ratio:** `16.55%`

### 2. Order Basket Size Analysis (Using SQL CTEs)
By categorizing customer carts into single and multi-item purchases, we uncovered that **~90% of orders are single-item purchases**, while heavy bulk orders yield over **4x higher Average Order Value (AOV)**:

| Basket Category | Total Orders | Total Revenue (BRL) | Avg Order Value (BRL) |
| :--- | :---: | :---: | :---: |
| **1. Single Item Order** | 88,863 | 11,970,648.06 | 134.71 |
| **2. Double Item Order** | 7,516 | 1,363,716.19 | 181.44 |
| **3. Medium Bulk (3-5 Items)** | 2,031 | 573,270.08 | 282.26 |
| **4. Heavy Bulk (6+ Items)** | 256 | 152,559.94 | 595.94 |

### 3. Query Optimization
- Created Composite B-Tree Indexes (`idx_seller_price` and `idx_order_id`) on the `order_item` table to optimize aggregation and lookup speeds across 116k+ rows.

---

## 📂 Files in this Repository
- `olist_revenue_seller_analysis.sql` - Complete SQL script containing `LOAD DATA INFILE` ingestion, KPI queries, CTEs, Window Functions, and Indexing.
- `Revenue_Seller_Dashboard.pbix` - Interactive Power BI Dashboard file.
- `Dashboard_Report.pdf` - Exported PDF view of the dashboard.
