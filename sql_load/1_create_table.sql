CREATE TABLE ecommerce_data (
    InvoiceNo   VARCHAR(20),
    StockCode   VARCHAR(20),
    Description TEXT,
    Quantity    INT,
    InvoiceDate TIMESTAMP,
    UnitPrice   NUMERIC(10,2),
    CustomerID  INT,
    Country     VARCHAR(50)
);
