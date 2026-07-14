-- 1. Clean up Experiment 1's leftover index first
DROP INDEX IF EXISTS idx_orders_status;

-- 2. Baseline, no relevant index
EXPLAIN ANALYZE (DISTSQL)
SELECT o.id, o.total 
FROM orders o
WHERE o.customer_id = 1192045607078428673 AND o.status = 'shipped';

-- 3. Single-column index, no STORING
CREATE INDEX idx_orders_customer ON orders (customer_id);

-- 4. Same query — should show index scan + join back to orders_pkey
EXPLAIN ANALYZE (DISTSQL)
SELECT o.id, o.total 
FROM orders o
WHERE o.customer_id = 1192045607078428673 AND o.status = 'shipped';

-- 5. Composite covering index
CREATE INDEX idx_orders_cust_status ON orders (customer_id, status) STORING (total);

-- 6. Same query — should collapse to a single operator, no join
EXPLAIN ANALYZE (DISTSQL)
SELECT o.id, o.total 
FROM orders o
WHERE o.customer_id = 1192045607078428673 AND o.status = 'shipped';

-- 7. Drop the covering index to isolate the partial index next
DROP INDEX idx_orders_cust_status;

-- 8. Partial index, only covers status = 'shipped'
CREATE INDEX idx_orders_shipped ON orders (customer_id) WHERE status = 'shipped';

-- 9. Same query — does the optimizer use the partial index?
EXPLAIN ANALYZE (DISTSQL)
SELECT o.id, o.total 
FROM orders o
WHERE o.customer_id = 1192045607078428673 AND o.status = 'shipped';

-- 10. Recreate the covering index alongside everything else that now exists
CREATE INDEX idx_orders_cust_status ON orders (customer_id, status) STORING (total);

-- 11. Forced full-scan counterfactual, everything else notwithstanding
EXPLAIN ANALYZE (DISTSQL)
SELECT o.id, o.total 
FROM orders@orders_pkey AS o
WHERE o.customer_id = 1192045607078428673 AND o.status = 'shipped';

-- 12. Unhinted — which of all the available indexes does the optimizer actually pick?
EXPLAIN ANALYZE (DISTSQL)
SELECT o.id, o.total 
FROM orders o
WHERE o.customer_id = 1192045607078428673 AND o.status = 'shipped';