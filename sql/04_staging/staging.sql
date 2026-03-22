-- Sheet: 05_staging_users
-- Purpose: clean and type cast users from RAW to STAGING
-- Role needed: FR_DATA_ENGINEER
-- Date: 22-Mar-2026

USE ROLE FR_DATA_ENGINEER;
USE WAREHOUSE TRANSFORM_WH;
USE SCHEMA ECOMM_DB.STAGING;

CREATE TABLE IF NOT EXISTS users AS
SELECT
  user_id,
  INITCAP(TRIM(name))                    AS name,
  LOWER(TRIM(email))                     AS email,
  REGEXP_REPLACE(phone, '[^0-9+]', '')   AS phone,
  INITCAP(TRIM(city))                    AS city,
  created_at::TIMESTAMP_NTZ              AS created_at,
  _loaded_at
FROM ECOMM_DB.RAW.users
WHERE user_id IS NOT NULL
  AND email IS NOT NULL
QUALIFY ROW_NUMBER() OVER (PARTITION BY user_id ORDER BY _loaded_at DESC) = 1;

SELECT COUNT(*) FROM ECOMM_DB.STAGING.users;

CREATE TABLE IF NOT EXISTS orders AS
SELECT
  order_id,
  user_id,
  LOWER(TRIM(status))       AS status,
  total_amount,
  created_at::TIMESTAMP_NTZ AS created_at,
  _loaded_at
FROM ECOMM_DB.RAW.orders
WHERE order_id IS NOT NULL
  AND user_id  IS NOT NULL
QUALIFY ROW_NUMBER() OVER (PARTITION BY order_id ORDER BY _loaded_at DESC) = 1;

SELECT COUNT(*) FROM ECOMM_DB.STAGING.orders;



-- staging products
CREATE TABLE IF NOT EXISTS products AS
SELECT
  product_id,
  INITCAP(TRIM(name))     AS name,
  INITCAP(TRIM(category)) AS category,
  price,
  created_at::TIMESTAMP_NTZ AS created_at,
  _loaded_at
FROM ECOMM_DB.RAW.products
WHERE product_id IS NOT NULL
QUALIFY ROW_NUMBER() OVER (PARTITION BY product_id ORDER BY _loaded_at DESC) = 1;

-- staging order_items
CREATE TABLE IF NOT EXISTS order_items AS
SELECT
  item_id,
  order_id,
  product_id,
  quantity,
  unit_price,
  _loaded_at
FROM ECOMM_DB.RAW.order_items
WHERE item_id  IS NOT NULL
  AND order_id IS NOT NULL
QUALIFY ROW_NUMBER() OVER (PARTITION BY item_id ORDER BY _loaded_at DESC) = 1;

-- staging events
CREATE TABLE IF NOT EXISTS events AS
SELECT
  event_id,
  user_id,
  LOWER(TRIM(event_type)) AS event_type,
  LOWER(TRIM(page))       AS page,
  product_id,
  session_id,
  event_at::TIMESTAMP_NTZ AS event_at,
  _loaded_at
FROM ECOMM_DB.RAW.events
WHERE event_id IS NOT NULL
  AND user_id  IS NOT NULL
QUALIFY ROW_NUMBER() OVER (PARTITION BY event_id ORDER BY _loaded_at DESC) = 1;

-- verify all
SELECT 'users'       , COUNT(*) FROM users
UNION ALL
SELECT 'products'    , COUNT(*) FROM products
UNION ALL
SELECT 'orders'      , COUNT(*) FROM orders
UNION ALL
SELECT 'order_items' , COUNT(*) FROM order_items
UNION ALL
SELECT 'events'      , COUNT(*) FROM events;