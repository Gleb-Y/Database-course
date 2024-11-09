create table countries (
    id serial primary key,
    name varchar(50) not null
);
insert into countries (name)
    values ('Kazakhstan'),
           ('Russia'),
           ('USA'),
           ('China');


create table employees (
    id serial primary key,
    name varchar(50) not null,
    surname varchar(50) not null,
    salary numeric(10, 2) not null,
    department_id int
);
insert into employees (name, surname, salary, department_id) values
('John', 'Doe', 50000, 1),
('Jane', 'Smith', 60000, 1),
('Alice', 'Johnson', 45000, 2),
('Bob', 'Brown', 75000, 3),
('Charlie', 'Adams', 90000, 2);

create table departments (
    department_id serial primary key,
    name varchar(50) not null,
    budget numeric(10, 2) not null
);
insert into departments (name, budget) values
('Engineering', 100000),
('HR', 50000),
('Sales', 75000);

--1
create index idx_countries_name on countries (name);
select * from countries where name = 'USA';


--2
create index idx_employees_name_surname on employees (name, surname);
select * from employees where name = 'John' and surname = 'Doe';


--3
create unique index idx_employees_salary on employees(salary);
select * from employees where salary < 80000 and salary > 50000;


--4
create index idx_employees_name_substring on employees(substring(name from 1 for 4));
select * from employees where substring(name from 1 for 4) = 'Jane';


--5
create index idx_employees_departments_budget_salary on employees(department_id, salary);
create index idx_employees_budget on departments (budget);

select * from employees e
join departments d on d.department_id = e.department_id
where d.budget > 50000 and e.salary < 80000;

drop table if exists employees;
drop table if exists departments;
drop table if exists countries;