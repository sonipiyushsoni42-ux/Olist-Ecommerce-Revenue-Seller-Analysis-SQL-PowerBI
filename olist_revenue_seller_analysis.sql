use olist_db; 
 create table order_item (
 order_id varchar(250),
 order_item_id int ,
 product_id varchar (255),
 seller_id varchar(255),
 shipping_limit_date varchar(250),
 price decimal(10,2),
 freight_value decimal(10,2)
 );
 
 USE olist_db;

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/olist_order_items_dataset.csv'
INTO TABLE order_item
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;
ite
select*from order_item ;

-- QUERY 1: Executive KPIs (Total Revenue, Shipping Cost & Average Price)
SELECT 
    COUNT(DISTINCT order_id) AS total_unique_orders,
    COUNT(order_item_id) AS total_items_sold,
    ROUND(SUM(price), 2) AS total_revenue_brl,
    ROUND(SUM(freight_value), 2) AS total_freight_cost,
    ROUND(AVG(price), 2) AS avg_item_price,
    ROUND((SUM(freight_value) / SUM(price)) * 100, 2) AS overall_freight_to_price_ratio_pct
FROM order_item;


-- QUERY 2: Top 10 Sellers by Revenue using Window Function (DENSE_RANK)
SELECT 
    seller_id,
    COUNT(order_id) AS total_items_sold,
    ROUND(SUM(price), 2) AS total_revenue,
    ROUND(SUM(freight_value), 2) AS total_shipping_cost,
    DENSE_RANK() OVER (ORDER BY SUM(price) DESC) AS seller_rank
FROM order_item
GROUP BY seller_id
LIMIT 10;


-- QUERY 3: Order Basket Size Analysis using CTE (Single vs Bulk Buyers)
WITH BasketAnalysis AS (
    SELECT 
        order_id,
        MAX(order_item_id) AS items_in_cart,
        SUM(price) AS order_value
    FROM order_item
    GROUP BY order_id
)
SELECT 
    CASE 
        WHEN items_in_cart = 1 THEN '1. Single Item Order'
        WHEN items_in_cart = 2 THEN '2. Double Item Order'
        WHEN items_in_cart BETWEEN 3 AND 5 THEN '3. Medium Bulk (3-5 Items)'
        ELSE '4. Heavy Bulk (6+ Items)'
    END AS basket_category,
    COUNT(order_id) AS total_orders,
    ROUND(SUM(order_value), 2) AS total_category_revenue,
    ROUND(AVG(order_value), 2) AS avg_order_value
FROM BasketAnalysis
GROUP BY basket_category
ORDER BY basket_category;



-- QUERY 4: B-Tree Indexing for Performance Optimization
-- (Seller aur Order queries ko fast karne ke liye)
CREATE INDEX idx_seller_price ON order_item(seller_id, price);
CREATE INDEX idx_order_id ON order_item(order_id);
