---------------------------------------------------------------------
--1
SELECT s.staff_id, p.amount, p.payment_date
FROM staff s
         JOIN payment p ON s.staff_id = p.staff_id

WHERE EXTRACT(YEAR FROM p.payment_date) = (select max(extract(YEAR FROM last_update))
                                          FROM category)
GROUP BY s.staff_id, p.amount, p.payment_date;

--------------------------------------------------------------------
--2
SELECT c.name, f.title, a.first_name, a.last_name
FROM film f
         JOIN film_category fc ON f.film_id = fc.film_id
         JOIN category c ON fc.category_id = c.category_id
         JOIN film_actor fa on fc.film_id = fa.film_id
         JOIN actor a ON fa.actor_id = a.actor_id
WHERE c.category_id =
      (SELECT fc2.category_id FROM film_category fc2 GROUP BY fc2.category_id ORDER BY count(fc2.film_id) DESC LIMIT 1)
GROUP BY c.name, f.title, a.first_name, a.last_name;

---------------------------------------------------------------------
--3
SELECT f.title, f.film_id, r.rental_date, i.inventory_id
FROM inventory i
         JOIN public.rental r on i.inventory_id = r.inventory_id
         JOIN public.film f on i.film_id = f.film_id;

---------------------------------------------------------------------
--4
SELECT c.first_name, c.last_name, s.store_id, c.customer_id, i.inventory_id
FROM store s
         JOIN customer c ON c.store_id = s.store_id
         JOIN inventory i ON i.store_id = s.store_id
         JOIN film f on f.film_id = i.film_id
GROUP BY c.first_name, c.last_name, s.store_id, c.customer_id, i.inventory_id;

------------------------------------------------------------------
--5
SELECT r.rental_id, a.actor_id, a.first_name, a.last_name, p.amount, sum(p.amount)
FROM rental r
         JOIN payment p on r.rental_id = p.rental_id
         JOIN inventory i on r.inventory_id = i.inventory_id
         JOIN film_actor fa on fa.film_id = i.film_id
         JOIN actor a ON fa.actor_id = a.actor_id
GROUP BY r.rental_id, a.actor_id, a.first_name, a.last_name, p.amount
HAVING sum(p.amount) > 1000
ORDER BY sum(p.amount);