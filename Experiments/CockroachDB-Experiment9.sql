SET vectorize = on;

EXPLAIN ANALYZE
SELECT
    region,
    status,
    count(*) AS orders,
    sum(total) AS revenue,
    avg(total) AS avg_order,
    max(total) AS max_order,
    min(total) AS min_order
FROM orders
GROUP BY region, status
ORDER BY region, status;

SET vectorize = off;

EXPLAIN ANALYZE
SELECT
    region,
    status,
    count(*) AS orders,
    sum(total) AS revenue,
    avg(total) AS avg_order,
    max(total) AS max_order,
    min(total) AS min_order
FROM orders
GROUP BY region, status
ORDER BY region, status;

SET vectorize = on;

EXPLAIN ANALYZE (DISTSQL)
SELECT
    p.category,
    count(*) AS items_sold,
    sum(oi.quantity * oi.unit_price) AS gross_revenue,
    sum(oi.quantity * oi.unit_price * (1 - oi.discount/100)) AS net_revenue,
    avg(oi.quantity) AS avg_qty,
    max(oi.unit_price) AS max_price
FROM order_items oi
JOIN products p ON p.id = oi.product_id
GROUP BY p.category
ORDER BY gross_revenue DESC;

SET vectorize = off;

EXPLAIN ANALYZE (DISTSQL)
SELECT
    p.category,
    count(*) AS items_sold,
    sum(oi.quantity * oi.unit_price) AS gross_revenue,
    sum(oi.quantity * oi.unit_price * (1 - oi.discount/100)) AS net_revenue,
    avg(oi.quantity) AS avg_qty,
    max(oi.unit_price) AS max_price
FROM order_items oi
JOIN products p ON p.id = oi.product_id
GROUP BY p.category
ORDER BY gross_revenue DESC;

SET vectorize = on;