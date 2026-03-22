-- Sheet: 07_streams_tasks
-- Purpose: automated pipeline using streams and tasks
-- Role needed: FR_DATA_ENGINEER
-- Date: 22-Mar-2026

USE ROLE FR_DATA_ENGINEER;
USE WAREHOUSE TRANSFORM_WH;
USE SCHEMA ECOMM_DB.RAW;

-- Stream: watches RAW.orders for new rows
CREATE OR REPLACE STREAM orders_stream
  ON TABLE ECOMM_DB.RAW.orders
  APPEND_ONLY = TRUE
  COMMENT = 'Captures new rows inserted into RAW.orders';

-- Verify
SHOW STREAMS;