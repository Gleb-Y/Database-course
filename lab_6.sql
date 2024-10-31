--1
create database lab6;

--2
create table locations (
    location_id serial primary key,
    street_address varchar(25),
    postal_code varchar(12),
    city varchar(30),
    state_province varchar(12)
);
create table departments (
    department_id serial primary key,
    department_name varchar(50) unique ,
    budget int,
    location_id int references locations
);
create table employees (
    employee_id serial primary key,
    first_name varchar(50),
    last_name varchar(50),
    email varchar(50),
    phone_number varchar(20),
    salary int,
    department_id int references departments
);
insert into locations (street_address, postal_code, city, state_province)
values
('123 Maple St', '10001', 'New York', 'NY'),
('456 Oak Ave', '20001', 'Washington', 'DC'),
('789 Pine Rd', '30001', 'Atlanta', 'GA'),
('101 Elm St', '40001', 'Chicago', 'IL'),
('202 Birch Blvd', '50001', 'San Francisco', 'CA');
insert into departments (department_name, budget, location_id)
values
('Finance', 100000, 1),
('HR', 50000, 2),
('IT', 150000, 3),
('Marketing', 120000, 4),
('Sales', 80000, 5);
insert into employees (first_name, last_name, email, phone_number, salary, department_id)
values
('Alice', 'Johnson', 'alice.johnson@example.com', '123-456-7890', 60000, 1),
('Bob', 'Smith', 'bob.smith@example.com', '234-567-8901', 70000, 2),
('Charlie', 'Brown', 'charlie.brown@example.com', '345-678-9012', 80000, 3),
('Daisy', 'Miller', 'daisy.miller@example.com', '456-789-0123', 75000, 4),
('Edward', 'Wilson', 'edward.wilson@example.com', '567-890-1234', 65000, NULL);  -- No department


--3
select first_name, last_name,d.department_id, department_name
from employees e
join departments d on e.department_id = d.department_id;

--4
select first_name, last_name, d.department_id, department_name
from employees e
join departments d on e.department_id = d.department_id
where e.department_id in (80, 40);

--5
select first_name, last_name, department_name, city, state_province
from employees e
join departments d on e.department_id = d.department_id
join locations l on d.location_id = l.location_id;

--6
select department_name, d.department_id
from departments d
left join employees e on d.department_id = e.department_id;

--7
select first_name, last_name, d.department_id, department_name
from employees e
left join departments d on e.department_id = d.department_id;


drop table if exists departments;
drop table if exists employees;
drop table if exists locations;
drop database if exists lab6;