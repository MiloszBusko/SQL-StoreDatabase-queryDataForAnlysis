
-- Overall discernment of the database 'Store'
-- Done by reviewing tables in RDBMS

-- Amount of tables in the database: 8

-- Description of each table:

--#1 categories: list of 16 categories which are assigned to each individual products
--   2 columns, primary key - category

--#2 cust_hist: list of orders for all customers including order IDs and productIDs
--   3 columns, no primary key

--#3 customers: detailed information about all clients
--   20 columns, primary key - customerid

--#4 inventory: shows the current quantity of all products in stock and the number of units sold till today
--   3 columns, primary key - prod_id

--#5 orderlines: information about the quantity of products for each order with product IDs and  dates of order included
--   5 columns, no primary key

--#6 orders: detailed information about every separate order with dates, customer IDs and expenses included
--   6 columns, primary key - orderid, 12k rows

--#7 products: detailed infomation about each product
--   7 columns, primary key - prod_id, 10k rows

--#8 reorder: this table is intened for unsuccessful order cases and for now it is empty
--   6 columns, no primary key, 0 rows



