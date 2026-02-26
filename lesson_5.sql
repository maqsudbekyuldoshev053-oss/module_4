select f.title, c.name
from film f
         join film_category fc on fc.film_id = f.film_id
         join category c on c.category_id = fc.category_id;

select first_name, country
from staff
         join address on address.address_id = staff.address_id
         join  city on city.city_id = address.city_id
         join  country on country.country_id = city.country_id;

select release_year from film;

SELECT release_year, count(*) FROM film GROUP BY release_year;

select film.length from film order by length limit 5;



SELECT  c.first_name,
    COUNT(r.rental_id)
FROM customer c
JOIN rental r ON c.customer_id = r.customer_id
JOIN inventory i on i.inventory_id=r.inventory_id
GROUP BY  c.first_name;



























