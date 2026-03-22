-- Sheet: 04_load
-- Purpose: file format + stage + load CSVs into RAW
-- Role needed: FR_DATA_ENGINEER
-- Date: 22-Mar-2026

USE ROLE FR_DATA_ENGINEER;
USE WAREHOUSE LOAD_WH;
USE SCHEMA ECOMM_DB.RAW;

-- Step 1: create file format
CREATE OR REPLACE FILE FORMAT csv_format
  TYPE             = CSV
  FIELD_DELIMITER  = ','
  RECORD_DELIMITER = '\n'
  SKIP_HEADER      = 1
  NULL_IF          = ('NULL', 'null', '')
  EMPTY_FIELD_AS_NULL = TRUE;

-- Step 2: create internal stage
CREATE OR REPLACE STAGE raw_stage
  FILE_FORMAT = csv_format
  COMMENT     = 'Internal stage for raw CSV files';

-- Verify
SHOW STAGES IN SCHEMA ECOMM_DB.RAW;


COPY INTO users
  FROM @raw_stage/users.csv.gz
  FILE_FORMAT = (FORMAT_NAME = csv_format ERROR_ON_COLUMN_COUNT_MISMATCH = FALSE)
  ON_ERROR = CONTINUE;

COPY INTO products
  FROM @raw_stage/products.csv.gz
  FILE_FORMAT = (FORMAT_NAME = csv_format ERROR_ON_COLUMN_COUNT_MISMATCH = FALSE)
  ON_ERROR = CONTINUE;

COPY INTO orders
  FROM @raw_stage/orders.csv.gz
  FILE_FORMAT = (FORMAT_NAME = csv_format ERROR_ON_COLUMN_COUNT_MISMATCH = FALSE)
  ON_ERROR = CONTINUE;

COPY INTO order_items
  FROM @raw_stage/order_items.csv.gz
  FILE_FORMAT = (FORMAT_NAME = csv_format ERROR_ON_COLUMN_COUNT_MISMATCH = FALSE)
  ON_ERROR = CONTINUE;

COPY INTO events
  FROM @raw_stage/events.csv.gz
  FILE_FORMAT = (FORMAT_NAME = csv_format ERROR_ON_COLUMN_COUNT_MISMATCH = FALSE)
  ON_ERROR = CONTINUE;



  SELECT 'users'       , COUNT(*) FROM users
UNION ALL
SELECT 'products'    , COUNT(*) FROM products
UNION ALL
SELECT 'orders'      , COUNT(*) FROM orders
UNION ALL
SELECT 'order_items' , COUNT(*) FROM order_items
UNION ALL
SELECT 'events'      , COUNT(*) FROM events;


SELECT * FROM users LIMIT 5;

UPDATE users       SET _loaded_at = CURRENT_TIMESTAMP() WHERE _loaded_at IS NULL;
UPDATE products    SET _loaded_at = CURRENT_TIMESTAMP() WHERE _loaded_at IS NULL;
UPDATE orders      SET _loaded_at = CURRENT_TIMESTAMP() WHERE _loaded_at IS NULL;
UPDATE order_items SET _loaded_at = CURRENT_TIMESTAMP() WHERE _loaded_at IS NULL;
UPDATE events      SET _loaded_at = CURRENT_TIMESTAMP() WHERE _loaded_at IS NULL;