create table if not exists users
(
    id         serial primary key,
    first_name varchar(255) not null,
    username   varchar(255) not null unique,
    phone      varchar(255) unique,
    created_at timestamp default now()
);

-- 37579

select now() - interval '5 year' * random();

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

drop table if exists apps_transaction;

create table if not exists transactions
(
    id          serial primary key,
    amount      integer     not null,
    card_number varchar(20) null,
    status      varchar(50) not null,
    type        varchar(5)  not null,
    message     text        null,
    created_at  timestamp   not null,
    user_id     bigint      not null references users (id)
);

select *
from transactions;



create table mix
(
    id    integer,
    name  varchar(255),
    phone varchar(255) unique
);


SELECT relname sequence_name
FROM pg_class
WHERE relkind = 'S';

select gen_random_uuid();

select currval('mix_id_seq');
select nextval('mix_id_seq');

SELECT pg_get_serial_sequence('mix', 'id');



CREATE TABLE custom_users
(
    name        VARCHAR(255) NOT NULL,
    balance     INTEGER,
    category_id INTEGER
);

ALTER TABLE custom_users ADD COLUMN id SERIAL PRIMARY KEY;
ALTER TABLE custom_users DROP COLUMN id;
ALTER TABLE custom_users RENAME COLUMN name TO title;
ALTER TABLE custom_users ALTER COLUMN balance SET DEFAULT 0;
ALTER TABLE custom_users ALTER COLUMN balance DROP DEFAULT;
ALTER TABLE custom_users ADD CHECK (balance > -10);
ALTER TABLE custom_users RENAME TO new_custom_users;

ALTER TABLE custom_users
    ADD CONSTRAINT fk_category_id_category_id FOREIGN KEY (category_id) REFERENCES category (category_id);

-- Task
-- actor_detail
-- 1. actor_id, film_id, last_update (ustun nomlari)
--    fullname, title

-- actor_detail id nomli ustun qoshish (auto increment bolsin)
-- actor_id tipini varchar(255) qilish
-- actor_id ustun nomini fullname ga ozgartirish
-- balance nomli ustun (yil + kun + oy)  (last_update dan foydalanib) yangi ustun qoshish
-- released_date degan ustun qoshish va last_update ni sanasini released_date ga yozish
-- actorni nechta kinoda oynaganligini film_count nomli ustunga yozish





