-- ==========================================
-- sql to pyspark phase 3 - sql solutions
-- ==========================================

-- 1. read sales data, clean nulls and calculate daily sales
select sale_date,
       sum(total_amount) as daily_sales
from sales
where sale_date is not null
  and total_amount is not null
group by sale_date
order by sale_date;

-- 2. read customer data, clean invalid rows and calculate city-wise revenue
select c.city,
       sum(s.total_amount) as city_revenue
from customers c
join sales s
on c.customer_id = s.customer_id
where c.customer_id is not null
  and s.customer_id is not null
  and c.city is not null
group by c.city
order by city_revenue desc;

-- 3. find repeat customers (more than 2 orders)
select customer_id,
       count(sale_id) as order_count
from sales
where customer_id is not null
group by customer_id
having count(sale_id) > 2
order by order_count desc;

-- 4. find the highest spending customer in each city
with customer_spend as (
    select c.city,
           s.customer_id,
           sum(s.total_amount) as total_spent
    from customers c
    join sales s
    on c.customer_id = s.customer_id
    where c.customer_id is not null
      and s.customer_id is not null
    group by c.city, s.customer_id
),
max_spend as (
    select city,
           max(total_spent) as max_spent
    from customer_spend
    group by city
)
select cs.city,
       cs.customer_id,
       cs.total_spent
from customer_spend cs
join max_spend ms
on cs.city = ms.city
and cs.total_spent = ms.max_spent
order by cs.city;

-- 5. build final reporting table
select c.customer_id,
       c.city,
       sum(s.total_amount) as total_spent,
       count(s.sale_id) as order_count
from customers c
left join sales s
on c.customer_id = s.customer_id
where c.customer_id is not null
group by c.customer_id, c.city
order by c.customer_id;
