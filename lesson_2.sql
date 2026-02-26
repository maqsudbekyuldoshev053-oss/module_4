CREATE TABLE IF NOT EXISTS stock_availability
(
    product_id SERIAL PRIMARY KEY,
    available  BOOLEAN NOT NULL,
    price      INTEGER DEFAULT 500
);

DROP TABLE IF EXISTS stock_availability;

INSERT INTO stock_availability(available)
VALUES (true);
INSERT INTO stock_availability
VALUES ('1');
INSERT INTO stock_availability
VALUES ('1', 250);

-- normalization

CREATE TABLE IF NOT EXISTS megamix
(
    id                UUID PRIMARY KEY,
    first_name        VARCHAR(255),
    last_name         VARCHAR,
    address           TEXT,
    birth_date        DATE CHECK ( extract(YEAR FROM birth_date) > extract(YEAR FROM now()) - 100 ),
    start_lesson_time TIME,
    period            INTERVAL,
    data              jsonb,
    scores            INTEGER[],
    updated_at        TIMESTAMPTZ        DEFAULT now(),
    created_at        TIMESTAMP NOT NULL DEFAULT now()
);

-- pg_restore -U postgres -d dvdrental D:\sampledb\postgres\dvdrental.tar
-- pg_restore -d dvdrental dvdrental.tar

select extract(YEAR FROM birth_date) > extract(YEAR FROM now()) - 100
from megamix;

SELECT gen_random_uuid();

-- UTC +5
INSERT INTO megamix(id, birth_date, period)
VALUES (gen_random_uuid(), '1927-10-18', '3 days');

DROP TABLE IF EXISTS megamix;

SELECT now();
SELECT length('valijon');

DROP TABLE edu_center;

CREATE TABLE IF NOT EXISTS edu_center
(
    id   SERIAL PRIMARY KEY,
    name VARCHAR(55) NOT NULL
);


CREATE TABLE IF NOT EXISTS students
(
    id         SERIAL PRIMARY KEY,
    first_name varchar(255) not null
);

CREATE TABLE IF NOT EXISTS edu_center_students
(
    id            SERIAL PRIMARY KEY,
    edu_center_id INTEGER NOT NULL REFERENCES edu_center (id),
    student_id    INTEGER NOT NULL REFERENCES students (id),
    unique (edu_center_id, student_id)
);


insert into edu_center(name, type)
VALUES ('Pdp center', 'zor');
insert into edu_center(name, type)
VALUES ('markaz', '1');



CREATE TABLE IF NOT EXISTS students
(
    first_name      varchar(255) not null,
    passport_number INTEGER      not null unique,
    passport_series varchar(2)   not null unique,
    unique (passport_number, passport_series)
);

-- AA1251515 botir
-- AB1251525 shokir

--01 A200AA
--10 A200AA
--20 A200AA

DROP TABLE IF EXISTS students;


-- SELECT * FROM edu_center WHERE name ILIKE '%pdp%';
-- 'center' in name   =  name like '%center%'
-- name.startswith('center')   =  name like 'center%'
-- name.endswith('center')   =  name like '%center'

-- time, datetime, date
-- 30
-- 3

-- id, slug, uuid
-- 2500

CREATE TABLE IF NOT EXISTS category
(
    id   SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);

INSERT INTO category
VALUES (1, 'Texnika'),
       (2, 'Qurilish');

DROP TABLE category;
DROP TABLE products;


CREATE TABLE IF NOT EXISTS products
(
    id          SERIAL PRIMARY KEY,
    name        VARCHAR(255) NOT NULL,
    price       INTEGER      NOT NULL CHECK ( price > 0 ),
    category_id INTEGER      NOT NULL REFERENCES category (id) ON DELETE CASCADE
);



INSERT INTO products
VALUES (2, 'SAMSUNG', 2_500_000, 1);




select * from actor where first_name ilike '%n' limit 5;
