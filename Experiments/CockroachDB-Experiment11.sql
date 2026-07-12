CREATE index if not EXISTS idx_orders_status ON orders (status) STORING (total);

EXPLAIN analyze (DISTSQL)
SELECT
    status,
    count(*) AS cnt,
    sum(total) AS revenue
FROM orders
GROUP BY status;

EXPLAIN ANALYZE
SELECT status, count(*) AS cnt, sum(total) AS revenue
FROM orders@idx_orders_status
GROUP BY status
ORDER BY status;

EXPLAIN ANALYZE
SELECT region, count(*) AS cnt, sum(total) AS revenue
FROM orders
GROUP BY region;

