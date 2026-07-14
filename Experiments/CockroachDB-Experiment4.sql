-- 1. Default (optimizer's own join order) — logical plan, cheap check
EXPLAIN (VERBOSE)
SELECT c.name, p.name, oi.quantity
FROM order_items oi
JOIN reviews r     ON r.product_id = oi.product_id
JOIN products p    ON p.id = oi.product_id
JOIN orders o      ON o.id = oi.order_id
JOIN customers c   ON c.id = o.customer_id
WHERE c.country = 'RS'
AND p.category = 'Electronics'
AND r.rating >= 4;

-- 2. Disable join reordering
SET reorder_joins_limit = 0;

-- 3. Naive, textual-order join — logical plan, cheap check before running it for real
EXPLAIN (VERBOSE)
SELECT c.name, p.name, oi.quantity
FROM order_items oi
JOIN reviews r     ON r.product_id = oi.product_id
JOIN products p    ON p.id = oi.product_id
JOIN orders o      ON o.id = oi.order_id
JOIN customers c   ON c.id = o.customer_id
WHERE c.country = 'RS'
AND p.category = 'Electronics'
AND r.rating >= 4;

-- 4. Naive join order, timed, with diagram
EXPLAIN ANALYZE (DISTSQL)
SELECT c.name, p.name, oi.quantity
FROM order_items oi
JOIN reviews r     ON r.product_id = oi.product_id
JOIN products p    ON p.id = oi.product_id
JOIN orders o      ON o.id = oi.order_id
JOIN customers c   ON c.id = o.customer_id
WHERE c.country = 'RS'
AND p.category = 'Electronics'
AND r.rating >= 4;

-- 5. Restore default reordering behavior
SET reorder_joins_limit = 8;

-- 6. Default (optimizer's own join order), timed, with diagram
EXPLAIN ANALYZE (DISTSQL)
SELECT c.name, p.name, oi.quantity
FROM order_items oi
JOIN reviews r     ON r.product_id = oi.product_id
JOIN products p    ON p.id = oi.product_id
JOIN orders o      ON o.id = oi.order_id
JOIN customers c   ON c.id = o.customer_id
WHERE c.country = 'RS'
AND p.category = 'Electronics'
AND r.rating >= 4;