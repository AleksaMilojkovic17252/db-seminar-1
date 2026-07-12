EXPLAIN ANALYZE
SELECT c.name, p.name, oi.quantity
FROM order_items oi
JOIN reviews r     ON r.product_id = oi.product_id
JOIN products p    ON p.id = oi.product_id
JOIN orders o      ON o.id = oi.order_id
JOIN customers c   ON c.id = o.customer_id
WHERE c.country = 'RS'
AND p.category = 'Electronics'
AND r.rating >= 4;

SET reorder_joins_limit = 0;

EXPLAIN ANALYZE
SELECT c.name, p.name, oi.quantity
FROM order_items oi
JOIN reviews r     ON r.product_id = oi.product_id
JOIN products p    ON p.id = oi.product_id
JOIN orders o      ON o.id = oi.order_id
JOIN customers c   ON c.id = o.customer_id
WHERE c.country = 'RS'
AND p.category = 'Electronics'
AND r.rating >= 4;

SET reorder_joins_limit = 8;

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
