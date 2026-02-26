create table new_actor as table actor with no data;

create table new_actor_1 as table actor;
CREATE TABLE new_table_name_2 AS
select first_name || ' ' || last_name
from actor with no data;



drop table new_actor_2;

select actor.actor_id, f.*
into new_actor_2
from actor
         join public.film_actor fa on actor.actor_id = fa.actor_id
         join public.film f on fa.film_id = f.film_id;



WITH action_films AS (SELECT f.title,
                             f.length
                      FROM film f
                               INNER JOIN film_category fc USING (film_id)
                               INNER JOIN category c USING (category_id)
                      WHERE c.name = 'Action'),
     valijon_query as (select *
                       from actor)
SELECT *
FROM actor;



select *
from customer
where first_name ilike 'a%a';

UPDATE payment p
SET payment_date = now()
FROM customer c
WHERE c.customer_id = p.customer_id
  and first_name ilike 'a%a';



-- -- alter table custom_users alter column name rename to first_name;
-- alter table custom_users
--     rename name to first_name;
--
-- alter table custom_users
--     drop column category_id;
--
-- alter table custom_users
--     add column id serial primary key;
--
-- insert into custom_users(first_name, balance)
-- values ('botir', 500_000),
--        ('g''ayrat', 100_000);


-- botir -> gayrat 50,000

-- BEGIN;
--
-- update custom_users
-- set balance = balance - 50_000
-- where id = 1; -- botir
-- update custom_users
-- set balance = balance + 50_000
-- where id = 2; -- gayrat
--
-- SAVEPOINT v1;
--
-- update custom_users
-- set balance = balance - 50_000
-- where id = 1; -- botir
--
-- SAVEPOINT v2;
--
-- ROLLBACK to v1;
--
-- update custom_users
-- set balance = balance - 50_000
-- where id = 1; -- botir
--
-- COMMIT;


-- PL/pgsql

--------------------------------------------------
-- 1. bazadagi eng oxirgi yildagi category ga tegishli bo'lgan
-- kinolar soni nechta

-- tarixiy 15

SELECT c.name, COUNT(f.film_id)
FROM film f
         JOIN film_category fc ON f.film_id = fc.film_id
         JOIN category c on fc.category_id = c.category_id
WHERE EXTRACT(YEAR FROM c.last_update) = (select max(extract(YEAR FROM last_update))
                                          FROM category)
GROUP BY c.name;

---------------------------------------
-- 2. qaysi store da nechtadan film borligini aniqlang


SELECT i.store_id,
       COUNT(DISTINCT film_id)
FROM inventory i
GROUP BY store_id;


------------------------------------------------
-- 3. category ni o'zgartirilgan yili bilan kinoning o'zgartirilgani yili teng bo'lganlarni chiqaring
-- tarixiy titanic

SELECT c.name, f.title
FROM category c
         JOIN film_category fc on fc.category_id = c.category_id
         JOIN film f on f.film_id = fc.film_id
WHERE extract(YEAR FROM c.last_update) = extract(YEAR FROM f.last_update);

----------------------------------------------------------

-- 4. tushib qolgan idlarni toping
--   1- 4500 maksimal idgacha
--   2- oxirgi sequence gacha bolgani

---------------------------------------------------------
-- 5. duplicate bo'lgan transaction topish kerak
-- (1minut ichida qayta transaction bolganlar, card_number, user_id, amount, type teng bolganlar lekin idlar har hil)


SELECT *
FROM transactions t1
         JOIN transactions t2
              ON t1.card_number = t2.card_number AND t1.user_id = t2.user_id AND t1.amount = t2.amount AND
                 t1.type = t2.type AND t1.created_at BETWEEN t2.created_at - INTERVAL '1 minute'
                     AND t2.created_at + INTERVAL '1 minute'
ORDER BY t1.card_number, t2.created_at;

----------------------------------------------------------
-- 🔟 Category bo‘yicha kinolar soni 15 tadan ko‘p bo‘lganlarini chiqarish

select c.name, count(f.film_id)
from category c
         join film_category fc on c.category_id = fc.category_id
         join film f on fc.film_id = f.film_id
group by c.name
having count(f.film_id) > 15
order by count(f.film_id);

-------------------------------------------------------------


-- JOIN natijasiga asoslanib ALTER TABLE mashqi
-- Shart:
-- film jadvaliga yangi ustun qo‘shing
-- release_year’ni text ko‘rinishida saqlash


create table new_film as table film with no data; -- film tabledan  nusxa oldi lekin ichidagi mau'lumotlarsiz

ALTER TABLE new_film
    ADD COLUMN count INTEGER;

ALTER TABLE new_film
    ALTER COLUMN release_year TYPE TEXT;

--------------------------------------------

--  category’dagi Action kinolar soni
-- store’lar bo‘yicha

-- Shart:
-- store
-- inventory
-- film
-- category

SELECT s.store_id, c.name, count(f.film_id)
FROM store s
         JOIN inventory i ON i.store_id = s.store_id
         JOIN film f ON i.film_id = f.film_id
         JOIN film_category fc ON f.film_id = fc.film_id
         JOIN category c ON fc.category_id = c.category_id
WHERE name = 'Action'
GROUP BY s.store_id, c.name;

---------------------------------------------------
-- Category bo‘yicha kinolar soni 20 tadan ko‘p bo‘lganlarini chiqaring

SELECT c.name, count(f.film_id)
FROM category c
         JOIN film_category fc ON c.category_id = fc.category_id
         JOIN film f ON fc.film_id = f.film_id
