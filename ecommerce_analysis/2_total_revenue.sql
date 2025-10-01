-- Calcualte what % of total revenue this represents to assess impact.
SELECT
    ROUND(SUM(quantity * unitprice), 2) AS total_revenue,
    ROUND(SUM(CASE WHEN customerid IS NULL THEN quantity * unitprice END), 2) AS revenue_unknown,
    ROUND(100.0 * SUM(CASE WHEN customerid IS NULL THEN quantity * unitprice END) / SUM(quantity * unitprice), 2) AS pct_unknown
FROM ecommerce_clean;

/* Total Revenue = 10,666,684.54
  - Revenue from Unknown Customers = 1755276.64
  - % Unknown Customers = 16.46% of total revenue
  - Almost 16% of sales revenue cannot be attributed to a customer (due to missing CustomerID).
  - This means customer-level analytics (RFM, retention, segmentation) will only cover ~85% of revenue.
  - For company-wide KPIs (sales, products, countries, trends), include all records.
*/