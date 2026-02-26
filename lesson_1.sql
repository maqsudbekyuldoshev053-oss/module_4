
create database p37_database;

CREATE TABLE IF NOT EXISTS students(
    first_name varchar(255) NOT NULL ,
    last_name varchar(255),
    phone varchar(12)
);

DROP TABLE IF EXISTS students;

DROP TABLE students;

SELECT students.first_name, students.phone
FROM students;

SELECT first_name || ' ' || last_name as FIO, phone AS nomer
FROM students s;

SELECT *
FROM students
WHERE first_name = 'O''tkir';

INSERT INTO students(first_name, last_name, phone)
VALUES ('Shavkat', '', '961005555');

INSERT INTO students
VALUES ('Shokirjon123', NULL, '961068559')
RETURNING phone;
