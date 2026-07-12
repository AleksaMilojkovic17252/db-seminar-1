EXPLAIN (VERBOSE)
SELECT c.id, c.name, c.country
FROM customers c
WHERE NOT EXISTS (
    SELECT 1 FROM orders o
    WHERE o.customer_id = c.id
);

EXPLAIN (VERBOSE)
SELECT c.id, c.name, c.country
FROM customers c
WHERE c.id NOT IN (
    SELECT o.customer_id FROM orders o
);

SELECT count(*) FROM orders WHERE customer_id IS NULL;

SELECT count(*) FROM reviews WHERE helpful_votes IS NULL;

SELECT count(*) FROM products p
WHERE NOT EXISTS (
    SELECT 1 FROM reviews r
    WHERE r.product_id = p.id
    AND r.helpful_votes > 50
);

SELECT count(*) FROM products p
WHERE p.id NOT IN (
    SELECT r.product_id FROM reviews r
    WHERE r.helpful_votes > 50
);

-- Add a nullable score column
ALTER TABLE reviews ADD COLUMN score INT DEFAULT NULL;

-- Set some scores, deliberately leave some NULL
UPDATE reviews SET score = rating * 20 WHERE rating >= 3;
-- Rows with rating < 3 will have NULL score

-- Verify NULLs exist
SELECT count(*) FROM reviews WHERE score IS NULL;

-- NOT EXISTS (safe with NULLs)
SELECT count(*) FROM products p
WHERE NOT EXISTS (
    SELECT 1 FROM reviews r
    WHERE r.product_id = p.id
    AND r.score > 80
);

-- NOT IN (dangerous! NULLs in subquery cause zero results)
SELECT count(*) FROM products p
WHERE p.id NOT IN (
    SELECT r.product_id FROM reviews r
    WHERE r.score > 80
);


-----------------

CREATE TABLE test_null_trap (
    product_id INT,
    notes STRING
);

INSERT INTO test_null_trap VALUES
    (1, 'review a'),
    (2, 'review b'),
    (NULL, 'review with null product'); 

SELECT p.id FROM products p
WHERE p.id IN (1,2,3,4,5)
AND NOT EXISTS (
    SELECT 1 FROM test_null_trap t WHERE t.product_id = p.id
);

SELECT p.id FROM products p
WHERE p.id IN (1,2,3,4,5)
AND p.id NOT IN (
    SELECT t.product_id FROM test_null_trap t
);

SELECT id FROM products LIMIT 5;

DELETE FROM test_null_trap;

INSERT INTO test_null_trap VALUES
    (1189778647688642561, 'review a'),
    (1189778647688871937, 'review b'),
    (NULL, 'review with null product');

SELECT p.id FROM products p
WHERE p.id IN (
    1189778647688642561,
    1189778647688871937,
    1189778647688904705,
    1189778647688937473,
    1189778647688970241
)
AND NOT EXISTS (
    SELECT 1 FROM test_null_trap t WHERE t.product_id = p.id
);

SELECT p.id FROM products p
WHERE p.id IN (
    1189778647688642561,
    1189778647688871937,
    1189778647688904705,
    1189778647688937473,
    1189778647688970241
)
AND p.id NOT IN (
    SELECT t.product_id FROM test_null_trap t
);

EXPLAIN (VERBOSE)
SELECT p.id FROM products p
WHERE p.id IN (
    1189778647688642561,
    1189778647688871937,
    1189778647688904705,
    1189778647688937473,
    1189778647688970241
)
AND NOT EXISTS (
    SELECT 1 FROM test_null_trap t WHERE t.product_id = p.id
);

EXPLAIN (VERBOSE)
SELECT p.id FROM products p
WHERE p.id IN (
    1189778647688642561,
    1189778647688871937,
    1189778647688904705,
    1189778647688937473,
    1189778647688970241
)
AND p.id NOT IN (
    SELECT t.product_id FROM test_null_trap t
);

DROP TABLE test_null_trap;
ALTER TABLE reviews DROP COLUMN score;

