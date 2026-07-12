EXPLAIN (VERBOSE)
SELECT * FROM (
    SELECT * FROM orders
) AS subq
WHERE subq.status = 'shipped'
AND subq.total > 500;

EXPLAIN (VERBOSE)
WITH order_subset AS (
    SELECT * FROM orders
)
SELECT * FROM order_subset
WHERE status = 'shipped'
AND total > 500;

EXPLAIN (VERBOSE)
WITH big_orders AS (
    SELECT * FROM orders WHERE total > 500
)
SELECT c.name, bo.total
FROM customers c
JOIN big_orders bo ON c.id = bo.customer_id
WHERE c.country = 'RS';

EXPLAIN ANALYZE (DISTSQL)
WITH big_orders AS (
    SELECT * FROM orders WHERE total > 500
)
SELECT c.name, bo.total
FROM customers c
JOIN big_orders bo ON c.id = bo.customer_id
WHERE c.country = 'RS';

ANALYZE customers;

ANALYZE orders;