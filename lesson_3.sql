select count(*)
from actor;
select count(*)
from country;


select *
from payment
order by payment_id desc
limit 5;
select max(amount)
from payment;
select min(amount)
from payment;
select avg(amount)
from payment;
select count(*)
from payment;

select *
from payment
where 5 <= amount
  and amount <= 10;

select *
from payment
where amount not between 5 and 1

select *
from payment
where amount between 5 and 10;


select *
from actor
where first_name like '%a'; -- first_name.endswith('a')
select *
from actor
where first_name like 'a%'; -- first_name.startswith('a')
select *
from actor
where first_name like '%a%'; -- 'a' in first_name

select *
from actor
where first_name LIKE '%10$%%' ESCAPE '$'; -- 'a' in first_name
select *
from actor
where first_name LIKE '%10|%%' ESCAPE '|'; -- 'a' in first_name

SELECT null = null;


UPDATE actor
SET first_name = 'Adam'
WHERE actor_id = 13;


select *
from actor
where first_name not ilike '%a'
  and actor_id = 13;

-- aggregate function
-- min, max, sum, count, avg

select now();
select gen_random_uuid();
select length('hello');


select *
from actor
where length(first_name) <= 4
order by length(first_name) desc, length(last_name) desc, actor_id;


select count(distinct first_name)
from actor;

select first_name, count(actor_id)
from actor
group by first_name
having count(actor_id) = 1
order by length(first_name);


select customer_id, sum(amount)
from payment
group by customer_id;

select count(*)
from actor;

-- Homework
-- https://neon.com/postgresql/tutorial#section-4-grouping-data
-- https://neon.com/postgresql/tutorial#section-3-joining-multiple-tables
-- https://neon.com/postgresql/tutorial#section-13-postgresql-constraints


-- relationship

-- 1-1 ✅
-- 1-n ✅
-- n-1 ✅
-- n-n

-- n-1


CREATE TABLE IF NOT EXISTS test_category
(
    id   SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);

INSERT INTO test_category(name)
VALUES ('Texnika'),
       ('Uy-joy');

CREATE TABLE IF NOT EXISTS test_product
(
    id          SERIAL PRIMARY KEY,
    name        VARCHAR(255) NOT NULL,
    price       DECIMAL,
    category_id INTEGER      NOT NULL,
    CONSTRAINT fk_category_id_test_category
        FOREIGN KEY (category_id)
            REFERENCES test_category (id)

);

drop table test_product;

create table students
(
    id   SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);

create table courses
(
    id   SERIAL PRIMARY KEY,
    name VARCHAR(255) DEFAULT 'VALIjon'
);

create table student_courses
(
    id         SERIAL PRIMARY KEY,
    student_id INTEGER NOT NULL REFERENCES students (id),
    course_id  INTEGER NOT NULL REFERENCES courses (name)
);


-- uk
-- pk
-- fk

select s1.*, s2.first_name
from store s1
         join staff s2 on s2.staff_id = s1.manager_staff_id;



select address, district, city, country
from address
         join city on city.city_id = address.city_id
         join country on country.country_id = city.country_id;