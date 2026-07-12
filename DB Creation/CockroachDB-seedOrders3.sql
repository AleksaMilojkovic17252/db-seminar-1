INSERT INTO orders (customer_id, order_date, ship_date, status, priority, total, discount, region)
SELECT
    c.id,
    now() - (floor(random()*1095)::INT * INTERVAL '1 day'),
    CASE WHEN random() > 0.2
         THEN now() - (floor(random()*1080)::INT * INTERVAL '1 day')
         ELSE NULL END,
    (ARRAY['pending','pending','shipped','shipped','shipped',
           'delivered','delivered','delivered','delivered','cancelled'])[floor(random()*10+1)::INT],
    (ARRAY['low','normal','normal','normal','high','urgent'])[floor(random()*6+1)::INT],
    round((random()*2000+10)::DECIMAL, 2),
    round((random()*30)::DECIMAL, 2),
    (ARRAY['EMEA','EMEA','AMER','AMER','AMER','APAC','APAC','LATAM'])[floor(random()*8+1)::INT]
FROM (
    SELECT id FROM customers
    CROSS JOIN generate_series(1, 3)
    ORDER BY random()
    LIMIT 1000000
) c; -- RUN 5 TIMES