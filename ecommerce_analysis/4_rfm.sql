/* RFM (Recency, Frequency, and Monetary)
 -- Recency: How recently a customer purchased.
 -- Frequency: How often a customer purchased.
 -- Monetary: How much a customer spent.
 We'll calculate these three metrics per customer
*/

-- Find the Snapshot Date
SELECT MAX(invoicedate) AS last_date
FROM ecommerce_clean;
-- 2011-12-09 12:50:00

-- Compute R, F, M per Customer
WITH customer_rfm AS (
    SELECT
        customerid,
        -- Recency: days since last purchase
        DATE_PART('day', (DATE '2011-12-10' - MAX(invoicedate))) AS recency,
        -- Frequency: number of unique invoices
        COUNT(DISTINCT invoiceno) AS frequency,
        -- Monetary: total spent
        ROUND(SUM(quantity * unitprice), 2) AS monetary
    FROM ecommerce_clean
    WHERE customerid IS NOT NULL
    GROUP BY customerid
)
SELECT * FROM customer_rfm
ORDER BY customerid
LIMIT 10;

/* Rank Customers 
  - We assign quintiles (1 = lowest, 5 = highest).
  - For recency, lower = better (recent buyers).
  - For frequency & monetary, higher = better.
*/

[
  {
    "customerid": 12346,
    "recency": 325,
    "frequency": "1",
    "monetary": "77183.60"
  },
  {
    "customerid": 12347,
    "recency": 2,
    "frequency": "7",
    "monetary": "4310.00"
  },
  {
    "customerid": 12348,
    "recency": 75,
    "frequency": "4",
    "monetary": "1797.24"
  },
  {
    "customerid": 12349,
    "recency": 18,
    "frequency": "1",
    "monetary": "1757.55"
  },
  {
    "customerid": 12350,
    "recency": 310,
    "frequency": "1",
    "monetary": "334.40"
  },
  {
    "customerid": 12352,
    "recency": 36,
    "frequency": "8",
    "monetary": "2506.04"
  },
  {
    "customerid": 12353,
    "recency": 204,
    "frequency": "1",
    "monetary": "89.00"
  },
  {
    "customerid": 12354,
    "recency": 232,
    "frequency": "1",
    "monetary": "1079.40"
  },
  {
    "customerid": 12355,
    "recency": 214,
    "frequency": "1",
    "monetary": "459.40"
  },
  {
    "customerid": 12356,
    "recency": 22,
    "frequency": "3",
    "monetary": "2811.43"
  }
]

WITH customer_rfm AS (
    SELECT
        customerid,
        DATE_PART('day', (DATE '2011-12-10' - MAX(invoicedate))) AS recency,
        COUNT(DISTINCT invoiceno) AS frequency,
        ROUND(SUM(quantity * unitprice), 2) AS monetary
    FROM ecommerce_clean
    WHERE customerid IS NOT NULL
    GROUP BY customerid
),
rfm_score AS (
    SELECT
        customerid,
        recency,
        frequency,
        monetary,
        NTILE(5) OVER (ORDER BY recency ASC)   AS r_score,   -- Lower recency = better
        NTILE(5) OVER (ORDER BY frequency ASC) AS f_score,   -- Higher frequency = better
        NTILE(5) OVER (ORDER BY monetary ASC)  AS m_score    -- Higher spend = better
    FROM customer_rfm
)
SELECT *,
       (r_score::text || f_score::text || m_score::text) AS rfm_segment,
       (r_score + f_score + m_score)   AS rfm_total
FROM rfm_score
ORDER BY rfm_total DESC
LIMIT 20;

/*
555 = Champions (recent, frequent, high spenders).
511/411 = Loyal Customers (buy often, moderate spend).
151 = At Risk (big spenders, but not recent).
111 = Lost (long ago, rare, low spend).
*/

