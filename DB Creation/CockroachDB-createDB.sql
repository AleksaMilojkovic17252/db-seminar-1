CREATE TABLE customers (
    id         INT PRIMARY KEY DEFAULT unique_rowid(),
    name       STRING NOT NULL,
    email      STRING NOT NULL,
    country    STRING NOT NULL,
    city       STRING NOT NULL,
    age        INT NOT NULL,
    segment    STRING NOT NULL,
    created_at TIMESTAMPTZ DEFAULT now()
);
 
CREATE TABLE products (
    id          INT PRIMARY KEY DEFAULT unique_rowid(),
    name        STRING NOT NULL,
    category    STRING NOT NULL,
    subcategory STRING NOT NULL,
    price       DECIMAL(10,2) NOT NULL,
    cost        DECIMAL(10,2) NOT NULL,
    stock       INT NOT NULL DEFAULT 0,
    rating      DECIMAL(3,2) DEFAULT 0.00,
    active      BOOL DEFAULT true
);
 
CREATE TABLE orders (
    id          INT PRIMARY KEY DEFAULT unique_rowid(),
    customer_id INT NOT NULL REFERENCES customers(id),
    order_date  TIMESTAMPTZ DEFAULT now(),
    ship_date   TIMESTAMPTZ,
    status      STRING NOT NULL DEFAULT 'pending',
    priority    STRING NOT NULL DEFAULT 'normal',
    total       DECIMAL(12,2),
    discount    DECIMAL(5,2) DEFAULT 0.00,
    region      STRING NOT NULL
);
 
CREATE TABLE order_items (
    id         INT PRIMARY KEY DEFAULT unique_rowid(),
    order_id   INT NOT NULL REFERENCES orders(id),
    product_id INT NOT NULL REFERENCES products(id),
    quantity   INT NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    discount   DECIMAL(5,2) DEFAULT 0.00
);
 
CREATE TABLE reviews (
    id          INT PRIMARY KEY DEFAULT unique_rowid(),
    product_id  INT NOT NULL REFERENCES products(id),
    customer_id INT NOT NULL REFERENCES customers(id),
    rating      INT NOT NULL CHECK (rating BETWEEN 1 AND 5),
    helpful_votes INT NOT NULL DEFAULT 0,
    body        STRING,
    verified    BOOL DEFAULT false,
    created_at  TIMESTAMPTZ DEFAULT now()
);
