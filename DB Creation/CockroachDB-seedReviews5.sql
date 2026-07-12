INSERT INTO reviews (product_id, customer_id, rating, helpful_votes, body, verified, created_at)
SELECT
    p.id,
    c.id,
    floor(random()*5+1)::INT,
    floor(random()*100)::INT,
    'review_body_' || row_number() OVER (),
    (random() > 0.3),
    now() - (floor(random()*730)::INT * INTERVAL '1 day')
FROM (SELECT id FROM products ORDER BY random() LIMIT 2000000) p,
     (SELECT id FROM customers ORDER BY random() LIMIT 2000000) c
LIMIT 2000000;