[
  {
    "customerid": 15235,
    "recency": 217,
    "frequency": "12",
    "monetary": "2247.51",
    "r_score": 5,
    "f_score": 5,
    "m_score": 5,
    "rfm_segment": "555",
    "rfm_total": 15
  },
  {
    "customerid": 17230,
    "recency": 264,
    "frequency": "8",
    "monetary": "3638.41",
    "r_score": 5,
    "f_score": 5,
    "m_score": 5,
    "rfm_segment": "555",
    "rfm_total": 15
  },
  {
    "customerid": 13093,
    "recency": 275,
    "frequency": "8",
    "monetary": "7832.47",
    "r_score": 5,
    "f_score": 5,
    "m_score": 5,
    "rfm_segment": "555",
    "rfm_total": 15
  },
  {
    "customerid": 17504,
    "recency": 206,
    "frequency": "9",
    "monetary": "2997.03",
    "r_score": 5,
    "f_score": 5,
    "m_score": 5,
    "rfm_segment": "555",
    "rfm_total": 15
  },
  {
    "customerid": 17850,
    "recency": 372,
    "frequency": "34",
    "monetary": "5391.21",
    "r_score": 5,
    "f_score": 5,
    "m_score": 5,
    "rfm_segment": "555",
    "rfm_total": 15
  },
  {
    "customerid": 14407,
    "recency": 107,
    "frequency": "6",
    "monetary": "2157.73",
    "r_score": 4,
    "f_score": 5,
    "m_score": 5,
    "rfm_segment": "455",
    "rfm_total": 14
  },
  {
    "customerid": 17050,
    "recency": 96,
    "frequency": "6",
    "monetary": "3228.84",
    "r_score": 4,
    "f_score": 5,
    "m_score": 5,
    "rfm_segment": "455",
    "rfm_total": 14
  },
  {
    "customerid": 14364,
    "recency": 108,
    "frequency": "8",
    "monetary": "3717.35",
    "r_score": 4,
    "f_score": 5,
    "m_score": 5,
    "rfm_segment": "455",
    "rfm_total": 14
  },
  {
    "customerid": 16745,
    "recency": 86,
    "frequency": "17",
    "monetary": "7194.30",
    "r_score": 4,
    "f_score": 5,
    "m_score": 5,
    "rfm_segment": "455",
    "rfm_total": 14
  },
  {
    "customerid": 15410,
    "recency": 84,
    "frequency": "8",
    "monetary": "3450.84",
    "r_score": 4,
    "f_score": 5,
    "m_score": 5,
    "rfm_segment": "455",
    "rfm_total": 14
  },
  {
    "customerid": 15939,
    "recency": 89,
    "frequency": "15",
    "monetary": "6115.01",
    "r_score": 4,
    "f_score": 5,
    "m_score": 5,
    "rfm_segment": "455",
    "rfm_total": 14
  },
  {
    "customerid": 15491,
    "recency": 95,
    "frequency": "6",
    "monetary": "3100.09",
    "r_score": 4,
    "f_score": 5,
    "m_score": 5,
    "rfm_segment": "455",
    "rfm_total": 14
  },
  {
    "customerid": 13631,
    "recency": 99,
    "frequency": "11",
    "monetary": "3070.42",
    "r_score": 4,
    "f_score": 5,
    "m_score": 5,
    "rfm_segment": "455",
    "rfm_total": 14
  },
  {
    "customerid": 16180,
    "recency": 100,
    "frequency": "8",
    "monetary": "10254.18",
    "r_score": 4,
    "f_score": 5,
    "m_score": 5,
    "rfm_segment": "455",
    "rfm_total": 14
  },
  {
    "customerid": 14307,
    "recency": 88,
    "frequency": "6",
    "monetary": "2995.72",
    "r_score": 4,
    "f_score": 5,
    "m_score": 5,
    "rfm_segment": "455",
    "rfm_total": 14
  },
  {
    "customerid": 12455,
    "recency": 73,
    "frequency": "6",
    "monetary": "2466.86",
    "r_score": 4,
    "f_score": 5,
    "m_score": 5,
    "rfm_segment": "455",
    "rfm_total": 14
  },
  {
    "customerid": 14101,
    "recency": 73,
    "frequency": "6",
    "monetary": "5976.79",
    "r_score": 4,
    "f_score": 5,
    "m_score": 5,
    "rfm_segment": "455",
    "rfm_total": 14
  },
  {
    "customerid": 14854,
    "recency": 78,
    "frequency": "7",
    "monetary": "2759.83",
    "r_score": 4,
    "f_score": 5,
    "m_score": 5,
    "rfm_segment": "455",
    "rfm_total": 14
  },
  {
    "customerid": 18094,
    "recency": 81,
    "frequency": "7",
    "monetary": "3017.30",
    "r_score": 4,
    "f_score": 5,
    "m_score": 5,
    "rfm_segment": "455",
    "rfm_total": 14
  },
  {
    "customerid": 17591,
    "recency": 73,
    "frequency": "7",
    "monetary": "2225.97",
    "r_score": 4,
    "f_score": 5,
    "m_score": 5,
    "rfm_segment": "455",
    "rfm_total": 14
  }
]

