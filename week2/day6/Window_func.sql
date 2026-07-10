                                                           --==============================
                                                           -- sql window functions practice
                                                           --===============================

-- Table creation for employees
create table employees (
    emp_id int,
    emp_name varchar(50),
    department varchar(50),
    salary int,
    join_date date
);

insert into employees values
(1,'amit','it',65000,'2023-01-10'),
(2,'priya','hr',50000,'2023-02-15'),
(3,'rahul','finance',70000,'2023-03-20'),
(4,'neha','it',68000,'2023-04-05'),
(5,'kiran','sales',45000,'2023-05-12'),
(6,'divya','hr',52000,'2023-06-18'),
(7,'arjun','finance',72000,'2023-07-09'),
(8,'meena','sales',48000,'2023-08-14'),
(9,'vikas','it',75000,'2023-09-01'),
(10,'pooja','hr',53000,'2023-10-22');


-- Table creation for orders

create table orders (
    order_id int,
    customer_name varchar(50),
    city varchar(50),
    order_amount int,
    order_date date
);

insert into orders values
(101,'amit','chennai',2500,'2023-01-01'),
(102,'priya','hyderabad',1800,'2023-01-02'),
(103,'rahul','bangalore',3200,'2023-01-03'),
(104,'neha','chennai',2800,'2023-01-04'),
(105,'kiran','mumbai',1500,'2023-01-05'),
(106,'divya','hyderabad',2600,'2023-01-06'),
(107,'arjun','bangalore',3500,'2023-01-07'),
(108,'meena','chennai',3000,'2023-01-08'),
(109,'vikas','mumbai',2100,'2023-01-09'),
(110,'pooja','hyderabad',3300,'2023-01-10');

-- ------------------------
-- row_number() questions
-- ------------------------ 

-- 1. assign a unique row number to all employees based on salary (highest first)
select *, row_number() over(order by salary desc) as row_num from employees;

-- 2. assign row numbers to employees within each department based on salary descending
select *, row_number() over(partition by department order by salary desc) as row_num from employees;

-- 3. assign row numbers based on employee joining date (latest first)
select *, row_number() over(order by join_date desc) as row_num from employees;

-- 4. assign row numbers within each department based on earliest joining date
select *, row_number() over(partition by department order by join_date) as row_num from employees;

-- 5. assign row numbers to orders based on order date
select *, row_number() over(order by order_date) as row_num from orders;

-- 6. assign row numbers to orders within each city based on order amount (highest first)
select *, row_number() over(partition by city order by order_amount desc) as row_num from orders;

-- 7. assign row numbers to employees based on salary (lowest first)
select *, row_number() over(order by salary) as row_num from employees;

-- 8. assign row numbers within department for employees based on name alphabetically
select *, row_number() over(partition by department order by emp_name) as row_num from employees;

-- ------------------------
-- rank() questions
-- ------------------------

-- 9. rank all employees based on salary (highest first)
select *, rank() over(order by salary desc) as emp_rank from employees;

-- 10. rank employees within each department based on salary
select *, rank() over(partition by department order by salary desc) as emp_rank from employees;

-- 11. rank employees based on joining date (latest gets rank 1)
select *, rank() over(order by join_date desc) as emp_rank from employees;

-- 12. rank orders based on order amount (highest first)
select *, rank() over(order by order_amount desc) as order_rank from orders;

-- 13. rank orders within each city based on order amount
select *, rank() over(partition by city order by order_amount desc) as order_rank from orders;

-- 14. rank employees within department based on salary (lowest first)
select *, rank() over(partition by department order by salary) as emp_rank from employees;

-- 15. rank employees based on name alphabetically
select *, rank() over(order by emp_name) as emp_rank from employees;

-- 16. rank orders within each city based on order date
select *, rank() over(partition by city order by order_date) as order_rank from orders;


-- ------------------------
-- dense_rank() questions
-- ------------------------

-- 17. assign dense rank to employees based on salary (highest first)
select *, dense_rank() over(order by salary desc) as dense_rank_num from employees;

-- 18. assign dense rank within each department based on salary
select *, dense_rank() over(partition by department order by salary desc) as dense_rank_num from employees;

-- 19. assign dense rank to employees based on joining date
select *, dense_rank() over(order by join_date desc) as dense_rank_num from employees;

-- 20. assign dense rank to orders based on order amount
select *, dense_rank() over(order by order_amount desc) as dense_rank_num from orders;

-- 21. assign dense rank within each city based on order amount
select *, dense_rank() over(partition by city order by order_amount desc) as dense_rank_num from orders;

-- 22. assign dense rank to employees based on salary (lowest first)
select *, dense_rank() over(order by salary) as dense_rank_num from employees;

-- 23. assign dense rank within department based on joining date
select *, dense_rank() over(partition by department order by join_date) as dense_rank_num from employees;

-- 24. assign dense rank to orders based on order date
select *, dense_rank() over(order by order_date) as dense_rank_num from orders;
