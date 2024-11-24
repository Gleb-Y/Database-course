--1
create function increase_value (par int)
returns int as $$
begin
    return par + 10;
end;
$$ language plpgsql;

select increase_value(2);



--2
create function compare_numbers (in1 int, in2 int)
returns varchar(8) as $$
begin
    if in1 > in2 then
       return 'Greater';
    elsif in1 < in2 then
        return 'Lesser';
    else
        return 'Equal';
    end if;
end;
$$ language plpgsql;

select compare_numbers(2, 3);



--3
create function  number_series(n int)
returns int[] as $$
declare
    result int[] := '{}';
    i int := 1;
begin
    while i<= n loop
        result := array_append(result, i);
        i := i+1;
        end loop;
    return result;
end;
$$ language plpgsql;

select number_series(3);



--4
create table employees (
    id serial primary key,
    name varchar(50) ,
    surname varchar(50) ,
    salary numeric(10, 2),
    department_id int
);
insert into employees (name, surname, salary, department_id) values
('John', 'Doe', 50000, 1),
('Jane', 'Smith', 60000, 1),
('Alice', 'Johnson', 45000, 2),
('Bob', 'Brown', 75000, 3),
('Charlie', 'Adams', 90000, 2);

create or replace function find_employee (emp_name varchar(50))
returns table(name varchar(50), surname varchar(50), salary numeric, department_id int) as $$
begin
    return query
    select employees.name::varchar(50)
         , employees.surname::varchar(50)
         , employees.salary, employees.department_id
    from employees
    where employees.name = emp_name;
end;
$$ language plpgsql;

drop function find_employee(emp_name varchar);

select * from find_employee('Alice');



--5
create table products (
    prod_id serial primary key ,
    prod_name varchar(50),
    prod_price int,
    prod_color varchar(50),
    prod_category varchar(50)
);
insert into products (prod_name, prod_price, prod_color, prod_category) values
('T-shirt', 100, 'Red', 'Clothing'),
('Jeans', 150, 'Blue', 'Clothing'),
('Sneakers', 200, 'Black', 'Footwear'),
('Watch', 250, 'Silver', 'Accessories'),
('Jacket', 300, 'Green', 'Clothing');

create  or replace function list_products(category varchar(50))
returns table(prod_name varchar(50), prod_price int, prod_color varchar(50)) as $$
begin
    return query
    select p.prod_name, p.prod_price, p.prod_color
    from products as p
    where prod_category = category;
end;
$$ language plpgsql;

select list_products('Clothing');

--6
CREATE TABLE employees2 (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50),
    salary NUMERIC
);
INSERT INTO employees2 (name, salary) VALUES
('Alice', 50000),
('Bob', 60000),
('Charlie', 70000);

create function calculate_bonus(emp_name varchar(50))
returns numeric as $$
declare
    emp_salary numeric;
    bonus numeric;
begin
    select e.salary into emp_salary
    from employees2 as e
    where name = emp_name;

    bonus := emp_salary*0.1;
    return bonus;
end;
$$ language plpgsql;

create or replace function update_salary(emp_name varchar(50))
returns numeric as $$
declare
    bonus numeric;
    new_salary numeric;
begin
    bonus := calculate_bonus(emp_name);
    select e.salary into new_salary
    from employees2 as e
    where name = emp_name;
    new_salary := new_salary + bonus;

    -- Update the employee's salary in the database
    update employees2
    set salary = new_salary
    where name = emp_name;
    RAISE NOTICE 'Salary updated for employee Name % to %. New bonus: %.', emp_name, new_salary, bonus;
    return new_salary;
end;
$$ language plpgsql;

drop function calculate_bonus(emp_name varchar);
drop function update_salary(emp_name varchar);

select update_salary('Alice');



--7
create or replace function complex_calculation(
    emp_name varchar(50),
    emp_salary numeric,
    salary_increase_percent numeric
)
returns varchar as $$
declare
    final_message varchar;
    updated_salary numeric;
    reversed_name varchar;

    begin
        -- Block for salary update
        <<numeric_block>>
        begin
            updated_salary := emp_salary + (emp_salary * salary_increase_percent / 100);
        end numeric_block;

        -- Block for name reversal
        <<string_block>>
        begin
            reversed_name := reverse(emp_name);
        end string_block;

        final_message := 'Employee ' || reversed_name || ' has an updated salary of ' || round(updated_salary, 2);

        return final_message;
    end;
$$ language plpgsql;

select complex_calculation('Alice', 50000, 10);


drop function if exists increase_value(int);
drop function if exists compare_numbers(int, int);
drop function if exists number_series(int);
drop function if exists find_employee(varchar);
drop function if exists list_products(varchar);
drop function if exists calculate_bonus(varchar);
drop function if exists update_salary(varchar);
drop function if exists complex_calculation(varchar, numeric, numeric);

drop table if exists employees;
drop table if exists products;
drop table if exists employees2;
