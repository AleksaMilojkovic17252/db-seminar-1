SHOW INDEX FROM orders;

SET CLUSTER SETTING sql.distsql.temp_storage.workmem = '4MiB';

EXPLAIN ANALYZE (DISTSQL)
SELECT customer_id, count(*) AS order_count, sum(total) AS total_spent
FROM orders
GROUP BY customer_id;

CREATE INDEX idx_orders_customer ON orders (customer_id) STORING (total);

EXPLAIN ANALYZE (DISTSQL)
SELECT customer_id, count(*) AS order_count, sum(total) AS total_spent
FROM orders
GROUP BY customer_id;

RESET CLUSTER SETTING sql.distsql.temp_storage.workmem;
