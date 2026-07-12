EXPLAIN ANALYZE
SELECT
    status,
    count(*) AS order_count,
    sum(total) AS revenue,
    avg(total) AS avg_order
FROM orders
WHERE order_date >= now() - INTERVAL '1 year'
GROUP BY status
ORDER BY status;

SET optimizer_use_histograms = false;
SET reorder_joins_limit = 0;

EXPLAIN ANALYZE
SELECT
    status,
    count(*) AS order_count,
    sum(total) AS revenue,
    avg(total) AS avg_order
FROM orders
WHERE order_date >= now() - INTERVAL '1 year'
GROUP BY status
ORDER BY status;

SET optimizer_use_histograms = true;
SET reorder_joins_limit = 8;

---

EXPLAIN ANALYZE
SELECT c.name, c.country,
       (SELECT count(*) FROM orders o WHERE o.customer_id = c.id) AS order_count
FROM customers c
WHERE c.country = 'RS'
ORDER BY order_count DESC
LIMIT 10;

SET optimizer_use_histograms = false;
SET reorder_joins_limit = 0;

EXPLAIN ANALYZE
SELECT c.name, c.country,
       (SELECT count(*) FROM orders o WHERE o.customer_id = c.id) AS order_count
FROM customers c
WHERE c.country = 'RS'
ORDER BY order_count DESC
LIMIT 10;

SET optimizer_use_histograms = true;
SET reorder_joins_limit = 8;

---

EXPLAIN ANALYZE
SELECT
    o.order_date,
    c.country,
    p.category,
    sum(oi.quantity * oi.unit_price) AS revenue
FROM order_items oi
JOIN orders o      ON o.id = oi.order_id
JOIN customers c   ON c.id = o.customer_id
JOIN products p    ON p.id = oi.product_id
WHERE o.order_date >= now() - INTERVAL '6 months'
AND c.country = 'RS'
AND p.category = 'Electronics'
GROUP BY o.order_date, c.country, p.category
ORDER BY revenue DESC
LIMIT 10;

-- Q3 Crippled
SET optimizer_use_histograms = false;
SET reorder_joins_limit = 0;

EXPLAIN ANALYZE
SELECT
    o.order_date,
    c.country,
    p.category,
    sum(oi.quantity * oi.unit_price) AS revenue
FROM order_items oi
JOIN orders o      ON o.id = oi.order_id
JOIN customers c   ON c.id = o.customer_id
JOIN products p    ON p.id = oi.product_id
WHERE o.order_date >= now() - INTERVAL '6 months'
AND c.country = 'RS'
AND p.category = 'Electronics'
GROUP BY o.order_date, c.country, p.category
ORDER BY revenue DESC
LIMIT 10;

-- Restore
SET optimizer_use_histograms = true;
SET reorder_joins_limit = 8;

---

EXPLAIN ANALYZE
SELECT p.name, p.category, p.price
FROM products p
WHERE EXISTS (
    SELECT 1 FROM order_items oi
    JOIN orders o ON o.id = oi.order_id
    WHERE oi.product_id = p.id
    AND o.status = 'delivered'
    AND o.order_date >= now() - INTERVAL '6 months'
)
AND p.category = 'Electronics'
ORDER BY p.price DESC;

-- Q4 Crippled
SET optimizer_use_histograms = false;
SET reorder_joins_limit = 0;

EXPLAIN ANALYZE
SELECT p.name, p.category, p.price
FROM products p
WHERE EXISTS (
    SELECT 1 FROM order_items oi
    JOIN orders o ON o.id = oi.order_id
    WHERE oi.product_id = p.id
    AND o.status = 'delivered'
    AND o.order_date >= now() - INTERVAL '6 months'
)
AND p.category = 'Electronics'
ORDER BY p.price DESC;

-- Restore
SET optimizer_use_histograms = true;
SET reorder_joins_limit = 8;
