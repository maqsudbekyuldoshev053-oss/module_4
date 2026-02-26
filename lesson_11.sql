select now() - interval '5 year' * random();


create table if not exists users
(
    id         serial primary key,
    first_name varchar(255) not null,
    username   varchar(255) not null unique,
    phone      varchar(255) unique,
    created_at timestamp default now()
);



insert into users
select generate_series                       as id,
       substr(md5(generate_series::text) || '' || md5(generate_series::text), 1,
              (random() * 54 + 10)::integer) as first_name,
       substr(md5(generate_series::text) || '' || md5(generate_series::text), 1,
              (random() * 24 + 10)::integer) as username,
       '998' || (ARRAY [90,91,95,99,98,93,70,77,33,88])[ceil(random() * 10)]::text ||
       (100_00_00 + generate_series)::text      phone,
       now() - interval '5 year' * random()  as created_at
from generate_series(1, 37579);



CREATE TABLE IF NOT EXISTS project
(
    id           SERIAL PRIMARY KEY,
    first_name   VARCHAR(255) NOT NULL,
    last_name    VARCHAR(255) NOT NULL,
    phone        VARCHAR(255) UNIQUE,
    last_update  TIMESTAMP DEFAULT now(),
    release_year INTEGER
);


INSERT INTO project
SELECT generate_series                                                                                          AS id,
       substr(md5(generate_series::TEXT) || '' || md5(generate_series::TEXT), 1,
              (random() * 54 + 10)::INTEGER)                                                                    AS first_name,
       substr(md5(generate_series::TEXT) || '' || md5(generate_series::TEXT), 1,
              (random() * 54 + 10)::INTEGER)                                                                    AS last_name,
       '998' || (ARRAY [90.91,93,95,97,98,99,70,73,77,88])[ceil(random() * 10)]::TEXT ||
       (100_00_00 + generate_series)::TEXT                                                                         phone,
       now() - interval '6 year' * random()                                                                     AS last_update,
       extract(YEAR FROM now() - interval '6 year' * random())                                                  AS release_year
FROM generate_series(1, 100);




select * from transactions where message  is  null; -- null bulganlarni
select * from transactions where message  is not null; -- null bulmaganlarni
select * from transactions where message  != '';   -- bush bulmaganlarni



select '15'::integer;
select cast ('15' as integer);





select nullif(1,1); -- bir hil bulsa null
select nullif(0,1); -- har hil bulsa 1-argumentni oladi



select left('uzbekistan', 5);  -- chapdan 5 ta belgi oladi
select right('uzbekistan', 5); -- o'ngan 5 ta belgi oladi



































































