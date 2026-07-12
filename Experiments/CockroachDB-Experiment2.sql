EXPLAIN (VERBOSE)
SELECT c.name, c.country
FROM customers c
WHERE c.id IN (
    SELECT o.customer_id
    FROM orders o
    WHERE o.total > 1000
);

EXPLAIN (VERBOSE)
SELECT c.name, c.country
FROM customers c
JOIN orders o ON c.id = o.customer_id
WHERE o.total > 1000;

EXPLAIN (VERBOSE)
SELECT c.name, c.country
FROM customers c
WHERE EXISTS (
    SELECT 1
    FROM orders o
    WHERE o.customer_id = c.id
    AND o.total > 1000
);

EXPLAIN ANALYZE (DISTSQL)
SELECT c.name, c.country
FROM customers c
WHERE c.id IN (
    SELECT o.customer_id
    FROM orders o
    WHERE o.total > 1000
);