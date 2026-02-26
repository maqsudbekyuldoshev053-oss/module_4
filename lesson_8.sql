
create table if not exists new_table
(
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);

INSERT INTO new_table(name)
VALUES ('Maqsud'),
       ('Sherzodbek'),
       ('Muhammadamin'),
       ('Aslbek');



















