-- Sheet: 03_raw_tables
-- Purpose: bronze layer table DDL
-- Role needed: FR_DATA_ENGINEER
-- Date: 22-Mar-2026

USE ROLE FR_DATA_ENGINEER;
USE WAREHOUSE LOAD_WH;
USE SCHEMA ECOMM_DB.RAW;

CREATE TABLE IF NOT EXISTS users (
  user_id       NUMBER        NOT NULL,
  name          VARCHAR(100),
  email         VARCHAR(200),
  phone         VARCHAR(20),
  city          VARCHAR(100),
  created_at    TIMESTAMP_NTZ,
  _loaded_at    TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP()
);

CREATE TABLE IF NOT EXISTS products (
  product_id    NUMBER        NOT NULL,
  name          VARCHAR(200),
  category      VARCHAR(100),
  price         NUMBER(10,2),
  created_at    TIMESTAMP_NTZ,
  _loaded_at    TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP()
);

CREATE TABLE IF NOT EXISTS orders (
  order_id      NUMBER        NOT NULL,
  user_id       NUMBER,
  status        VARCHAR(50),
  total_amount  NUMBER(10,2),
  created_at    TIMESTAMP_NTZ,
  _loaded_at    TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP()
);

CREATE TABLE IF NOT EXISTS order_items (
  item_id       NUMBER        NOT NULL,
  order_id      NUMBER,
  product_id    NUMBER,
  quantity      NUMBER,
  unit_price    NUMBER(10,2),
  _loaded_at    TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP()
);

CREATE TABLE IF NOT EXISTS events (
  event_id      NUMBER        NOT NULL,
  user_id       NUMBER,
  event_type    VARCHAR(50),
  page          VARCHAR(100),
  product_id    NUMBER,
  session_id    VARCHAR(100),
  event_at      TIMESTAMP_NTZ,
  _loaded_at    TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP()
);

SHOW TABLES IN SCHEMA ECOMM_DB.RAW;-- Sheet: 03_raw_tables
-- Purpose: bronze layer table DDL
-- Role needed: FR_DATA_ENGINEER
-- Date: 22-Mar-2026

USE ROLE FR_DATA_ENGINEER;
USE WAREHOUSE LOAD_WH;
USE SCHEMA ECOMM_DB.RAW;

CREATE TABLE IF NOT EXISTS users (
  user_id       NUMBER        NOT NULL,
  name          VARCHAR(100),
  email         VARCHAR(200),
  phone         VARCHAR(20),
  city          VARCHAR(100),
  created_at    TIMESTAMP_NTZ,
  _loaded_at    TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP()
);

CREATE TABLE IF NOT EXISTS products (
  product_id    NUMBER        NOT NULL,
  name          VARCHAR(200),
  category      VARCHAR(100),
  price         NUMBER(10,2),
  created_at    TIMESTAMP_NTZ,
  _loaded_at    TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP()
);

CREATE TABLE IF NOT EXISTS orders (
  order_id      NUMBER        NOT NULL,
  user_id       NUMBER,
  status        VARCHAR(50),
  total_amount  NUMBER(10,2),
  created_at    TIMESTAMP_NTZ,
  _loaded_at    TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP()
);

CREATE TABLE IF NOT EXISTS order_items (
  item_id       NUMBER        NOT NULL,
  order_id      NUMBER,
  product_id    NUMBER,
  quantity      NUMBER,
  unit_price    NUMBER(10,2),
  _loaded_at    TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP()
);

CREATE TABLE IF NOT EXISTS events (
  event_id      NUMBER        NOT NULL,
  user_id       NUMBER,
  event_type    VARCHAR(50),
  page          VARCHAR(100),
  product_id    NUMBER,
  session_id    VARCHAR(100),
  event_at      TIMESTAMP_NTZ,
  _loaded_at    TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP()
);

SHOW TABLES IN SCHEMA ECOMM_DB.RAW;