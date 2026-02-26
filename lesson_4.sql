--docker cp my_postgres:var/lib/postgresql/actors.csv .          terminalda

COPY (select actor_id, first_name
      from actor
      order by actor_id
      limit 5) TO '/var/lib/postgresql/yangi_actor.csv' CSV HEADER;

create table if not exists edu_center(
    id serial primary key,
    name varchar(255) not null
);
COPY edu_center FROM '/var/lib/postgresql/edu_center.csv' CSV HEADER;

-- companies
-- id, name, email, phone, address, country

-- docker exec -it my_postgres sh


CREATE TABLE basket_a
(
    a       INT PRIMARY KEY,
    fruit_a VARCHAR(100) NOT NULL
);

CREATE TABLE basket_b
(
    b       INT PRIMARY KEY,
    fruit_b VARCHAR(100) NOT NULL
);

INSERT INTO basket_a (a, fruit_a)
VALUES (1, 'Apple'),
       (2, 'Orange'),
       (3, 'Banana'),
       (4, 'Cucumber');

INSERT INTO basket_b (b, fruit_b)
VALUES (1, 'Orange'),
       (2, 'Apple'),
       (3, 'Watermelon'),
       (4, 'Pear');


-- inner join
select *
from basket_a
         join basket_b on fruit_a = fruit_b;

-- left join
select *
from basket_a
         left join basket_b on fruit_a = fruit_b;

-- left outer join
select *
from basket_a
         left join basket_b on fruit_a = fruit_b
where fruit_b is null;

-- right join
select *
from basket_a
         right join basket_b on fruit_a = fruit_b;

-- right outer join
select *
from basket_a
         right join basket_b on fruit_a = fruit_b
where fruit_a is null;

-- full join
select *
from basket_a
         full join basket_b on fruit_a = fruit_b;

-- full outer join
select *
from basket_a
         full join basket_b on fruit_a = fruit_b
where fruit_b is null
   or fruit_a is null;

-- 1. address, district, city, country

CREATE TABLE IF NOT EXISTS student
(
    id         SERIAL PRIMARY KEY,
    first_name VARCHAR(255) NOT NULL,
    last_name  VARCHAR(255) NOT NULL,
    email      VARCHAR(255) NOT NULL,
    gender     VARCHAR(255) NOT NULL,
    ip_address INET         NOT NULL
);

COPY student FROM '/var/lib/postgresql/MOCK_DATA.csv' CSV HEADER;



