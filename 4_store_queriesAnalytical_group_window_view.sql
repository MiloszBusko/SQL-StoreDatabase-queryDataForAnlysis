-- query checking total amount of sold products in May 2004
SELECT p.prod_id, p.title, ol.orderdate, SUM(ol.quantity) AS "total sold"
FROM products AS p
JOIN orderlines AS ol ON p.prod_id = ol.prod_id
WHERE EXTRACT (MONTH FROM ol.orderdate) = 5
AND EXTRACT (YEAR FROM ol.orderdate) = 2004
GROUP BY p.prod_id, p.title, ol.orderdate
ORDER BY "total sold" DESC;

------------------------------------------------------------------------------

-- query checking count of products for catogory with particular filter and total amount of products given
SELECT c.category, c.categoryname, count(p.prod_id) AS "products per category"
FROM categories AS c
JOIN products AS p ON c.category = p.category
GROUP BY GROUPING SETS
(
    (c.category, c.categoryname),
    ()
)
HAVING count(p.prod_id) > 620
ORDER BY category;

------------------------------------------------------------------------------

-- create view with orderdate separated by months, each order income and its percentage relative to annual income
CREATE OR REPLACE VIEW "income_per_order" AS
SELECT
CASE
    WHEN orderdate::TEXT LIKE('2004-01-%') THEN 'january'
    WHEN orderdate::TEXT LIKE('2004-02-%') THEN 'february'
    WHEN orderdate::TEXT LIKE('2004-03-%') THEN 'march'
    WHEN orderdate::TEXT LIKE('2004-04-%') THEN 'april'
    WHEN orderdate::TEXT LIKE('2004-05-%') THEN 'may'
    WHEN orderdate::TEXT LIKE('2004-06-%') THEN 'june'
    WHEN orderdate::TEXT LIKE('2004-07-%') THEN 'july'
    WHEN orderdate::TEXT LIKE('2004-08-%') THEN 'august'
    WHEN orderdate::TEXT LIKE('2004-09-%') THEN 'septemper'
    WHEN orderdate::TEXT LIKE('2004-10-%') THEN 'october'
    WHEN orderdate::TEXT LIKE('2004-11-%') THEN 'november'
    WHEN orderdate::TEXT LIKE('2004-12-%') THEN 'december'
    ELSE 'unknown'
END AS "month_of_2004",
sum(totalamount) OVER(
    PARTITION BY orderid
) AS "total_income_per_order",
( SUM( totalamount::FLOAT ) OVER (PARTITION BY orderid) / 
SUM( totalamount::FLOAT ) OVER() ) * 100
AS "percentage_o_total_income_per_order_relative_to_year"
FROM orders
ORDER BY orderdate;

-- query showing percentage of income for every month in 2004
SELECT month_of_2004 AS "month of 2004", 
concat(round(sum(percentage_o_total_income_per_order_relative_to_year)::NUMERIC, 2),' ', '%') AS "percentage of total income per month relative to year"
FROM income_per_order
GROUP BY month_of_2004
ORDER BY "percentage of total income per month relative to year";

------------------------------------------------------------------------------

-- query which uses aggregate function for data analysis (values for each month)
SELECT
    DATE_TRUNC('month', orderdate) AS "month",
    COUNT(orderid) AS "total orders",
    SUM(totalamount) AS "total sales",
    AVG(totalamount) AS "avg sales value",
    PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY totalamount) AS "median sales value",
    STDDEV_POP(totalamount) AS "standard deviation",
    COUNT(DISTINCT customerid) AS "unique customers"
FROM orders
WHERE orderdate BETWEEN '2004-01-01' AND '2004-12-31'
GROUP BY "month"
ORDER BY "month";