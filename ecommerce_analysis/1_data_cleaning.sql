-- Number of rows
SELECT COUNT(*) FROM ecommerce_data;

-- Count = 541909

-- First 5 rows
SELECT * FROM ecommerce_data LIMIT 5;

[
  {
    "invoiceno": "536365",
    "stockcode": "85123A",
    "description": "WHITE HANGING HEART T-LIGHT HOLDER",
    "quantity": 6,
    "invoicedate": "2010-12-01 08:26:00",
    "unitprice": "2.55",
    "customerid": 17850,
    "country": "United Kingdom"
  },
  {
    "invoiceno": "536365",
    "stockcode": "71053",
    "description": "WHITE METAL LANTERN",
    "quantity": 6,
    "invoicedate": "2010-12-01 08:26:00",
    "unitprice": "3.39",
    "customerid": 17850,
    "country": "United Kingdom"
  },
  {
    "invoiceno": "536365",
    "stockcode": "84406B",
    "description": "CREAM CUPID HEARTS COAT HANGER",
    "quantity": 8,
    "invoicedate": "2010-12-01 08:26:00",
    "unitprice": "2.75",
    "customerid": 17850,
    "country": "United Kingdom"
  },
  {
    "invoiceno": "536365",
    "stockcode": "84029G",
    "description": "KNITTED UNION FLAG HOT WATER BOTTLE",
    "quantity": 6,
    "invoicedate": "2010-12-01 08:26:00",
    "unitprice": "3.39",
    "customerid": 17850,
    "country": "United Kingdom"
  },
  {
    "invoiceno": "536365",
    "stockcode": "84029E",
    "description": "RED WOOLLY HOTTIE WHITE HEART.",
    "quantity": 6,
    "invoicedate": "2010-12-01 08:26:00",
    "unitprice": "3.39",
    "customerid": 17850,
    "country": "United Kingdom"
  }
]

-- Any NULLs in key columns?
SELECT
    COUNT(*) FILTER (WHERE invoiceno IS NULL) AS null_invoiceno,
    COUNT(*) FILTER (WHERE stockcode IS NULL) AS null_stockcode,
    COUNT(*) FILTER (WHERE description IS NULL) AS null_description,
    COUNT(*) FILTER (WHERE quantity IS NULL) AS null_quantity,
    COUNT(*) FILTER (WHERE invoicedate IS NULL) AS null_invoicedate,
    COUNT(*) FILTER (WHERE unitprice IS NULL) AS null_unitprice,
    COUNT(*) FILTER (WHERE customerid IS NULL) AS null_customerid,
    COUNT(*) FILTER (WHERE country IS NULL) AS null_country
FROM ecommerce_data;

[
  {
    "null_invoiceno": "0",
    "null_stockcode": "0",
    "null_description": "1454",
    "null_quantity": "0",
    "null_invoicedate": "0",
    "null_unitprice": "0",
    "null_customerid": "135080",
    "null_country": "0"
  }
]

-- 1. Descriptions (1,454 missing)
SELECT * 
FROM ecommerce_data WHERE description IS NULL
LIMIT 10;

-- 2. CustomerID (135,080 missing)
SELECT ROUND(SUM(quantity * unitprice), 2) AS revenue_unknown
FROM ecommerce_data
WHERE customerid IS NULL

-- 1447682.12

-- 3. Negative quantities & cancelled invoices
SELECT COUNT(*) AS negative_qty
FROM ecommerce_data
WHERE quantity < 0;

-- negative qty = 10624

SELECT COUNT(*) AS cancelled_invoices
FROM ecommerce_data
WHERE invoiceno LIKE 'C%';

-- cancelled_invoices = 9288

-- Data Cleaning
CREATE TABLE ecommerce_clean AS ecommerce_clean
SELECT *
FROM ecommerce_data
WHERE
  quantity > 0
  AND unitprice > 0
  AND invoiceno NOT LIKE 'C%';