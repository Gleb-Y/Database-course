-- 1
create database lab8;

-- 2
CREATE TABLE salesman (
    salesman_id INT PRIMARY KEY,
    name VARCHAR(50),
    city VARCHAR(50),
    commission DECIMAL(5, 2)
);

INSERT INTO salesman (salesman_id, name, city, commission)
VALUES
    (5001, 'James Hoog', 'New York', 0.15),
    (5002, 'Nail Knite', 'Paris', 0.13),
    (5005, 'Pit Alex', 'London', 0.11),
    (5006, 'Mc Lyon', 'Paris', 0.14),
    (5003, 'Lauson Hen', 'Rome', 0.12),
    (5007, 'Paul Adam', 'Rome', 0.13);

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    cust_name VARCHAR(50),
    city VARCHAR(50),
    grade INT,
    salesman_id INT,
    FOREIGN KEY (salesman_id) REFERENCES salesman(salesman_id)
);

INSERT INTO customers (customer_id, cust_name, city, grade, salesman_id)
VALUES
    (3002, 'Nick Rimando', 'New York', 100, 5001),
    (3005, 'Graham Zusi', 'California', 200, 5002),
    (3001, 'Brad Guzan', 'London', 0, 5005),
    (3004, 'Fabian Johns', 'Paris', 300, 5006),
    (3007, 'Brad Davis', 'New York', 200, 5001),
    (3009, 'Geoff Camero', 'Berlin', 100, 5003),
    (3008, 'Julian Green', 'London', 300, 5002);

CREATE TABLE orders (
    ord_no INT PRIMARY KEY,
    purch_amt DECIMAL(10, 2),
    ord_date DATE,
    customer_id INT,
    salesman_id INT,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (salesman_id) REFERENCES salesman(salesman_id)
);

INSERT INTO orders (ord_no, purch_amt, ord_date, customer_id, salesman_id)
VALUES
    (70001, 150.5, '2012-10-05', 3005, 5002),
    (70009, 270.65, '2012-09-10', 3001, 5005),
    (70002, 65.26, '2012-10-05', 3002, 5001),
    (70004, 110.5, '2012-08-17', 3009, 5003),
    (70007, 948.5, '2012-09-10', 3005, 5002),
    (70005, 2400.6, '2012-07-27', 3007, 5001),
    (70008, 5760.0, '2012-09-10', 3002, 5001);

-- 3
create role junior_dev with login;

--4
create view new_york_salesman as
    select * from salesman where city = 'New York';

--5
create view order_details as
select o.ord_no, o.purch_amt, o.ord_date,
       c.cust_name as customer_name,
       s.name as salesman_name
from orders o
join customers c on o.customer_id = c.customer_id
join salesman s on o.salesman_id = s.salesman_id;

grant all privileges on order_details to junior_dev;

--6
create view top_customer as
    select * from customers where grade = (select max(grade) from customers);

grant select on top_customer to junior_dev;


--7
create view num_of_salesman as
    select city, count(*) as salesman_cnt from salesman group by city;

--8
create view salesman_with_many_customers as
    select s.salesman_id, s.name, s.city, count(customer_id) as salesman_cnt
    from salesman s
join customers c on s.salesman_id = c.salesman_id
group by s.salesman_id, s.name, s.city
having count(customer_id) > 1;

--9
create role intern;
grant junior_dev to intern;


drop view if exists new_york_salesman;
drop view if exists order_details;
drop view if exists top_customer;
drop view if exists num_of_salesman;
drop view if exists salesman_with_many_customers;

drop role if exists intern;
drop role if exists junior_dev;

drop table if exists orders;
drop table if exists customers;
drop table if exists salesman;
drop database if exists lab8;