GROUP BY c.name
HAVING count(f.film_id) > 20
ORDER BY count(f.film_id);


------------------------------------------


-- Comedy category’dagi kinolar sonini

SELECT c.name, count(f.film_id)
FROM category c
         JOIN film_category fc ON c.category_id = fc.category_id
         JOIN film f ON fc.film_id = f.film_id
WHERE name = 'Comedy'
GROUP BY c.name;


----------------------------------------------


-- Film o‘zgartirilgan yili bilan
-- category o‘zgartirilgan yili teng bo‘lgan kinolarni chiqaring
-- Shartlar:
-- film.last_update
-- category.last_update
-- yil bo‘yicha solishtirish
-- JOIN


SELECT f.title, f.last_update, c.last_update
FROM category c
         JOIN film_category fc ON c.category_id = fc.category_id
         JOIN film f ON fc.film_id = f.film_id
WHERE extract(YEAR FROM f.last_update) = extract(YEAR FROM c.last_update);

----------------------------------------------------------------------


-- Category’si yo‘q bo‘lgan kinolarni toping
-- Shartlar:
-- film
-- film_category
-- LEFT JOIN
-- NULL tekshiruvi

SELECT f.title, fc.category_id
FROM film f
         LEFT JOIN film_category fc ON f.film_id = fc.film_id
WHERE fc.category_id IS NULL;

---------------------------------------------------------------------


-- Eng ko‘p filmga ega category’dagi kinolarni chiqaring


SELECT f.film_id, f.title, c.name
FROM film f
         JOIN film_category fc ON f.film_id = fc.film_id
         JOIN category c ON fc.category_id = c.category_id
WHERE c.category_id =
      (SELECT fc2.category_id FROM film_category fc2 GROUP BY fc2.category_id ORDER BY count(fc2.film_id) DESC LIMIT 1);


SELECT f.film_id, f.title, c.name
FROM film f
         JOIN film_category fc ON f.film_id = fc.film_id
         JOIN category c ON fc.category_id = c.category_id
WHERE c.category_id =
      (SELECT fc2.category_id FROM film_category fc2 GROUP BY fc2.category_id ORDER BY count(fc2.film_id) DESC LIMIT 1);



--------------------------------------------------------------------
-- 1. har bir xodim(staff_id) uchun qabul qilib olingan eng oxirgi to'lov summasi va sanasini toping.(staff_id, amount, payment_date)
SELECT p.staff_id,
       p.amount,
       p.payment_date
FROM payment p
WHERE (p.staff_id, p.payment_date) IN (SELECT staff_id,
                                              MAX(payment_date)
                                       FROM payment
                                       GROUP BY staff_id)
ORDER BY p.staff_id;



-------------------------------------------------------------------------
-- 2 har bir kategoriya bo'yicha o'sha kategoriyadagi filmlarda eng ko'p rol o'ynagan aktyorning ism-sharifini chiqaring. (name, first_name, last_name, actor_id, category_id, film_id)
SELECT c.name,
       a.first_name,
       a.last_name,
       a.actor_id
FROM (SELECT fc.category_id,
             fa.actor_id,
             ROW_NUMBER() OVER (
                 PARTITION BY fc.category_id
                 ORDER BY COUNT(*) DESC
                 ) rn
      FROM film_category fc
               JOIN film_actor fa ON fa.film_id = fc.film_id
      GROUP BY fc.category_id, fa.actor_id) t
         JOIN category c ON c.category_id = t.category_id
         JOIN actor a ON a.actor_id = t.actor_id
WHERE t.rn = 1;

-------------------------------------------------------------------------
-- 3. INVENTORDA bor bulgan lekin 2005-yilning may oyida biror marta ham ijaraga berilmagan film nomlarini toping.(title, film_id, inventory_id)
SELECT f.title,
       f.film_id,
       i.inventory_id
FROM inventory i
         JOIN film f ON f.film_id = i.film_id
         LEFT JOIN rental r
                   ON r.inventory_id = i.inventory_id
                       AND r.rental_date >= DATE '2005-05-01'
                       AND r.rental_date < DATE '2005-06-01'
WHERE r.rental_id IS NULL
ORDER BY f.title;

------------------------------------------------------------------------
-- 4 Faqat bitta do'kondan(store_id) film ijaraga olgan mijozlarni aniqlang(first_name, last_name, store_id, customer_id, inventory_id)

SELECT c.first_name, c.last_name, i.store_id, c.customer_id, i.inventory_id
FROM customer c
         JOIN rental r ON c.customer_id = r.customer_id
         JOIN inventory i ON r.inventory_id = i.inventory_id
GROUP BY c.first_name, c.last_name, i.store_id, c.customer_id, i.inventory_id
HAVING COUNT(DISTINCT i.store_id) = 1;

-------------------------------------------------------------------------
-- 5 Ishtirok etgan filmlari jami 1000$ dan ortiq daromad keltirgan aktyorlarning ro'yxatini chiqaring(first_name, last_name, amount, actor_id, rental_id)
SELECT a.first_name,
       a.last_name,
       SUM(p.amount) AS amount,
       a.actor_id,
       r.rental_id
FROM actor a
         JOIN film_actor fa ON a.actor_id = fa.actor_id
         JOIN inventory i ON fa.film_id = i.film_id
         JOIN rental r ON i.inventory_id = r.inventory_id
         JOIN payment p ON r.rental_id = p.rental_id
GROUP BY a.first_name, a.last_name, a.actor_id, r.rental_id
HAVING SUM(p.amount) > 1000;

------------------------------------------------------------------











