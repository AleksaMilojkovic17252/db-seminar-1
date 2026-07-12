INSERT INTO products (name, category, subcategory, price, cost, stock, rating, active)
SELECT
    'product_' || g::STRING,
    COALESCE((ARRAY['Electronics','Electronics','Electronics',
           'Clothing','Clothing','Books','Books','Food','Food',
           'Sports','Sports','Toys','Tools','Beauty',
           'Furniture','Automotive'])[floor(random()*16+1)::INT], 'Electronics'),
    COALESCE((ARRAY['Smartphones','Laptops','Cameras','Headphones','TVs',
           'Shirts','Pants','Shoes','Jackets','Fiction','Non-Fiction',
           'Technical','Educational','Snacks','Beverages','Organic',
           'Fitness','Outdoor','Team Sports','Board Games','Action Figures',
           'Hand Tools','Power Tools','Skincare','Makeup',
           'Sofas','Tables','Parts','Accessories'])[floor(random()*30+1)::INT], 'General'),
    round((random()*990+10)::DECIMAL, 2),
    round((random()*500+5)::DECIMAL, 2),
    floor(random()*1000)::INT,
    round((random()*4+1)::DECIMAL, 2),
    (random() > 0.05)
FROM generate_series(1, 50000) AS g;

SELECT count(*) FROM products'