EXPLAIN (VERBOSE)
SELECT * FROM orders WHERE status = 'pending' AND total > 500;

CREATE INDEX idx_orders_status ON orders (status) STORING (total);

EXPLAIN (VERBOSE)
SELECT * FROM orders WHERE status = 'pending' AND total > 500;

EXPLAIN (VERBOSE)
SELECT * FROM orders@idx_orders_status
WHERE status = 'pending' AND total > 500;

EXPLAIN (VERBOSE)
SELECT * FROM orders WHERE status = 'cancelled' AND total > 500;

EXPLAIN ANALYZE (DISTSQL)
SELECT * FROM orders WHERE status = 'pending' AND total > 500;

EXPLAIN ANALYZE (DISTSQL)
SELECT * FROM orders WHERE status = 'cancelled' AND total > 500;

EXPLAIN ANALYZE (DISTSQL)
SELECT * FROM orders@idx_orders_status
WHERE status = 'pending' AND total > 500;

EXPLAIN ANALYZE (DISTSQL)
SELECT * FROM orders@orders_pkey
WHERE status = 'pending' AND total > 500;