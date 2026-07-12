DROP INDEX IF EXISTS idx_orders_status;

EXPLAIN ANALYZE
SELECT o.id, o.total 
FROM orders o
WHERE o.customer_id = 42 AND o.status = 'shipped';

CREATE INDEX idx_orders_customer ON orders (customer_id);

EXPLAIN ANALYZE
SELECT o.id, o.total 
FROM orders o
WHERE o.customer_id = 42 AND o.status = 'shipped';

CREATE INDEX idx_orders_cust_status ON orders (customer_id, status) STORING (total);

EXPLAIN ANALYZE
SELECT o.id, o.total 
FROM orders o
WHERE o.customer_id = 42 AND o.status = 'shipped';

DROP INDEX idx_orders_cust_status;

CREATE INDEX idx_orders_shipped ON orders (customer_id) WHERE status = 'shipped';

EXPLAIN ANALYZE
SELECT o.id, o.total 
FROM orders o
WHERE o.customer_id = 42 AND o.status = 'shipped';

CREATE INDEX idx_orders_cust_status ON orders (customer_id, status) STORING (total);

EXPLAIN ANALYZE (DISTSQL)
SELECT o.id, o.total 
FROM orders@orders_pkey AS o
WHERE o.customer_id = 42 AND o.status = 'shipped';

EXPLAIN ANALYZE (DISTSQL)
SELECT o.id, o.total 
FROM orders o
WHERE o.customer_id = 42 AND o.status = 'shipped';

