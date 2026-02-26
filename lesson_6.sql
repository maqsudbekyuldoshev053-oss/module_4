-- 1. har bir yilda nechtadan kino ishlab chiqarilgan,
-- eng kopidan kamiga qarab tartiblansin
select release_year, count(film_id) c
from film
group by release_year
order by c desc;

-- 2. oxirgi 10yildagi eng kop kino ishlab chiqarilgan 5ta yilni chiqaring
-- soni boyicha tartiblab chiqaring
select release_year, count(film_id) c
from film
where release_year > extract(year from now()) - 10
group by release_year
order by c desc
limit 5;

-- 3. oxirgi 10yildagi eng kop kino ishlab chiqarilgan juft yillarni chiqaring
-- soni boyicha tartiblab chiqaring
select release_year, count(film_id) c
from film
where release_year > extract(year from now()) - 10
  and release_year % 2 = 0
group by release_year
order by c desc;

-- 20:10
-- 4. oxirgi 10yildagi eng kop kino ishlab chiqarilganlar soni juft bolganlarini,
-- soni kamayish tartibi boyicha chiqaring
select release_year, count(film_id) c
from film
where release_year > extract(year from now()) - 10
group by release_year
having count(film_id) % 2 = 0
order by c desc;

-- 5. oxiri va boshida 'a' yoki 'A' harfi ishlatilgan davlatlarda
-- nechtadan shahar borligini aniqlang
select country, count(city_id)
from country
         left join city on city.country_id = country.country_id
where country ilike 'a%a'
group by country;

insert into country(country)
values ('AUzbekistana');

-- 6. ismi 1martadan kop uchragan xaridorlarni toping
select first_name, count(customer_id)
from customer
group by first_name
having count(customer_id) > 1;



-- 21:05

-- 7. har bir xaridorning o'rtacha qilgan to'lovini chiqaring,
select first_name, avg(amount)
from payment p
         join customer c using (customer_id)
group by c.customer_id, c.first_name;


-- 8. kim qaysi kinoni ijaraga olgan
select c.first_name, f.title
from rental r
         join customer c on c.customer_id = r.customer_id
         join inventory i on i.inventory_id = r.inventory_id
         join film f on f.film_id = i.film_id
order by c.first_name;


-- 9. staff va customer da bir ismlilarni chiqarish kerak
select first_name
from staff
except
select first_name
from customer;

select count(distinct first_name) from staff;

-- https://olcha.uz/ru