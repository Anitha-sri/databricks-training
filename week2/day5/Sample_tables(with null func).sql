                                             -- =====================================================
                                             -- sql null functions practice
                                             -- =====================================================

-- =====================
-- table 1: employees
-- =====================
create table employees (
    emp_id int,
    name varchar(50),
    salary int,
    bonus int,
    manager_id int
);

insert into employees values
(1, 'Amit', 50000, null, 101),
(2, 'John', null, 5000, 102),
(3, 'Sara', 60000, null, null),
(4, 'David', null, null, 103),
(5, 'Priya', 45000, 3000, 101),
(6, 'Kiran', null, null, null),
(7, 'Ravi', 70000, 7000, 102),
(8, 'Neha', null, 2000, null);

-- =====================================================
-- table 2: orders
-- =====================================================

create table orders (
    order_id int,
    customer_name varchar(50),
    amount int,
    discount int,
    coupon_code varchar(20)
);

insert into orders values
(101, 'Amit', 1000, null, 'DISC10'),
(102, 'John', null, 50, null),
(103, 'Sara', 2000, null, 'DISC20'),
(104, 'David', null, null, null),
(105, 'Priya', 1500, 100, null),
(106, 'Kiran', null, null, 'DISC5'),
(107, 'Ravi', 3000, null, null),
(108, 'Neha', null, 200, 'DISC15');

-- =====================================================
-- table 3: products
-- =====================================================

create table products (
    product_id int,
    product_name varchar(50),
    price int,
    category varchar(50),
    stock int
);

insert into products values
(1, 'Laptop', 50000, 'Electronics', 10),
(2, 'Phone', null, 'Electronics', null),
(3, 'Tablet', 30000, null, 5),
(4, 'Headphones', null, null, null),
(5, 'Monitor', 20000, 'Electronics', 0),
(6, 'Keyboard', null, 'Accessories', 15),
(7, 'Mouse', 500, null, null),
(8, 'Printer', null, 'Electronics', 3);



-- =====================================================
-- level 1 (basic)
-- =====================================================

-- 1. show all employees whose salary is null

select *
from employees
where salary is null;

-- 2. show all orders where discount is not null

select *
from orders
where discount is not null;

-- 3. get products where category is null

select *
from products
where category is null;

-- 4. count number of employees with null manager_id

select count(*) as total_employees
from employees
where manager_id is null;

-- =====================================================
-- level 2 (isnull)
-- =====================================================

-- 5. replace null salary with 0

select
    emp_id,
    name,
    isnull(salary, 0) as salary
from employees;

-- 6. replace null bonus with 1000

select
    emp_id,
    name,
    isnull(bonus, 1000) as bonus
from employees;

-- 7. show order amount, if null replace with 500

select
    order_id,
    customer_name,
    isnull(amount, 500) as amount
from orders;

-- 8. replace null stock with 0

select
    product_name,
    isnull(stock, 0) as stock
from products;

-- =====================================================
-- level 3 (coalesce)
-- =====================================================

-- 9. show employee earnings using salary, if null use bonus

select
    name,
    coalesce(salary, bonus) as earnings
from employees;

-- 10. show first available value salary -> bonus -> 0

select
    name,
    coalesce(salary, bonus, 0) as income
from employees;

-- 11. show product price price -> 1000

select
    product_name,
    coalesce(price, 1000) as final_price
from products;

-- 12. get customer payment amount -> discount -> 0

select
    customer_name,
    coalesce(amount, discount, 0) as payment
from orders;

-- =====================================================
-- level 4 (nullif)
-- =====================================================

-- 13. convert salary to null if salary = 0

select
    name,
    nullif(salary, 0) as salary
from employees;

-- 14. convert discount to null if discount = 0

select
    order_id,
    nullif(discount, 0) as discount
from orders;

-- 15. use nullif to avoid divide by zero

select
    amount / nullif(discount, 0) as result
from orders;

-- 16. replace coupon_code with null if it is 'DISC10'

select
    order_id,
    nullif(coupon_code, 'DISC10') as coupon_code
from orders;

-- =====================================================
-- level 5 (real-time scenarios)
-- =====================================================

-- 17. calculate total earnings salary + bonus (handle null properly)

select
    name,
    isnull(salary, 0) + isnull(bonus, 0) as total_earnings
from employees;

-- 18. show employees where both salary and bonus are null

select *
from employees
where salary is null
and bonus is null;

-- 19. show products where price is null but category is not null

select *
from products
where price is null
and category is not null;

-- 20. show orders where both amount and discount are null

select *
from orders
where amount is null
and discount is null;

-- =====================================================
-- level 6 (advanced)
-- =====================================================

-- 21. show employee income coalesce(salary, bonus, 1000)

select
    name,
    coalesce(salary, bonus, 1000) as income
from employees;

-- 22. replace empty discount with null using nullif

select
    order_id,
    nullif(discount, 0) as discount
from orders;

-- 23. show final payable amount amount - discount (handle null)

select
    order_id,
    customer_name,
    isnull(amount, 0) - isnull(discount, 0) as final_amount
from orders;

-- 24. find employees where salary is null but manager exists

select *
from employees
where salary is null
and manager_id is not null;

-- =====================================================
-- end of null functions practice
-- =====================================================
