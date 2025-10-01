COPY ecommerce_data
FROM '/Users/hannahlim/Downloads/SQL/SQL_Project_Ecommerce_Analysis/csv_files/ecommerce_data.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'LATIN1');

/*
\copy ecommerce_data FROM '/Users/hannahlim/Downloads/SQL/SQL_Project_Ecommerce_Analysis/csv_files/ecommerce_data.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'LATIN1');
*/

-- SELECT *
-- FROM ecommerce_data;