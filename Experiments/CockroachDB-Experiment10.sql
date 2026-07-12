EXPLAIN analyze (DISTSQL)
SELECT
    region,
    sum(total) AS region_revenue,
    count(*) AS order_count
FROM orders
GROUP BY region
ORDER BY region_revenue DESC;

EXPLAIN analyze (DISTSQL)
SELECT DISTINCT
    region,
    sum(total) OVER (PARTITION BY region) AS region_revenue,
    count(*) OVER (PARTITION BY region) AS order_count
FROM orders
ORDER BY region_revenue DESC;

EXPLAIN analyze (DISTSQL)
SELECT
    id,
    customer_id,
    total,
    order_date,
    region,
    sum(total) OVER (PARTITION BY region) AS region_total,
    rank() OVER (PARTITION BY region ORDER BY total DESC) AS rank_in_region,
    sum(total) OVER (PARTITION BY customer_id ORDER BY order_date
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS running_customer_total
FROM orders
WHERE region = 'EMEA'
LIMIT 100;