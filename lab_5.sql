--1
create database lab5;

--2
create table customers (
    customer_id int primary key,
    cust_name varchar(50),
    city varchar(50),
    grade int,
    salesman_id int
);
insert into customers (customer_id, cust_name, city, grade, salesman_id) values
(3002, 'Nick Rimando', 'New York', 100, 5001),
(3005, 'Graham Zusi', 'California', 200, 5002),
(3001, 'Brad Guzan', 'London', 100, 5005),
(3004, 'Fabian Johns', 'Paris', 300, 5006),
(3007, 'Brad Davis', 'New York', 200, 5001),
(3009, 'Geoff Camero', 'Berlin', 100, 5003),
(3008, 'Julian Green', 'London', 300, 5002);

create table salesmen (
    salesman_id int primary key,
    name varchar(50),
    city varchar(50),
    commission decimal(4, 2)
);

create table orders (
    ord_no int primary key,
    purch_amt decimal(10, 2),
    ord_date date,
    customer_id int,
    salesman_id int,
    foreign key (customer_id) references customers(customer_id),
    foreign key (salesman_id) references salesmen(salesman_id)
);

insert into salesmen (salesman_id, name, city, commission) values
(5001, 'James Hoog', 'New York', 0.15),
(5002, 'Nail Knite', 'Paris', 0.13),
(5005, 'Pit Alex', 'London', 0.11),
(5006, 'Mc Lyon', 'Paris', 0.14),
(5003, 'Lauzon Hen', 'San Jose', 0.12),
(5007, 'Paul Adam', 'Rome', 0.13);

insert into orders (ord_no, purch_amt, ord_date, customer_id, salesman_id) values
(70001, 150.5, '2012-10-05', 3005, 5002),
(70009, 270.65, '2012-09-10', 3001, 5005),
(70002, 65.26, '2012-10-05', 3002, 5001),
(70004, 110.5, '2012-08-17', 3009, 5003),
(70007, 948.5, '2012-09-10', 3005, 5002),
(70005, 2400.6, '2012-07-27', 3007, 5001),
(70008, 5760, '2012-09-10', 3002, 5001);

--3
select sum(purch_amt) as total_purchase_amount
from orders;

--4
select avg(purch_amt) as average_purch_amt
from orders;

--5
select count(*) as num_of_customers
from customers
where cust_name is not null;

--6
select purch_amt
from orders order by purch_amt asc
limit 1;

--7
select * from customers
where cust_name like '%b'
limit 1;

--8
select *
from orders join customers
    on orders.customer_id = customers.customer_id
where city = 'New York';

--9
select *
from customers join orders
    on customers.customer_id = orders.customer_id
where purch_amt > 10;

--10
select sum(grade) as total_grade
from customers;

--11
select * from customers
where cust_name is not null;

--12
select grade
from customers
order by grade desc
limit 1;

drop table if exists orders;
drop table if exists customers;
drop table if exists salesmen;
drop database if exists lab5;