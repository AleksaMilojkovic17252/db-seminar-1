INSERT INTO order_items (order_id, product_id, quantity, unit_price, discount)
SELECT
    o.id,
    p.id,
    floor(random()*10+1)::INT,
    round((random()*990+10)::DECIMAL, 2),
    round((random()*20)::DECIMAL, 2)
FROM (SELECT id FROM orders ORDER BY random() LIMIT 5000000) o,
     (SELECT id FROM products ORDER BY random() LIMIT 5000000) p
LIMIT 5000000; -- Run 6 times
