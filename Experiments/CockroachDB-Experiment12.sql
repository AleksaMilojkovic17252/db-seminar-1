EXPLAIN ANALYZE
SELECT id, name, country, segment
FROM customers
WHERE lower(name) = 'customer_42';

CREATE INDEX idx_customers_lower_name ON customers (lower(name));

EXPLAIN ANALYZE
SELECT id, name, country, segment
FROM customers
WHERE lower(name) = 'customer_42';

CREATE INDEX idx_customers_upper_segment ON customers (upper(segment));

ANALYZE customers;

EXPLAIN ANALYZE
SELECT id, name, country
FROM customers
WHERE upper(segment) = 'VIP';

CREATE INDEX idx_orders_total_rounded ON orders (round(total, -2));

EXPLAIN ANALYZE
SELECT count(*), sum(total)
FROM orders
WHERE round(total, -2) = 1000;

EXPLAIN ANALYZE
SELECT count(*), sum(total)
FROM orders@orders_pkey
WHERE round(total, -2) = 1000;