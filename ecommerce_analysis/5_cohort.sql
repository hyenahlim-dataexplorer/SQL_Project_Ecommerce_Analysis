/* cohort = group of customers who made their first purchase in the same month.
 -- track their retention across subsequent months.
*/

-- Assign Each Customer to a Cohort Month
WITH first_purchase AS (
    SELECT
        customerid,
        MIN(DATE_TRUNC('month', invoicedate)) AS cohort_month
    FROM ecommerce_clean
    WHERE customerid IS NOT NULL
    GROUP BY customerid
)
SELECT * FROM first_purchase
ORDER BY cohort_month
LIMIT 10;

[
  {
    "customerid": 15547,
    "cohort_month": "2010-12-01 00:00:00"
  },
  {
    "customerid": 16717,
    "cohort_month": "2010-12-01 00:00:00"
  },
  {
    "customerid": 12621,
    "cohort_month": "2010-12-01 00:00:00"
  },
  {
    "customerid": 15805,
    "cohort_month": "2010-12-01 00:00:00"
  },
  {
    "customerid": 14913,
    "cohort_month": "2010-12-01 00:00:00"
  },
  {
    "customerid": 14466,
    "cohort_month": "2010-12-01 00:00:00"
  },
  {
    "customerid": 13093,
    "cohort_month": "2010-12-01 00:00:00"
  },
  {
    "customerid": 13520,
    "cohort_month": "2010-12-01 00:00:00"
  },
  {
    "customerid": 18041,
    "cohort_month": "2010-12-01 00:00:00"
  },
  {
    "customerid": 15197,
    "cohort_month": "2010-12-01 00:00:00"
  }
]

-- Combine Transactions with Cohort Info
WITH first_purchase AS (
    SELECT
        customerid,
        MIN(DATE_TRUNC('month', invoicedate)) AS cohort_month
    FROM ecommerce_clean
    WHERE customerid IS NOT NULL
    GROUP BY customerid
),
transactions AS (
    SELECT
        e.customerid,
        DATE_TRUNC('month', e.invoicedate) AS order_month,
        f.cohort_month
    FROM ecommerce_clean e
    JOIN first_purchase f USING (customerid)
    WHERE e.customerid IS NOT NULL
)
SELECT * FROM transactions
ORDER BY cohort_month, order_month
LIMIT 10;

[
  {
    "customerid": 15332,
    "order_month": "2010-12-01 00:00:00",
    "cohort_month": "2010-12-01 00:00:00"
  },
  {
    "customerid": 15332,
    "order_month": "2010-12-01 00:00:00",
    "cohort_month": "2010-12-01 00:00:00"
  },
  {
    "customerid": 15332,
    "order_month": "2010-12-01 00:00:00",
    "cohort_month": "2010-12-01 00:00:00"
  },
  {
    "customerid": 15332,
    "order_month": "2010-12-01 00:00:00",
    "cohort_month": "2010-12-01 00:00:00"
  },
  {
    "customerid": 15332,
    "order_month": "2010-12-01 00:00:00",
    "cohort_month": "2010-12-01 00:00:00"
  },
  {
    "customerid": 15332,
    "order_month": "2010-12-01 00:00:00",
    "cohort_month": "2010-12-01 00:00:00"
  },
  {
    "customerid": 15332,
    "order_month": "2010-12-01 00:00:00",
    "cohort_month": "2010-12-01 00:00:00"
  },
  {
    "customerid": 15332,
    "order_month": "2010-12-01 00:00:00",
    "cohort_month": "2010-12-01 00:00:00"
  },
  {
    "customerid": 15332,
    "order_month": "2010-12-01 00:00:00",
    "cohort_month": "2010-12-01 00:00:00"
  },
  {
    "customerid": 15332,
    "order_month": "2010-12-01 00:00:00",
    "cohort_month": "2010-12-01 00:00:00"
  }
]

