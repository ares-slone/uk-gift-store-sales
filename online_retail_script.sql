/* DATA IMPORT 
Create the initial table

Note 1: invoice_number and stock_code are typed as text as they can contain letters

Note 2: While no single column serves as a primary key, all transactions must be tied to an invoice,
so invoice_number cannot be null

Note 3: The typing of the unit_price column means the four rows with a unit price of '0.001' 
will be truncated to '0.00' */

CREATE TABLE online_retail(
	invoice_number TEXT NOT NULL,
    stock_code TEXT NULL,
    description TEXT NULL, 
    quantity INT NULL,
    invoice_date DATETIME NULL,
    unit_price DECIMAL(10,2) NULL,
    customer_id INT NULL,
    country TEXT NULL
    );
    
-- Import data from partially cleaned CSV file

LOAD DATA INFILE  'online_retail/online_retail.csv'
INTO TABLE online_retail  
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- Data check

SELECT *
FROM online_retail;

/* DATA CLEANING

Set up clean data table:
1. Create table of standardized stock descriptions for easier comparisons
2. Remove duplicate rows if any
2 a. Descriptions replaced with standardized descriptions
2 b. Irrelevant non-products with the following stock codes removed: S (samples), POST (postage), 
M (manual entries), PADS (purchase of pads), gift_0001_XX (gift vouchers), DOT (dotcom postage), 
D (discount), CRUK (CRUK commission), C2 (Carriage), BANK CHARGES (bank charges), 
B ("adjust bad debit"), AMAZONFEE (Amazon fees)
3. Create clean data table:
3 a. Add in calculation column for total invoice amount */


-- 1. Create standardized description table

CREATE TABLE standard_stock_descriptions(
	stock_code TEXT NULL,
    description TEXT NULL
    );

/* The following chooses the description found with a stock code most often as the standard 
description with the assumption that products are likely sold normally with the default 
description left in place versus damages or other scenarios requiring notes */

INSERT INTO standard_stock_descriptions (stock_code, description)
WITH RankedDescriptions AS (
SELECT 
        stock_code, 
        description, 
        COUNT(description) OVER(PARTITION BY stock_code ORDER BY COUNT(description) DESC) as max_desc
    FROM online_retail
    WHERE description IS NOT NULL
      AND description != ''
    GROUP BY stock_code, description
)
SELECT stock_code, description AS standard_description
FROM RankedDescriptions
WHERE max_desc = 1;

-- 2. Duplicate handling
/* Due to the lack of a primary key and needing to use many rows for unique identification,
 we will use DISTINCT to create a new table without duplicates */

CREATE TABLE dupe_cleaning(
	invoice_number TEXT NOT NULL,
    stock_code TEXT NULL,
    description TEXT NULL, 
    quantity INT NULL,
    invoice_date DATETIME NULL,
    unit_price DECIMAL(10,2) NULL,
    customer_id INT NULL,
    country TEXT NULL
    );
    
INSERT INTO dupe_cleaning
SELECT online_retail.invoice_number,
    online_retail.stock_code,
-- 2 a. inserting standard descriptions
    standard_stock_descriptions.description,
    online_retail.quantity,
    online_retail.invoice_date,
    online_retail.unit_price,
    online_retail.customer_id,
    online_retail.country
    FROM online_retail
    LEFT JOIN standard_stock_descriptions 
    ON online_retail.stock_code = standard_stock_descriptions.stock_code
-- 2 b. non-product removal
    WHERE online_retail.stock_code NOT IN ('S',  'POST', 'M', 'PADS', 'DOT', 'D',
    'CRUK', 'C2', 'BANK CHARGES', 'B', 'AMAZONFEE') AND online_retail.stock_code 
    NOT LIKE 'gift_0001_%';    

-- Math sanity check

SELECT COUNT(*)
FROM (SELECT DISTINCT * FROM dupe_cleaning) AS distinct_rows;
-- Distinct rows = 533695

SELECT COUNT(*)
from dupe_cleaning;
-- Total rows = 538959
-- 5264 duplicates total

-- 3. Create clean data table sans duplicates

CREATE TABLE clean_online_retail(
	invoice_number TEXT NOT NULL,
    stock_code TEXT NULL,
    description TEXT NULL, 
    quantity INT NULL,
    invoice_date DATETIME NULL,
    unit_price DECIMAL(10,2) NULL,
    invoice_total DECIMAL(10,2) NULL,
    customer_id INT NULL,
    country TEXT NULL);

INSERT INTO clean_online_retail(invoice_number, stock_code, description, quantity, invoice_date, 
unit_price, invoice_total, customer_id, country)
SELECT invoice_number,
	stock_code,
	description,
    quantity,
    invoice_date,
    unit_price,
-- 3 a. Inserting in invoice totals
    SUM(quantity * unit_price) OVER(PARTITION BY invoice_number) AS invoice_total,
    customer_id,
    country
FROM (
    SELECT DISTINCT 
        invoice_number, stock_code, description, quantity, 
        invoice_date, unit_price, customer_id, country
    FROM dupe_cleaning
) AS unique_data;

-- Sanity check; total rows = 533695
SELECT COUNT(*)
FROM clean_online_retail;

/* EXPLORATORY DATA CLEANING */
    
-- Total sales
SELECT SUM(quantity*unit_price) as total_sales
FROM clean_online_retail;
-- Total: 9770766.31

-- Total sales per month
SELECT SUM(quantity * unit_price) as total_sales, DATE_FORMAT(invoice_date, '%Y-%m') as month_year
FROM clean_online_retail
GROUP BY month_year
ORDER BY total_sales DESC;

-- Total sales per product: Top 10, Bottom 10
-- Top 10 products by sales amount with sales volume:
SELECT 
    stock_code,
    description,
    SUM(quantity * unit_price) AS product_sales,
    SUM(quantity) AS product_volume
FROM clean_online_retail
GROUP BY stock_code, description
ORDER BY product_sales DESC
LIMIT 10;

-- Bottom 10 products by sales amount with sales volume:
SELECT 
    stock_code,
    description,
    SUM(quantity * unit_price) AS product_sales,
    SUM(quantity) AS product_volume
FROM clean_online_retail
GROUP BY stock_code, description
HAVING product_sales > 0 AND product_volume > 0
ORDER BY product_sales ASC
LIMIT 10;

-- Total Sales per country
SELECT SUM(quantity * unit_price) as total_sales, country
FROM clean_online_retail
GROUP BY country
HAVING country IS NOT NULL
ORDER BY total_sales DESC;

-- Total Sales per customer
SELECT SUM(quantity * unit_price) as total_sales, customer_id
FROM clean_online_retail
GROUP BY customer_id
HAVING customer_ID IS NOT NULL
ORDER BY total_sales DESC;


-- Invoice count per customer
SELECT COUNT(DISTINCT invoice_number) as total_invoices, customer_id
FROM clean_online_retail
GROUP BY customer_id
HAVING customer_ID IS NOT NULL
ORDER BY total_invoices DESC;


