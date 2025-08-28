-- number of orders per customer
SELECT user_id, COUNT(DISTINCT order_id) AS orders
FROM cart
GROUP BY user_id
ORDER BY orders DESC;

-- customers with multiple orders
SELECT user_id, COUNT(DISTINCT order_id) AS orders
FROM cart
GROUP BY user_id
ORDER BY orders DESC;

-- counting total orders per user + % thresholds
WITH user_orders AS (
  SELECT user_id, COUNT(DISTINCT order_id) AS orders
  FROM cart
  GROUP BY user_id
)
SELECT
  SUM(CASE WHEN orders >= 2 THEN 1 ELSE 0 END) * 1.0 / COUNT(*) AS pct_users_ge_2,
  SUM(CASE WHEN orders >= 5 THEN 1 ELSE 0 END) * 1.0 / COUNT(*) AS pct_users_ge_5,
  SUM(CASE WHEN orders >= 10 THEN 1 ELSE 0 END) * 1.0 / COUNT(*) AS pct_users_ge_10
FROM user_orders;

-- average basket size per order
SELECT COUNT(*) * 1.0 / COUNT(DISTINCT order_id) AS avg_items_per_order
FROM cart;

-- avg basket size by order #
SELECT order_number,
       AVG(basket_size) AS avg_basket_size
FROM (
    SELECT order_id, order_number, COUNT(*) AS basket_size
    FROM cart
    GROUP BY order_id, order_number
) t
GROUP BY order_number
ORDER BY order_number;

-- orders by day of week
SELECT order_dow, COUNT(DISTINCT order_id) AS orders
FROM cart
GROUP BY order_dow
ORDER BY order_dow ASC;

-- orders by hour of day
SELECT order_hour_of_day, COUNT(DISTINCT order_id) AS orders
FROM cart
GROUP BY order_hour_of_day
ORDER BY orders DESC;

-- days since prior order
SELECT days_since_prior_order,
       COUNT(DISTINCT order_id) AS num_orders
FROM cart
WHERE days_since_prior_order IS NOT NULL
GROUP BY days_since_prior_order
ORDER BY days_since_prior_order;

-- days until second order
SELECT days_since_prior_order AS days_to_second_order, COUNT(*) AS users
FROM cart
WHERE order_number = 2 AND days_since_prior_order IS NOT NULL
GROUP BY days_since_prior_order
ORDER BY days_since_prior_order;

-- top 20 products
SELECT product_id, product_name, COUNT(*) AS orders
FROM cart
GROUP BY product_id, product_name
ORDER BY orders DESC
LIMIT 20;

-- reorder ratio by product name 
SELECT product_name,
       ROUND(AVG(reordered::NUMERIC), 3) AS reorder_rate,
       COUNT(*) AS total_orders
FROM cart
GROUP BY product_name
HAVING COUNT(*) > 1000   
ORDER BY reorder_rate DESC
LIMIT 15;

-- product reorder rate 
SELECT 
    product_id,
    SUM(reordered) AS total_reorders,
    COUNT(*) AS total_orders,
    SUM(reordered) * 1.0 / COUNT(*) AS reorder_rate
FROM cart
GROUP BY product_id
HAVING COUNT(*) >= 1000
ORDER BY reorder_rate DESC;

-- reorder rate by order #
SELECT order_number,
       AVG(reordered) AS reorder_rate
FROM cart
GROUP BY order_number
ORDER BY order_number;

-- first-order products
SELECT product_id, product_name, COUNT(*) AS first_orders
FROM cart
WHERE days_since_prior_order IS NULL
GROUP BY product_id, product_name
ORDER BY first_orders DESC;

-- top 20 products by order count
SELECT 
    product_id, 
    product_name, 
    COUNT(*) AS total_orders
FROM cart
GROUP BY product_id, product_name
ORDER BY total_orders DESC
LIMIT 20;

-- top aisles and departments
SELECT aisle, department, COUNT(*) AS items
FROM cart
GROUP BY aisle, department
ORDER BY items DESC;

-- reorder rate by department 
SELECT 
    department,
    COUNT(*) AS total_orders,
    SUM(reordered) AS total_reorders,
    SUM(reordered) * 1.0 / COUNT(*) AS reorder_rate
FROM cart
GROUP BY department
HAVING COUNT(*) >= 10000
ORDER BY reorder_rate DESC;

-- top first order departments
SELECT department, COUNT(*) AS first_orders
FROM cart
WHERE days_since_prior_order IS NULL
GROUP BY department
ORDER BY first_orders DESC;

-- top aisles

SELECT aisle, COUNT(*) AS total_orders
FROM cart
GROUP BY aisle
ORDER BY total_orders DESC;