-- Calculate Cohort Index
WITH first_purchase AS (
    SELECT
        customerid,
        MIN(DATE_TRUNC('month', invoicedate)) AS cohort_month
    FROM ecommerce_clean
    WHERE customerid IS NOT NULL
    GROUP BY customerid
),
transactions AS (
    SELECT
        e.customerid,
        DATE_TRUNC('month', e.invoicedate) AS order_month,
        f.cohort_month
    FROM ecommerce_clean e
    JOIN first_purchase f USING (customerid)
    WHERE e.customerid IS NOT NULL
),
cohort_data AS (
    SELECT
        customerid,
        cohort_month,
        order_month,
        (EXTRACT(YEAR FROM order_month) - EXTRACT(YEAR FROM cohort_month)) * 12 +
        (EXTRACT(MONTH FROM order_month) - EXTRACT(MONTH FROM cohort_month)) AS cohort_index
    FROM transactions
)
SELECT * FROM cohort_data
ORDER BY cohort_month, cohort_index, customerid
LIMIT 10;

[
  {
    "customerid": 12347,
    "cohort_month": "2010-12-01 00:00:00",
    "order_month": "2010-12-01 00:00:00",
    "cohort_index": "0"
  },
  {
    "customerid": 12347,
    "cohort_month": "2010-12-01 00:00:00",
    "order_month": "2010-12-01 00:00:00",
    "cohort_index": "0"
  },
  {
    "customerid": 12347,
    "cohort_month": "2010-12-01 00:00:00",
    "order_month": "2010-12-01 00:00:00",
    "cohort_index": "0"
  },
  {
    "customerid": 12347,
    "cohort_month": "2010-12-01 00:00:00",
    "order_month": "2010-12-01 00:00:00",
    "cohort_index": "0"
  },
  {
    "customerid": 12347,
    "cohort_month": "2010-12-01 00:00:00",
    "order_month": "2010-12-01 00:00:00",
    "cohort_index": "0"
  },
  {
    "customerid": 12347,
    "cohort_month": "2010-12-01 00:00:00",
    "order_month": "2010-12-01 00:00:00",
    "cohort_index": "0"
  },
  {
    "customerid": 12347,
    "cohort_month": "2010-12-01 00:00:00",
    "order_month": "2010-12-01 00:00:00",
    "cohort_index": "0"
  },
  {
    "customerid": 12347,
    "cohort_month": "2010-12-01 00:00:00",
    "order_month": "2010-12-01 00:00:00",
    "cohort_index": "0"
  },
  {
    "customerid": 12347,
    "cohort_month": "2010-12-01 00:00:00",
    "order_month": "2010-12-01 00:00:00",
    "cohort_index": "0"
  },
  {
    "customerid": 12347,
    "cohort_month": "2010-12-01 00:00:00",
    "order_month": "2010-12-01 00:00:00",
    "cohort_index": "0"
  }
]

-- Build the Retention Table
WITH first_purchase AS (
    SELECT
        customerid,
        MIN(DATE_TRUNC('month', invoicedate)) AS cohort_month
    FROM ecommerce_clean
    WHERE customerid IS NOT NULL
    GROUP BY customerid
),
transactions AS (
    SELECT
        e.customerid,
        DATE_TRUNC('month', e.invoicedate) AS order_month,
        f.cohort_month
    FROM ecommerce_clean e
    JOIN first_purchase f USING (customerid)
    WHERE e.customerid IS NOT NULL
),
cohort_data AS (
    SELECT
        customerid,
        cohort_month,
        order_month,
        (EXTRACT(YEAR FROM order_month) - EXTRACT(YEAR FROM cohort_month)) * 12 +
        (EXTRACT(MONTH FROM order_month) - EXTRACT(MONTH FROM cohort_month)) AS cohort_index
    FROM transactions
),
cohort_size AS (
    SELECT cohort_month, COUNT(DISTINCT customerid) AS num_customers
    FROM cohort_data
    WHERE cohort_index = 0
    GROUP BY cohort_month
)
SELECT
    c.cohort_month,
    c.cohort_index,
    COUNT(DISTINCT c.customerid) AS retained_customers,
    ROUND(100.0 * COUNT(DISTINCT c.customerid) / cs.num_customers, 2) AS retention_rate
FROM cohort_data c
JOIN cohort_size cs USING (cohort_month)
GROUP BY c.cohort_month, c.cohort_index, cs.num_customers
ORDER BY c.cohort_month, c.cohort_index;


-- The result saved as 5_retention_data.csv

/* cohort_month = month when the customer first purchased
   cohort_index = months since first purchase (0 = signup month)
   retained_customers = number of unique customers active in that month
   retention_rate = % retained relative to cohort size
*/