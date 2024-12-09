create database online_bookstore;
-- 1
create table books (
    book_id integer primary key,
    title varchar(255) not null,
    author varchar(255) not null,
    price decimal(10, 2) not null,
    quantity integer not null
);

create table customers (
    customer_id integer primary key,
    name varchar(255) not null,
    email varchar(255) not null
);

create table orders (
    order_id integer primary key,
    book_id integer not null,
    customer_id integer not null,
    order_date date not null,
    quantity integer not null,
    foreign key (book_id) references books(book_id),
    foreign key (customer_id) references customers(customer_id)
);

insert into books (book_id, title, author, price, quantity) values
(1, 'Database 101', 'A. Smith', 40.00, 10),
(2, 'Learn SQL', 'B. Johnson', 35.00, 15),
(3, 'Advanced DB', 'C. Lee', 50.00, 5);

insert into customers (customer_id, name, email) values
(101, 'John Doe', 'johndoe@example.com'),
(102, 'Jane Doe', 'janedoe@example.com');


-- 2. Transaction: Place an order
begin;
insert into orders (order_id, book_id, customer_id, order_date, quantity)
values (1, 1, 101, current_date, 2);

update books
set quantity = quantity - 2
where book_id = 1;

commit;
rollback;


-- 3. Transaction with rollback
begin;
-- Проверяем наличие достаточного количества книг
do $$
declare
    available_quantity integer;
begin
    select quantity into available_quantity from books where book_id = 3;
    if available_quantity < 3 then
        -- Если недостаточно книг, выбрасываем исключение
        raise exception 'Not enough books in stock for book_id = 3';
    end if;
end;
$$;
-- Если количество книг достаточно, выполняем операции
insert into orders (order_id, book_id, customer_id, order_date, quantity)
values (2, 3, 102, current_date, 10);

update books
set quantity = quantity - 10
where book_id = 3;

-- Завершаем транзакцию
commit;
rollback ;


-- 4. Isolation level: Update the price
set transaction isolation level read committed;
begin;
update books
set price = 45.00
where book_id = 1;

commit;


-- 5. Isolation level: Read the price
set transaction isolation level read committed;
begin;
select price from books where book_id = 1;

commit;


-- 6. Durability check
begin;
update customers
set email = 'new_email@example.com'
where customer_id = 1;

commit;

-- Verify the updated email address
select * from customers where customer_id = 1;


rollback ;

drop table if exists orders cascade ;
drop table if exists books cascade;
drop table if exists customers cascade;