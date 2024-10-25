EXPLAIN ANALYZE
SELECT prod_id 
FROM inventory
WHERE quan_in_stock < 50;
-- before b-tree index creation
-- planning time: ~0.06 ms
-- exe time: ~0.55 ms

-- after b-tree index creation
-- planning time: ~0.07 ms
-- exe time: ~0.25 ms

EXPLAIN ANALYZE
SELECT prod_id, common_prod_id, title, price 
FROM products
WHERE price = 19.99;

-- before hash index creation
-- planning time: ~0.03 ms
-- exe time: ~1.17 ms

-- after hash index creation
-- planning time: ~0.04 ms
-- exe time: ~0.24 ms



