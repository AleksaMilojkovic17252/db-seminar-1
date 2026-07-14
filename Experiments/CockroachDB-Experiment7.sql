DROP INDEX IF EXISTS idx_orders_customer;
DROP INDEX IF EXISTS idx_orders_cust_status;
DROP INDEX IF EXISTS idx_orders_shipped;

SHOW STATISTICS FOR TABLE orders;

INSERT INTO orders (customer_id, order_date, ship_date, status, priority, total, discount, region)
SELECT
    c.id,
    now() - (floor(random()*365)::INT * INTERVAL '1 day'),
    NULL,
    'cancelled',
    'low',
    round((random()*50)::DECIMAL, 2),
    0,
    'LATAM'
FROM (
    SELECT id FROM customers
    CROSS JOIN generate_series(1, 2)
    ORDER BY random()
    LIMIT 500000
) c;

EXPLAIN ANALYZE
SELECT * FROM orders
WHERE status = 'cancelled' AND total < 10;

ANALYZE orders;

EXPLAIN ANALYZE
SELECT * FROM orders
WHERE status = 'cancelled' AND total < 10;

CREATE STATISTICS orders_status_total
ON status, total
FROM orders;

SHOW STATISTICS FOR TABLE orders;

EXPLAIN ANALYZE
SELECT * FROM orders
WHERE status = 'cancelled' AND total < 10;

DELETE FROM orders WHERE status = 'cancelled' AND total < 50 AND region = 'LATAM';

ANALYZE orders;