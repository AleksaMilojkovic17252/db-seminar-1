-- 1. Derived subquery, unfiltered inside, filtered outside — logical plan
EXPLAIN (VERBOSE)
SELECT * FROM (
    SELECT * FROM orders
) AS subq
WHERE subq.status = 'shipped'
AND subq.total > 500;

-- 2. Same query, written as a CTE instead — logical plan
EXPLAIN (VERBOSE)
WITH order_subset AS (
    SELECT * FROM orders
)
SELECT * FROM order_subset
WHERE status = 'shipped'
AND total > 500;

-- 3. CTE with a join, filter already inside the CTE — logical plan, "before" ANALYZE
EXPLAIN (VERBOSE)
WITH big_orders AS (
    SELECT * FROM orders WHERE total > 500
)
SELECT c.name, bo.total
FROM customers c
JOIN big_orders bo ON c.id = bo.customer_id
WHERE c.country = 'RS';

-- 4. Same query, timed — "before" ANALYZE
EXPLAIN ANALYZE (DISTSQL)
WITH big_orders AS (
    SELECT * FROM orders WHERE total > 500
)
SELECT c.name, bo.total
FROM customers c
JOIN big_orders bo ON c.id = bo.customer_id
WHERE c.country = 'RS';

-- 5. Refresh statistics
ANALYZE customers;

-- 6. Refresh statistics
ANALYZE orders;

-- 7. Same query as 3, re-run after ANALYZE — logical plan, "after" comparison
EXPLAIN (VERBOSE)
WITH big_orders AS (
    SELECT * FROM orders WHERE total > 500
)
SELECT c.name, bo.total
FROM customers c
JOIN big_orders bo ON c.id = bo.customer_id
WHERE c.country = 'RS';

-- 8. Same query as 4, re-run after ANALYZE — timed, "after" comparison
EXPLAIN ANALYZE (DISTSQL)
WITH big_orders AS (
    SELECT * FROM orders WHERE total > 500
)
SELECT c.name, bo.total
FROM customers c
JOIN big_orders bo ON c.id = bo.customer_id
WHERE c.country = 'RS';