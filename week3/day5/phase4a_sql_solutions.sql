
-- ==========================================
-- sql to pyspark phase 4a - sql solutions
-- ==========================================

-- 1. calculate total spend for each customer
select
    c.customer_id,
    concat(c.first_name, ' ', c.last_name) as name,
    sum(s.total_amount) as total_spend
from customers c
join sales s
on c.customer_id = s.customer_id
group by c.customer_id, c.first_name, c.last_name;

-- 2. segment customers using conditional logic
select
    customer_id,
    name,
    total_spend,
    case
        when total_spend > 5000 then 'gold'
        when total_spend between 1000 and 5000 then 'silver'
        else 'bronze'
    end as segment_conditional
from (
    select
        c.customer_id,
        concat(c.first_name, ' ', c.last_name) as name,
        sum(s.total_amount) as total_spend
    from customers c
    join sales s
    on c.customer_id = s.customer_id
    group by c.customer_id, c.first_name, c.last_name
) t;

-- 3. count customers in each segment
select
    case
        when total_spend > 5000 then 'gold'
        when total_spend between 1000 and 5000 then 'silver'
        else 'bronze'
    end as segment,
    count(*) as customer_count
from (
    select
        customer_id,
        sum(total_amount) as total_spend
    from sales
    group by customer_id
) t
group by
    case
        when total_spend > 5000 then 'gold'
        when total_spend between 1000 and 5000 then 'silver'
        else 'bronze'
    end
order by customer_count desc;

-- 4. find the 33rd and 66th percentile of customer spend
select
    percentile_cont(0.33) within group (order by total_spend) as percentile_33,
    percentile_cont(0.66) within group (order by total_spend) as percentile_66
from (
    select
        customer_id,
        sum(total_amount) as total_spend
    from sales
    group by customer_id
) t;

-- 5. assign customer tiers using quantiles
-- note: replace <q33> and <q66> with the calculated percentile values

select
    customer_id,
    name,
    total_spend,
    case
        when total_spend > <q66> then 'tier 1 (high)'
        when total_spend between <q33> and <q66> then 'tier 2 (mid)'
        else 'tier 3 (low)'
    end as segment_quantile
from (
    select
        c.customer_id,
        concat(c.first_name, ' ', c.last_name) as name,
        sum(s.total_amount) as total_spend
    from customers c
    join sales s
    on c.customer_id = s.customer_id
    group by c.customer_id, c.first_name, c.last_name
) t;

-- 6. bucket customers based on total spend
select
    customer_id,
    name,
    total_spend,
    case
        when total_spend < 1000 then 0
        when total_spend >= 1000 and total_spend <= 5000 then 1
        else 2
    end as bucket_index
from (
    select
        c.customer_id,
        concat(c.first_name, ' ', c.last_name) as name,
        sum(s.total_amount) as total_spend
    from customers c
    join sales s
    on c.customer_id = s.customer_id
    group by c.customer_id, c.first_name, c.last_name
) t;