-- Calculate revenue contribution by RFM segments

WITH customer_rfm AS (
    SELECT
        customerid,
        DATE_PART('day', (DATE '2011-12-10' - MAX(invoicedate))) AS recency,
        COUNT(DISTINCT invoiceno) AS frequency,
        ROUND(SUM(quantity * unitprice), 2) AS monetary
    FROM ecommerce_clean
    WHERE customerid IS NOT NULL
    GROUP BY customerid
),
rfm_score AS (
    SELECT
        customerid,
        recency,
        frequency,
        monetary,
        NTILE(5) OVER (ORDER BY recency ASC)   AS r_score,
        NTILE(5) OVER (ORDER BY frequency ASC) AS f_score,
        NTILE(5) OVER (ORDER BY monetary ASC)  AS m_score
    FROM customer_rfm
),
rfm_segmented AS (
    SELECT
        customerid,
        recency,
        frequency,
        monetary,
        (r_score::text || f_score::text || m_score::text) AS rfm_segment,
        (r_score + f_score + m_score) AS rfm_total,
        CASE
            WHEN r_score = 5 AND f_score = 5 AND m_score = 5 THEN 'Champions'
            WHEN r_score >= 4 AND f_score >= 4 THEN 'Loyal Customers'
            WHEN r_score >= 4 AND m_score >= 4 THEN 'Big Spenders'
            WHEN r_score <= 2 AND f_score <= 2 AND m_score <= 2 THEN 'At Risk / Lost'
            ELSE 'Others'
        END AS customer_segment
    FROM rfm_score
)
SELECT
    customer_segment,
    COUNT(DISTINCT customerid) AS num_customers,
    ROUND(SUM(monetary), 2) AS revenue,
    ROUND(100.0 * SUM(monetary) / (SELECT SUM(monetary) FROM rfm_segmented), 2) AS pct_revenue
FROM rfm_segmented
GROUP BY customer_segment
ORDER BY revenue DESC;

[
  {
    "customer_segment": "Others",
    "num_customers": "3605",
    "revenue": "7927521.74",
    "pct_revenue": "88.96"
  },
  {
    "customer_segment": "Loyal Customers",
    "num_customers": "295",
    "revenue": "548319.92",
    "pct_revenue": "6.15"
  },
  {
    "customer_segment": "Big Spenders",
    "num_customers": "157",
    "revenue": "348650.12",
    "pct_revenue": "3.91"
  },
  {
    "customer_segment": "At Risk / Lost",
    "num_customers": "276",
    "revenue": "64809.49",
    "pct_revenue": "0.73"
  },
  {
    "customer_segment": "Champions",
    "num_customers": "5",
    "revenue": "22106.63",
    "pct_revenue": "0.25"
  }
]