/*1*/ create database lab2;
/*2*/ create table countries(
    country_id serial primary key,
    country_name varchar(50),
    region_id int,
    population int
);
/*3*/
insert into countries (country_id, country_name, population)
values(10, 'Kazakhstan', 19000000);


/*4*/ insert into countries (country_id, country_name)
values(2, 'Elbonia');

/*5*/ insert into countries ( country_name, population)
    values( 'Utopia', 3000000);

/*6*/ insert into countries(region_id, country_name, population)
    values(6, 'Zamunda', 5000000),
          (11, 'USA', 331000000),
          (12, 'Russia', 144000000);


/*7*/ alter table countries
alter country_name set default 'Kazakhstan';

/*8*/ insert into countries(country_id, population)
      values(16, 543912);


/*9*/ insert into countries default values;

/*10*/ create table countries_new (like countries including all);

/*11*/ insert into countries_new
       select * from countries;

/*12*/ UPDATE countries
SET region_id = 1
WHERE region_id IS NULL;

/*13*/
SELECT country_name,
       population * 1.10 AS "New Population"
FROM countries;

/*14*/
DELETE FROM countries
WHERE population < 100000;

/*15*/
DELETE FROM countries_new
USING countries
WHERE countries_new.country_id = countries.country_id
RETURNING countries_new.*;

/*16*/
DELETE FROM countries
RETURNING *;

/*select * from countries;*/