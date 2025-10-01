-- 1. Total Revenue
SELECT ROUND(SUM(quantity * unitprice), 2) AS total_revenue
FROM ecommerce_clean;
-- 10666684.54

-- 2. Number of Unique Customers
SELECT COUNT(DISTINCT customerid) AS total_customers
FROM ecommerce_clean
WHERE customerid IS NOT NULL;
-- 4338

-- 3. Number of Orders
SELECT COUNT(DISTINCT invoiceno) AS total_orders
FROM ecommerce_clean;
-- 19960

-- 4. Top 10 Products by Sales Quantity
SELECT description, SUM(quantity) AS total_sold
FROM ecommerce_clean
WHERE description IS NOT NULL
GROUP BY description
ORDER BY total_sold DESC
LIMIT 10;

[
  {
    "description": "PAPER CRAFT , LITTLE BIRDIE",
    "total_sold": "80995"
  },
  {
    "description": "MEDIUM CERAMIC TOP STORAGE JAR",
    "total_sold": "78033"
  },
  {
    "description": "WORLD WAR 2 GLIDERS ASSTD DESIGNS",
    "total_sold": "55047"
  },
  {
    "description": "JUMBO BAG RED RETROSPOT",
    "total_sold": "48474"
  },
  {
    "description": "WHITE HANGING HEART T-LIGHT HOLDER",
    "total_sold": "37891"
  },
  {
    "description": "POPCORN HOLDER",
    "total_sold": "36761"
  },
  {
    "description": "ASSORTED COLOUR BIRD ORNAMENT",
    "total_sold": "36461"
  },
  {
    "description": "PACK OF 72 RETROSPOT CAKE CASES",
    "total_sold": "36419"
  },
  {
    "description": "RABBIT NIGHT LIGHT",
    "total_sold": "30788"
  },
  {
    "description": "MINI PAINT SET VINTAGE ",
    "total_sold": "26633"
  }
]

-- 5. Top Countries by Revenue
SELECT country, ROUND(SUM(quantity * unitprice), 2) AS revenue
FROM ecommerce_clean
GROUP BY country
ORDER BY revenue DESC
LIMIT 10;

[
  {
    "country": "United Kingdom",
    "revenue": "9025222.08"
  },
  {
    "country": "Netherlands",
    "revenue": "285446.34"
  },
  {
    "country": "EIRE",
    "revenue": "283453.96"
  },
  {
    "country": "Germany",
    "revenue": "228867.14"
  },
  {
    "country": "France",
    "revenue": "209715.11"
  },
  {
    "country": "Australia",
    "revenue": "138521.31"
  },
  {
    "country": "Spain",
    "revenue": "61577.11"
  },
  {
    "country": "Switzerland",
    "revenue": "57089.90"
  },
  {
    "country": "Belgium",
    "revenue": "41196.34"
  },
  {
    "country": "Sweden",
    "revenue": "38378.33"
  }
]

-- 6. Monthly Revenue Trend
SELECT DATE_TRUNC('month', invoicedate) AS month,
       ROUND(SUM(quantity * unitprice), 2) AS revenue
FROM ecommerce_clean
GROUP BY month
ORDER BY month;

[
  {
    "month": "2010-12-01 00:00:00",
    "revenue": "823746.14"
  },
  {
    "month": "2011-01-01 00:00:00",
    "revenue": "691364.56"
  },
  {
    "month": "2011-02-01 00:00:00",
    "revenue": "523631.89"
  },
  {
    "month": "2011-03-01 00:00:00",
    "revenue": "717639.36"
  },
  {
    "month": "2011-04-01 00:00:00",
    "revenue": "537808.62"
  },
  {
    "month": "2011-05-01 00:00:00",
    "revenue": "770536.02"
  },
  {
    "month": "2011-06-01 00:00:00",
    "revenue": "761739.90"
  },
  {
    "month": "2011-07-01 00:00:00",
    "revenue": "719221.19"
  },
  {
    "month": "2011-08-01 00:00:00",
    "revenue": "759138.38"
  },
  {
    "month": "2011-09-01 00:00:00",
    "revenue": "1058590.17"
  },
  {
    "month": "2011-10-01 00:00:00",
    "revenue": "1154979.30"
  },
  {
    "month": "2011-11-01 00:00:00",
    "revenue": "1509496.33"
  },
  {
    "month": "2011-12-01 00:00:00",
    "revenue": "638792.68"
  }
]