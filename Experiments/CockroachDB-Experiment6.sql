EXPLAIN ANALYZE (DISTSQL)
SELECT * FROM orders@idx_orders_customer
WHERE status = 'pending';

EXPLAIN ANALYZE (DISTSQL)
SELECT * FROM orders
WHERE status = 'pending';

SET disallow_full_table_scans = true;

EXPLAIN ANALYZE (DISTSQL)
SELECT * FROM orders
WHERE status = 'pending';

EXPLAIN ANALYZE (DISTSQL)
SELECT * FROM orders WHERE total > 100;

SET disallow_full_table_scans = false;

SET optimizer_use_histograms = false;

EXPLAIN analyze (DISTSQL)
SELECT c.name FROM customers c
JOIN orders o ON c.id = o.customer_id
WHERE c.country = 'RS';

SET optimizer_use_histograms = true;

EXPLAIN analyze (DISTSQL)
SELECT c.name FROM customers c
JOIN orders o ON c.id = o.customer_id
WHERE c.country = 'RS';