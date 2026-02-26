
CREATE TABLE IF NOT EXISTS categories (
    id SERIAL PRIMARY KEY,
    category_name VARCHAR(255) NOT NULL
);

CREATE TABLE products (
    id SERIAL PRIMARY KEY,
    product_name VARCHAR(255) NOT NULL,
    description TEXT,
    price BIGINT NOT NULL,
    category_id INT NOT NULL
        REFERENCES categories(id)
        ON DELETE CASCADE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


CREATE TABLE phone_specs (
    product_id INT PRIMARY KEY
        REFERENCES products(id)
        ON DELETE CASCADE,
    memory_gb INT,
    battery_mah INT,
    camera_mp INT
);


CREATE TABLE tv_specs (
    product_id INT PRIMARY KEY
        REFERENCES products(id)
        ON DELETE CASCADE,
    screen_size_inch INT,
    resolution VARCHAR(50),
    smart_tv BOOLEAN
);


CREATE TABLE appliance_specs (
    product_id INT PRIMARY KEY
        REFERENCES products(id)
        ON DELETE CASCADE,
    power_consumption_watt INT,
    voltage INT,
    energy_class VARCHAR(10)
);

CREATE TABLE book_specs (
    product_id INT PRIMARY KEY
        REFERENCES products(id)
        ON DELETE CASCADE,
    author VARCHAR(255),
    pages INT,
    language VARCHAR(50)
);



INSERT INTO categories (category_name)
VALUES ('Smartfonlar'),
       ('Kompyuter va texnika'),
       ('Maishiy texnika'),
       ('Kiyim-kechak'),
       ('Aksessuarlar'),
       ('Bolalar mahsulotlari'),
       ('Sport va dam olish'),
       ('Kitoblar'),
       ('Qurilish va taʼmirlash');



INSERT INTO products (product_name, description, price, category_id) VALUES
('Samsung Galaxy S23', 'Flagman Android smartfon', 12000000, 1),
('iPhone 14', 'Apple flagman smartfoni', 13500000, 1),
('Xiaomi Redmi Note 13', 'O‘rtacha narxdagi kuchli telefon', 4200000, 1),
('Samsung Galaxy A54', 'Kamera va dizayn muvozanati', 5200000, 1),
('Realme 11 Pro', 'Tezkor va zamonaviy smartfon', 4800000, 1);

INSERT INTO phone_specs (product_id, memory_gb, battery_mah, camera_mp) VALUES
(1, 256, 3900, 50),
(2, 128, 3279, 48),
(3, 256, 5000, 108),
(4, 128, 5000, 50),
(5, 256, 5000, 100);



INSERT INTO products (product_name, description, price, category_id) VALUES
('Samsung 55 UHD TV', '4K Smart televizor', 7500000, 2),
('LG 50 Smart TV', 'WebOS tizimli televizor', 6800000, 2),
('Artel 43 LED TV', 'Mahalliy ishlab chiqarish', 4200000, 2),
('Sony Bravia 65', 'Premium Smart TV', 13500000, 2),
('Hisense 55 QLED', 'QLED texnologiya', 8200000, 2);


INSERT INTO tv_specs (product_id, screen_size_inch, resolution, smart_tv) VALUES
(6, 55, '4K', true),
(7, 50, '4K', true),
(8, 43, 'Full HD', true),
(9, 65, '4K', true),
(10, 55, '4K', true);





INSERT INTO products (product_name, description, price, category_id) VALUES
('Artel Muzlatgich', 'Ikki kamerali muzlatgich', 6200000, 3),
('Samsung Kir yuvish mashinasi', 'Avtomat kir yuvish mashinasi', 7200000, 3),
('LG Konditsioner', 'Inverter konditsioner', 8900000, 3),
('Bosch Changyutgich', 'Kuchli changyutgich', 2800000, 3),
('Artel Gaz plita', '4 konforkali gaz plita', 3100000, 3);




INSERT INTO appliance_specs (product_id, power_consumption_watt, voltage, energy_class) VALUES
(11, 180, 220, 'A+'),
(12, 2000, 220, 'A++'),
(13, 1500, 220, 'A++'),
(14, 1600, 220, 'A'),
(15, 0, 220, 'A');


INSERT INTO products (product_name, description, price, category_id) VALUES
('O‘tkan kunlar', 'Abdulla Qodiriy romani', 80000, 8),
('Mehrobdan chayon', 'O‘zbek klassik romani', 75000, 8),
('Atomic Habits', 'Motivatsion bestseller', 120000, 8),
('Rich Dad Poor Dad', 'Moliyaviy savodxonlik', 110000, 8),
('Python Programming', 'Dasturlash asoslari', 150000, 8);


INSERT INTO book_specs (product_id, author, pages, language) VALUES
(16, 'Abdulla Qodiriy', 320, 'O‘zbek'),
(17, 'Abdulla Qodiriy', 280, 'O‘zbek'),
(18, 'James Clear', 320, 'Ingliz'),
(19, 'Robert Kiyosaki', 336, 'Ingliz'),
(20, 'John Zelle', 552, 'Ingliz');


