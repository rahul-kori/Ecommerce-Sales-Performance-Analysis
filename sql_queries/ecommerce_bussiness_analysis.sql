USE Ecommerce_Analysis;

-- STEP.4 - EXPLORATORY DATA ANALYSIS (EDA) - DID IN PYTHON

-- STEP.5 - SQL BUSINESS ANALYSIS --

-- 1.TOTAL REVENUE OF THE COMPANY --
SELECT 
SUM(price) AS total_revenue
FROM order_items

-- 2.TOTAL NUMBER OF ORDERS --
SELECT
COUNT(DISTINCT(order_id))
FROM orders;

-- 3.AVERAGE ORDER VALUE --
SELECT 
SUM(price)/COUNT(DISTINCT(order_id)) AS avg_order_value 
FROM order_items

-- 4.MONTHLY REVENUE TREND --
SELECT 
FORMAT(O.order_purchase_timestamp,'yyyy-MM') AS order_months,
SUM(OI.price) AS monthly_revenue
from orders O
left join order_items OI
on O.order_id = OI.order_id
GROUP BY FORMAT(O.order_purchase_timestamp,'yyyy-MM')
ORDER BY order_months DESC;

-- 5.TOP  10 SELLING PRODUCTS --
SELECT TOP 10
product_id,
SUM(price) AS revenue
FROM order_items
GROUP BY product_id
ORDER BY revenue DESC;

-- 6.TOP PRODUCT CATEGORY --
SELECT TOP 10
P.product_category_name,
SUM(OI.price) AS revenue
FROM order_items OI
LEFT JOIN products P
ON P.product_id = OI.product_id
GROUP BY P.product_category_name
ORDER BY revenue DESC;

-- 7.TOP CUSTOMER CITY --
SELECT TOP 10
customer_city,
COUNT(O.order_id) AS total_customers
FROM customers C
LEFT JOIN orders O
ON C.customer_id = O.customer_id
GROUP BY customer_city
ORDER BY total_customers DESC;

-- 8.MOST POPULAR PAYMENT METHODS --
SELECT
payment_type,
COUNT(*) AS total_transaction
FROM payments p
GROUP BY payment_type
ORDER BY total_transaction DESC


-- 9.AVERAGE DELIVERY TIME --
SELECT
AVG(DATEDIFF(DAY, order_purchase_timestamp, order_delivered_customer_date)) AS avg_delivery_time
FROM orders
WHERE order_delivered_customer_date IS NOT NULL;

-- 10.LATE DELIVERY ANALYSIS --
SELECT 
COUNT(*) AS late_delivery
FROM orders
WHERE order_delivered_customer_date > order_estimated_delivery_date;

-- CUSTOMER REVIEW --
SELECT 
review_score,
COUNT(*) AS total_review
FROM reviews
GROUP BY review_score
ORDER BY total_review DESC;
