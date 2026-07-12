INSERT INTO customers (name, email, country, city, age, segment, created_at)
SELECT
    'customer_' || g::STRING,
    'c' || g::STRING || '@example.com',
    (ARRAY[
        'RS','RS','RS','RS',
        'US','US','US',
        'DE','DE',
        'JP','FR','GB','AU','CA','BR','IN','CN','MX','IT','ES'
    ])[floor(random()*20+1)::INT],
    (ARRAY[
        'Belgrade','Novi Sad','Nis','Kragujevac',
        'New York','Los Angeles','Chicago','Houston',
        'Berlin','Munich','Hamburg',
        'Tokyo','Osaka','Kyoto',
        'Paris','London','Sydney','Toronto',
        'São Paulo','Mumbai','Shanghai'
    ])[floor(random()*21+1)::INT],
    floor(random()*52+18)::INT,
    (ARRAY['retail','retail','retail','wholesale','wholesale','vip','new'])[floor(random()*7+1)::INT],
    now() - (floor(random()*1825)::INT * INTERVAL '1 day')
FROM generate_series(1, 500000) AS g;

SELECT count(*) FROM customers;
