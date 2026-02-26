SELECT city
FROM city
WHERE country_id = (SELECT country_id
                    FROM country
                    WHERE country = 'United States')
ORDER BY city;



SELECT film_id,
       title
FROM film
WHERE film_id IN (SELECT film_id
                  FROM film_category
                           INNER JOIN category USING (category_id)
                  WHERE name = 'Action')
ORDER BY film_id;

select f.film_id, f.title
from film f
         join film_category fc on fc.film_id = f.film_id
         join category c on c.category_id = fc.category_id
WHERE c.name = 'Action'
order by f.film_id;


select count(*)
from film
where rating = 'NC-17';
select sum(length) / 210
from film
where rating = 'NC-17';
select avg(length)
from film
where rating = 'NC-17';
select avg(length)
from film
where rating = 'R';
select avg(length)
from film
where rating = 'G';
select rating, avg(length)
from film
group by rating;



CREATE TABLE employees
(
    id         SERIAL PRIMARY KEY,
    first_name VARCHAR(255)   NOT NULL,
    last_name  VARCHAR(255)   NOT NULL,
    salary     DECIMAL(10, 2) NOT NULL
);

CREATE TABLE managers
(
    id         SERIAL PRIMARY KEY,
    first_name VARCHAR(255)   NOT NULL,
    last_name  VARCHAR(255)   NOT NULL,
    salary     DECIMAL(10, 2) NOT NULL
);

INSERT INTO employees (first_name, last_name, salary)
VALUES ('Bob', 'Williams', 45000.00),
       ('Charlie', 'Davis', 55000.00),
       ('David', 'Jones', 50000.00),
       ('Emma', 'Brown', 48000.00),
       ('Frank', 'Miller', 52000.00),
       ('Grace', 'Wilson', 49000.00),
       ('Harry', 'Taylor', 53000.00),
       ('Ivy', 'Moore', 47000.00),
       ('Jack', 'Anderson', 56000.00),
       ('Kate', 'Hill', 44000.00),
       ('Liam', 'Clark', 59000.00),
       ('Mia', 'Parker', 42000.00);

INSERT INTO managers(first_name, last_name, salary)
VALUES ('John', 'Doe', 60000.00),
       ('Jane', 'Smith', 55000.00),
       ('Alice', 'Johnson', 58000.00);



SELECT *
FROM employees
WHERE salary in (SELECT salary
                 FROM managers);
SELECT *
FROM employees
WHERE salary = ANY (SELECT salary
                    FROM managers);

SELECT *
FROM employees
WHERE salary > ANY (SELECT salary
                    FROM managers);


SELECT *
FROM employees
WHERE salary > (SELECT min(salary)
                FROM managers);


SELECT *
FROM employees
WHERE salary > ALL (SELECT salary
                    FROM managers);



SELECT c.customer_id,
       first_name,
       last_name
FROM customer c
WHERE EXISTS (SELECT *
              FROM payment p
              WHERE p.customer_id = c.customer_id
                AND amount > 11)
ORDER BY first_name,
         last_name;


SELECT c.customer_id,
       first_name,
       last_name
FROM customer c
         join payment p on p.customer_id = c.customer_id
where p.amount > 11
ORDER BY c.first_name,
         c.last_name;


select (EXISTS(SELECT NULL));



-- 1. 5ta eng ko'p to'lov summasini amalga oshirgan staff ning idsiga
-- teng bo'lgan customerning id, first_name, country ni chiqaring

select p.staff_id, sum(p.amount)
from payment p
group by p.staff_id
order by sum(p.amount) desc
limit 5;


select c.customer_id, c.first_name, c3.country
from customer c
         join address a on a.address_id = c.address_id
         join city c2 on c2.city_id = a.city_id
         join country c3 on c3.country_id = c2.country_id
where c.customer_id in (select p.staff_id
                        from payment p
                        group by p.staff_id
                        order by sum(p.amount) desc
                        limit 5);

-- 2. filmning chiqarilgan yili va oxirgi o'zgartirilgan yili teng
-- bo'lganlarni chiqaring
select *
from film f
where release_year = extract(year from last_update);

select *
from film f1
where exists(select *
             from film f2
             where release_year = extract(year from last_update)
               and f1.film_id = f2.film_id);



-- 3. har bir xaridorning eng oxirgi to'lov qilgan yilidagi
-- ishlab chiqarilgan kinolarni chiqaring

-- 1) yil, film name

select customer_id, extract(year from max(payment_date))
from payment
group by customer_id;

select release_year, title
from film
where release_year in (select extract(year from max(payment_date))
                       from payment
                       group by customer_id);

-- 2) customer fullname, yil, film name
select customer_id, extract(year from max(payment_date)) last_year
from payment
group by customer_id;


select t2.customer_id, t2.fullname, t2.last_year, f.title
from (select c.first_name || ' ' || c.last_name fullname, t1.customer_id, t1.last_year
      from (select customer_id, extract(year from max(payment_date)) last_year
            from payment
            group by customer_id) as t1
               join customer c on c.customer_id = t1.customer_id) t2
         join film f on f.release_year = t2.last_year;


-- 4. nechta haridor tolov qilgan

-- 1.variant
select count(*)
from (select customer_id from payment group by customer_id) as t1;

-- 2.variant
select count(distinct customer_id)
from payment;



select actor_id as id, first_name || ' ' || last_name fullname
INTO TEMPORARY TABLE new_actor
from actor;


select actor_id as id, first_name || ' ' || last_name fullname
INTO TABLE new_actor
from actor;


select *
from new_actor;


CREATE TEMP TABLE IF NOT EXISTS  action_film
AS
SELECT
    film_id,
    title,
    release_year,
    length,
    rating
FROM
    film
INNER JOIN film_category USING (film_id)
WHERE
    category_id = 1;



SELECT
    film_id,
    title,
    release_year,
    length,
    rating
    into TEMP table action_film
FROM
    film
INNER JOIN film_category USING (film_id)
WHERE
    category_id = 1;