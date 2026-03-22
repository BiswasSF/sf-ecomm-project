-- Sheet: 06_marts
-- Purpose: gold layer aggregations
-- Role needed: FR_DATA_ENGINEER
-- Date: 22-Mar-2026

USE ROLE FR_DATA_ENGINEER;
USE WAREHOUSE TRANSFORM_WH;
USE SCHEMA ECOMM_DB.MARTS;

CREATE TABLE IF NOT EXISTS daily_revenue AS
SELECT
  DATE(o.created_at)        AS order_date,
  COUNT(DISTINCT o.order_id) AS total_orders,
  COUNT(DISTINCT o.user_id)  AS unique_customers,
  SUM(oi.unit_price * oi.quantity) AS revenue
FROM ECOMM_DB.STAGING.orders o
JOIN ECOMM_DB.STAGING.order_items oi
  ON o.order_id = oi.order_id
WHERE o.status = 'completed'
GROUP BY 1
ORDER BY 1;

SELECT * FROM daily_revenue LIMIT 5;

CREATE TABLE IF NOT EXISTS top_products AS
SELECT
  p.product_id,
  p.name                            AS product_name,
  p.category,
  COUNT(DISTINCT oi.order_id)       AS total_orders,
  SUM(oi.quantity)                  AS total_units_sold,
  SUM(oi.unit_price * oi.quantity)  AS total_revenue
FROM ECOMM_DB.STAGING.order_items oi
JOIN ECOMM_DB.STAGING.products p
  ON oi.product_id = p.product_id
GROUP BY 1, 2, 3
ORDER BY total_revenue DESC;

SELECT * FROM top_products LIMIT 5;

CREATE TABLE IF NOT EXISTS user_activity AS
SELECT
  u.user_id,
  u.name,
  u.city,
  COUNT(DISTINCT o.order_id)            AS total_orders,
  SUM(oi.unit_price * oi.quantity)      AS total_spent,
  COUNT(DISTINCT e.session_id)          AS total_sessions,
  MIN(o.created_at)                     AS first_order_date,
  MAX(o.created_at)                     AS last_order_date
FROM ECOMM_DB.STAGING.users u
LEFT JOIN ECOMM_DB.STAGING.orders o
  ON u.user_id = o.user_id
LEFT JOIN ECOMM_DB.STAGING.order_items oi
  ON o.order_id = oi.order_id
LEFT JOIN ECOMM_DB.STAGING.events e
  ON u.user_id = e.user_id
GROUP BY 1, 2, 3
ORDER BY total_spent DESC;

SELECT * FROM user_activity LIMIT 5;


SELECT 'daily_revenue' , COUNT(*) FROM daily_revenue
UNION ALL
SELECT 'top_products'  , COUNT(*) FROM top_products
UNION ALL
SELECT 'user_activity' , COUNT(*) FROM user_activity;