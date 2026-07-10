-- ======================================
-- sql to pyspark phase 2 - sql solutions
-- ======================================

-- 1. total order amount for each customer
select customer_id, sum(total_amount) as total_spent
from sales
group by customer_id;

-- 2. top 3 customers by total spend
select c.customer_id,
       concat(c.first_name, ' ', c.last_name) as name,
       sum(s.total_amount) as total_spent
from customers c
join sales s
on c.customer_id = s.customer_id
group by c.customer_id, c.first_name, c.last_name
order by total_spent desc
limit 3;

-- 3. customers with no orders
select c.customer_id,
       concat(c.first_name, ' ', c.last_name) as name
from customers c
left join sales s
on c.customer_id = s.customer_id
where s.customer_id is null;

-- 4. city-wise total revenue
select c.city,
       sum(s.total_amount) as total_revenue
from customers c
join sales s
on c.customer_id = s.customer_id
group by c.city
order by total_revenue desc;

-- 5. average order amount per customer
select customer_id,
       avg(total_amount) as avg_order_amount
from sales
group by customer_id;

-- 6. customers with more than one order
select c.customer_id,
       concat(c.first_name, ' ', c.last_name) as name,
       count(s.sale_id) as order_count
from customers c
join sales s
on c.customer_id = s.customer_id
group by c.customer_id, c.first_name, c.last_name
having count(s.sale_id) > 1;

-- 7. sort customers by total spend descending
select c.customer_id,
       concat(c.first_name, ' ', c.last_name) as name,
       sum(s.total_amount) as total_spent
from customers c
join sales s
on c.customer_id = s.customer_id
group by c.customer_id, c.first_name, c.last_name
order by total_spent desc;
