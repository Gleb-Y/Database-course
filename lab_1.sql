/*1*/ create database lab1;
/*2*/ create table users(
    id serial,
    firstname varchar(50),
    lastname varchar(50)
);
/*3*/ ALTER TABLE users
ADD isadmin INTEGER;

/*4*/ ALTER TABLE users
ALTER COLUMN isadmin TYPE BOOLEAN using isadmin::boolean;

/*5*/ alter table users
alter column isadmin set default false;

/*6*/ alter table users
    ADD PRIMARY KEY(id);

/*7*/ create table tasks(
    id serial,
    name varchar(50),
    user_id int
);

/*8*/ drop table if exists tasks;
/*9*/ drop database if exists lab1;

/*
ALTER TABLE users
DROP COLUMN isadmin;
drop table users;
select * from users;
*/