
-- q1: row number by salary
select employee_name, salary, row_number() over(order by salary desc) as row_num from employees;
-- q2: rank employees by salary
select employee_name, salary, rank() over(order by salary desc) as salary_rank from employees;
-- q3: dense rank by salary
select employee_name, salary, dense_rank() over(order by salary desc) as dense_rank from employees;
-- q4: top 3 highest salaries
select * from (select employee_name, salary, row_number() over(order by salary desc) as rn from employees) t where rn <= 3;
-- q5: rank employees within department
select employee_name, department, salary, rank() over(partition by department order by salary desc) as dept_rank from employees;
-- q6: highest salary in each department
select employee_name, department, salary, max(salary) over(partition by department) as max_salary from employees;
-- q7: running total of orders
select order_id, order_date, total_amount, sum(total_amount) over(order by order_date) as running_total from orders;
-- q8: cumulative sales per employee
select employee_id, order_date, total_amount, sum(total_amount) over(partition by employee_id order by order_date) as cumulative_sales from orders;
-- q9: previous order amount using lag
select customer_id, order_id, total_amount, lag(total_amount) over(partition by customer_id order by order_date) as prev_amount from orders;
-- q10: next order amount using lead
select customer_id, order_id, total_amount, lead(total_amount) over(partition by customer_id order by order_date) as next_amount from orders;
-- q11: difference from previous order
select customer_id, order_id, total_amount, total_amount - lag(total_amount) over(partition by customer_id order by order_date) as diff_amount from orders;
-- q12: moving average of last 3 orders
select order_id, order_date, total_amount, avg(total_amount) over(order by order_date rows between 2 preceding and current row) as moving_avg from orders;
-- q13: salary quartiles using ntile
select employee_name, salary, ntile(4) over(order by salary desc) as quartile from employees;
-- q14: first order of each customer
select * from (select *, row_number() over(partition by customer_id order by order_date) as rn from orders) t where rn = 1;
-- q15: latest order of each customer
select * from (select *, row_number() over(partition by customer_id order by order_date desc) as rn from orders) t where rn = 1;
-- q16: employee salary with department average
select employee_name, department, salary, avg(salary) over(partition by department) as dept_avg from employees;
-- q17: employees above department average
select * from (select employee_name, department, salary, avg(salary) over(partition by department) as dept_avg from employees) t where salary > dept_avg;
-- q18: department payroll
select employee_name, department, salary, sum(salary) over(partition by department) as dept_payroll from employees;
-- q19: salary percentage contribution
select employee_name, department, salary, round(salary * 100.0 / sum(salary) over(partition by department), 2) as salary_percent from employees;
-- q20: total employees count
select employee_id, employee_name, department, count(*) over() as total_employees from employees;
-- q21: total sales per employee using cte
with employee_sales as (select employee_id, sum(total_amount) as total_sales from orders group by employee_id) select * from employee_sales;
-- q22: employees whose sales exceed average sales
with employee_sales as (select employee_id, sum(total_amount) as total_sales from orders group by employee_id), avg_sales as
  (select avg(total_sales) as avg_total from employee_sales) select * from employee_sales where total_sales > (select avg_total from avg_sales);
-- q23: customer spending and ranking
with customer_spending as (select customer_id, sum(total_amount) as total_spent from orders group by customer_id) 
  select customer_id, total_spent, rank() over(order by total_spent desc) as spending_rank from customer_spending;
-- q24: recursive cte numbers 1 to 10
with recursive numbers as (select 1 as num union all select num + 1 from numbers where num < 10) select * from numbers;
-- q25: recursive cte employee hierarchy
with recursive emp_hierarchy as (select employee_id, employee_name, manager_id, 1 as level from employees 
  where manager_id is null union all select e.employee_id, e.employee_name, e.manager_id, eh.level + 1 from employees e join emp_hierarchy eh 
  on e.manager_id = eh.employee_id) select * from emp_hierarchy;
-- q26: orders above average amount
with avg_order as (select avg(total_amount) as avg_amount from orders) select * from orders where total_amount > (select avg_amount from avg_order);
-- q27: rank customers by total spending
with customer_totals as (select customer_id, sum(total_amount) as total_spending from orders group by customer_id) select customer_id, total_spending, 
  rank() over(order by total_spending desc) as spending_rank from customer_totals;
-- q28: second highest salary in each department
select * from (select department, employee_name, salary, dense_rank() over(partition by department order by salary desc) as rnk from employees) t where rnk = 2;
-- q29: difference from department max salary
select employee_name, department, salary, max(salary) over(partition by department) - salary as diff_from_max from employees;
-- q30: top employee in each department by sales
with employee_sales as (select e.employee_id, e.employee_name, e.department, sum(o.total_amount) as total_sales
  from employees e join orders o on e.employee_id = o.employee_id group by e.employee_id, e.employee_name, e.department) select * from 
  (select *, rank() over(partition by department order by total_sales desc) as rnk from employee_sales) t where rnk = 1;


-- bonus: monthly sales trends report
WITH monthly_sales AS (
    SELECT 
        DATE_TRUNC('month', order_date) AS sales_month,
        SUM(total_amount) AS monthly_total
    FROM orders
    GROUP BY DATE_TRUNC('month', order_date)
),
sales_growth AS (
    SELECT 
        sales_month,
        monthly_total,

        SUM(monthly_total) OVER (
            ORDER BY sales_month
        ) AS running_total,

        LAG(monthly_total) OVER (
            ORDER BY sales_month
        ) AS previous_month_sales
    FROM monthly_sales
)
SELECT 
    sales_month,
    monthly_total,
    running_total,
    previous_month_sales,

    ROUND(
        (
            (monthly_total - previous_month_sales)
            * 100.0
        ) / previous_month_sales,
        2
    ) AS percentage_growth
FROM sales_growth;
