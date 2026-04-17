CREATE TABLE products (
    id SERIAL PRIMARY KEY,
    name VARCHAR(200) NOT NULL,
    description TEXT,
    full_description TEXT,
    price DECIMAL(10, 2) NOT NULL,
    unit VARCHAR(50) DEFAULT '250g',
    origin VARCHAR(100),
    region VARCHAR(100),
    altitude VARCHAR(50),
    process VARCHAR(100),
    roast VARCHAR(50),
    taste VARCHAR(200),
    rating DECIMAL(3, 1) DEFAULT 4.5,
    reviews INTEGER DEFAULT 0,
    badge VARCHAR(50),
    image_url TEXT,
    is_best_seller BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Создаем таблицу заказов
CREATE TABLE orders (
    id SERIAL PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    customer_email VARCHAR(100),
    customer_phone VARCHAR(20),
    customer_address TEXT,
    total_amount DECIMAL(10, 2) NOT NULL,
    status VARCHAR(50) DEFAULT 'pending',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Создаем таблицу элементов заказа
CREATE TABLE order_items (
    id SERIAL PRIMARY KEY,
    order_id INTEGER REFERENCES orders(id) ON DELETE CASCADE,
    product_id INTEGER REFERENCES products(id),
    product_name VARCHAR(200),
    quantity INTEGER NOT NULL,
    price DECIMAL(10, 2) NOT NULL
);

-- Добавляем индексы
CREATE INDEX idx_products_origin ON products(origin);
CREATE INDEX idx_products_roast ON products(roast);
CREATE INDEX idx_products_is_best_seller ON products(is_best_seller);

-- Добавляем тестовые данные
INSERT INTO products (name, description, price, origin, roast, unit, rating, reviews, image_url, is_best_seller) VALUES
('Эфиопский Yirgacheffe', 'Яркие цитрусовые ноты с цветочным ароматом жасмина', 850, 'Эфиопия', 'Средняя', '250г', 4.7, 124, 'https://coffee-static.storage.yandexcloud.net/files/shares/data/product/1767110847.567-ethiopia-irgacheff-250-full.webp', true),
('Колумбийский Supremo', 'Сбалансированный вкус с ореховыми и карамельными нотами', 720, 'Колумбия', 'Средняя', '250г', 4.3, 89, 'https://ir.ozone.ru/s3/multimedia-1-8/w1200/6933475052.jpg', true),
('Бразильский Santos', 'Мягкий вкус с нотками шоколада и орехов', 680, 'Бразилия', 'Средняя', '250г', 4.2, 76, 'https://ir.ozone.ru/s3/multimedia-u/w1200/6597375042.jpg', false),
('Кенийский AA', 'Яркая кислотность с нотами ягод и цитрусов', 980, 'Кения', 'Светлая', '250г', 4.9, 67, 'https://basket-05.wbbasket.ru/vol980/part98035/98035627/images/big/1.webp', false),
('Гватемала Antigua', 'Шоколадные ноты с легкой пряностью', 890, 'Гватемала', 'Средняя', '250г', 4.5, 53, 'https://sibaristica.com/upload/resize_cache/iblock/053/540_560_1/ndtw8bm856px227zp45stfxi5n7jnkxp.jpg', false);