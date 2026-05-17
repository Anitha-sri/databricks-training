-- ====================================================
--     QUESTION ! Employee Compensation Classification
--=====================================================

--table creation


CREATE TABLE employee_payments (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    department VARCHAR(30),
    base_salary DECIMAL(10,2),
    bonus DECIMAL(10,2),
    joining_date DATE
);
-- Insert Data

INSERT INTO employee_payments VALUES
(1,'karthik','Data',75000.75,5000.50,'2019-03-15'),
(2,'veena','HR',65000.40,4000.25,'2021-06-20'),
(3,'ravi','Data',85000.90,6000.75,'2016-01-10'),
(4,'anil','Finance',70000.10,NULL,'2020-09-01'),
(5,'suresh','HR',60000.55,3000.30,'2022-11-25');


-- Convert emp_name to proper case upper /lower Initcap (CamelCase)
SELECT emp_name, UPPER(emp_name) AS upper_name,
    LOWER(emp_name) AS lower_name,
    INITCAP(emp_name) AS proper_name FROM employee_payments;

--Calculate total income = base_salary + bonus (NULL safe) 
SELECT emp_name, base_salary,bonus,base_salary + COALESCE(bonus,0)AS total_income FROM employee_payments;

-- Round total income to nearest integer
SELECT emp_name,  ROUND(base_salary + COALESCE(bonus,0))AS rounded_income FROM employee_payments;

--· Extract joining year
SELECT emp_name,joining_date,EXTRACT(YEAR FROM joining_date)AS joining_year FROM employee_payments;

--Classify employees based on experience:
-- Senior → experience > 7 years
-- Mid → experience between 4 and 7 years
-- Junior → otherwise

SELECT emp_name,DATE_PART('year',AGE(CURRENT_DATE, joining_date))AS experience_years,
    CASE
        WHEN DATE_PART('year',
             AGE(CURRENT_DATE, joining_date)) > 7
            THEN 'Senior'
        WHEN DATE_PART('year',
             AGE(CURRENT_DATE, joining_date))
             BETWEEN 4 AND 7
            THEN 'Mid'
        ELSE 'Junior'
    END AS employee_category
FROM employee_payments;



```sql
-- ====================================================
--     QUESTION 2 Order Delivery Delay Analysis
--=====================================================

-- table creation

CREATE TABLE orders_delivery (order_id INT, customer_name VARCHAR(50), order_date DATE, delivery_date DATE, order_amount DECIMAL(10,2));

-- Insert Data

INSERT INTO orders_delivery VALUES
(101,'rajesh','2025-01-01','2025-01-05',12500.75),
(102,'meena','2025-01-10','2025-01-10',8400.40),
(103,'arun','2025-01-15','2025-01-20',15600.90),
(104,'pooja','2025-01-18',NULL,9200.10);

-- Uppercase customer name
SELECT customer_name, UPPER(customer_name) AS upper_customer_name FROM orders_delivery;

-- Calculate delivery days using date difference
SELECT order_id, order_date, delivery_date, DATEDIFF(COALESCE(delivery_date,CURRENT_DATE), order_date) AS delivery_days FROM orders_delivery;

-- Replace NULL delivery date with today
SELECT order_id, order_date, COALESCE(delivery_date,CURRENT_DATE) AS final_delivery_date FROM orders_delivery;

-- Truncate order amount to 1 decimal
SELECT order_id, order_amount, TRUNCATE(order_amount,1) AS truncated_amount FROM orders_delivery;

-- Delivery Status Classification
SELECT order_id, customer_name, order_date, delivery_date,
CASE
WHEN delivery_date IS NULL THEN 'Pending'
WHEN DATEDIFF(delivery_date,order_date) = 0 THEN 'Same-day'
WHEN DATEDIFF(delivery_date,order_date) > 3 THEN 'Delayed'
ELSE 'Normal'
END AS delivery_status
FROM orders_delivery;


--====================================================
--     QUESTION 3 Customer Spending Pattern
--=====================================================

CREATE TABLE customer_spending (cust_id INT, cust_name VARCHAR(50), city VARCHAR(30), purchase_amount DECIMAL(10,2), purchase_date DATE);

INSERT INTO customer_spending VALUES
(1,'amit','mumbai',12000.75,'2024-12-01'),
(2,'neha','delhi',8500.40,'2024-12-15'),
(3,'rohit','mumbai',15500.90,'2024-11-20'),
(4,'kavya','chennai',6000.10,'2024-10-05');

-- Customer name proper case
SELECT cust_name, INITCAP(cust_name) AS proper_name FROM customer_spending;

-- Month name of purchase
SELECT cust_name, MONTHNAME(purchase_date) AS purchase_month FROM customer_spending;

-- Rounded purchase amount
SELECT cust_name, ROUND(purchase_amount) AS rounded_purchase FROM customer_spending;

-- Absolute value of purchase
SELECT cust_name, ABS(purchase_amount) AS absolute_purchase FROM customer_spending;

-- Spending category
SELECT cust_name, purchase_amount,
  CASE 
  WHEN purchase_amount > 15000 
  THEN 'High Spender' 
  WHEN purchase_amount BETWEEN 8000 AND 15000 THEN 'Medium Spender'
  ELSE 'Low Spender' END AS spending_category FROM customer_spending;


-- ====================================================
--     QUESTION 4 Subscription Validity Check
--=====================================================

CREATE TABLE subscriptions (user_id INT, user_email VARCHAR(100), start_date DATE, end_date DATE, subscription_fee DECIMAL(10,2));

INSERT INTO subscriptions VALUES
(1,'karthik@gmail.com','2024-01-01','2025-01-01',12000.50),
(2,'veena@yahoo.com','2024-06-15','2024-12-15',8500.75),
(3,'ravi@hotmail.com','2023-03-01','2024-03-01',15000.90);

-- Extract email domain
SELECT user_email, SUBSTRING_INDEX(user_email,'@',-1) AS email_domain FROM subscriptions;

-- Subscription duration in months
SELECT user_id, TIMESTAMPDIFF(MONTH,start_date,end_date) AS duration_months FROM subscriptions;

-- Format fee with commas
SELECT user_id, FORMAT(subscription_fee,2) AS formatted_fee FROM subscriptions;

-- Remaining days from today
SELECT user_id, DATEDIFF(end_date,CURDATE()) AS remaining_days FROM subscriptions;

-- Subscription status
SELECT user_id, end_date, 
  CASE 
  WHEN end_date < CURDATE() THEN 'Expired' 
  WHEN DATEDIFF(end_date,CURDATE()) <= 30 THEN 'Expiring Soon' 
  ELSE 'Active' END AS subscription_status FROM subscriptions;


-- ====================================================
--     QUESTION 5 Loan EMI Risk Categorization
--=====================================================

CREATE TABLE loan_details (loan_id INT, customer_name VARCHAR(50), loan_amount DECIMAL(12,2), interest_rate DECIMAL(5,2), loan_start DATE);

INSERT INTO loan_details VALUES
(201,'suresh',500000.75,8.5,'2022-01-10'),
(202,'mahesh',750000.40,9.2,'2021-05-20'),
(203,'anita',300000.90,7.8,'2023-07-01');

-- Monthly interest using power function
SELECT customer_name, POWER((1 + interest_rate/100),1.0/12)-1 AS monthly_interest FROM loan_details;

-- Years since loan start
SELECT customer_name, TIMESTAMPDIFF(YEAR,loan_start,CURDATE()) AS loan_years FROM loan_details;

-- Round EMI
SELECT customer_name, ROUND(loan_amount * (interest_rate/1200)) AS rounded_emi FROM loan_details;

-- Uppercase customer name
SELECT customer_name, UPPER(customer_name) AS upper_name FROM loan_details;

-- Risk category
SELECT customer_name, interest_rate, 
  CASE
  WHEN interest_rate > 9 THEN 'High Risk' 
  WHEN interest_rate BETWEEN 8 AND 9 THEN 'Medium Risk' 
  ELSE 'Low Risk' END AS risk_category FROM loan_details;

-- ====================================================
--     QUESTION 6 Employee Attendance Evaluation
--=====================================================

CREATE TABLE attendance (emp_id INT, emp_name VARCHAR(50), total_days INT, present_days INT, record_date DATE);

INSERT INTO attendance VALUES
(1,'karthik',30,28,'2025-01-31'),
(2,'veena',30,22,'2025-01-31'),
(3,'ravi',30,18,'2025-01-31');

-- Attendance percentage
SELECT emp_name, ROUND((present_days * 100.0)/total_days,2) AS attendance_percentage FROM attendance;

-- Month name
SELECT emp_name, MONTHNAME(record_date) AS month_name FROM attendance;

-- Difference between total and present days
SELECT emp_name, (total_days - present_days) AS absent_days FROM attendance;

-- Lowercase employee name
SELECT emp_name, LOWER(emp_name) AS lower_name FROM attendance;

-- Attendance classification
SELECT emp_name, ROUND((present_days * 100.0)/total_days,2) AS attendance_percentage, 
  CASE WHEN ((present_days * 100.0)/total_days) >= 90 THEN 'Excellent' 
  WHEN ((present_days * 100.0)/total_days) BETWEEN 75 AND 89 THEN 'Average'
  ELSE 'Poor' END AS attendance_status FROM attendance;


-- ====================================================
--     QUESTION 7 Product Discount Validation
--=====================================================

CREATE TABLE product_sales (product_id INT, product_name VARCHAR(50), mrp DECIMAL(10,2), selling_price DECIMAL(10,2), sale_date DATE);

INSERT INTO product_sales VALUES
(1,'Laptop',75000.75,68000.50,'2025-01-10'),
(2,'Mobile',35000.40,33000.25,'2025-01-12'),
(3,'Tablet',25000.90,26000.75,'2025-01-15');

-- Discount amount
SELECT product_name, ABS(mrp - selling_price) AS discount_amount FROM product_sales;

-- Discount percentage
SELECT product_name, ROUND(((mrp - selling_price)/mrp)*100,2) AS discount_percentage FROM product_sales;

-- Day name of sale
SELECT product_name, DAYNAME(sale_date) AS sale_day FROM product_sales;

-- Proper case product name
SELECT product_name, INITCAP(product_name) AS proper_product_name FROM product_sales;

-- Discount validation
SELECT product_name, mrp, selling_price,
  CASE
  WHEN selling_price < mrp THEN 'Valid Discount'
  WHEN selling_price > mrp THEN 'Overpriced' 
  ELSE 'No Discount' END AS discount_status FROM product_sales;


-- ====================================================
--     QUESTION 8 Insurance Policy Aging
--=====================================================

CREATE TABLE insurance_policies (policy_id INT, holder_name VARCHAR(50), premium_amount DECIMAL(10,2), policy_start DATE, policy_end DATE);

INSERT INTO insurance_policies VALUES
(301,'arjun',12000.50,'2023-01-01','2026-01-01'),
(302,'megha',8500.75,'2022-06-15','2025-06-15'),
(303,'vinod',15000.90,'2021-03-01','2024-03-01');

-- Policy duration in years
SELECT holder_name, TIMESTAMPDIFF(YEAR,policy_start,policy_end) AS policy_duration_years FROM insurance_policies;

-- Remaining days
SELECT holder_name, DATEDIFF(policy_end,CURDATE()) AS remaining_days FROM insurance_policies;

-- Rounded premium
SELECT holder_name, ROUND(premium_amount) AS rounded_premium FROM insurance_policies;

-- Uppercase holder name
SELECT holder_name, UPPER(holder_name) AS upper_holder_name FROM insurance_policies;

-- Policy classification
SELECT holder_name, policy_end, 
  CASE 
  WHEN policy_end < CURDATE() THEN 'Expired'
  WHEN TIMESTAMPDIFF(YEAR,policy_start,policy_end) >= 3 THEN 'Long Term'
  ELSE 'Mid Term' END AS policy_status FROM insurance_policies;


-- ====================================================
--     QUESTION 9 Salary Increment Simulation
--=====================================================

CREATE TABLE salary_revision (emp_id INT, emp_name VARCHAR(50), current_salary DECIMAL(10,2), rating INT, last_hike DATE);

INSERT INTO salary_revision VALUES
(1,'karthik',75000.75,5,'2023-01-01'),
(2,'veena',65000.40,4,'2024-01-01'),
(3,'ravi',85000.90,3,'2022-01-01');

-- Years since last hike
SELECT emp_name, TIMESTAMPDIFF(YEAR,last_hike,CURDATE()) AS years_since_hike FROM salary_revision;

-- Increment using rating logic
SELECT emp_name, rating,
  CASE 
  WHEN rating = 5 THEN current_salary * 0.20 
  WHEN rating = 4 THEN current_salary * 0.10 
  WHEN rating = 3 THEN current_salary * 0.05
  ELSE 0 
  END AS increment_amount FROM salary_revision;

-- New salary rounded
SELECT emp_name, ROUND(current_salary + 
  CASE
  WHEN rating = 5 THEN current_salary * 0.20
  WHEN rating = 4 THEN current_salary * 0.10
  WHEN rating = 3 THEN current_salary * 0.05 ELSE 0 END) AS new_salary FROM salary_revision;

-- Lowercase employee name
SELECT emp_name, LOWER(emp_name) AS lower_name FROM salary_revision;

-- Increment classification
SELECT emp_name, rating,
  CASE
  WHEN rating = 5 THEN 'High Increment'
  WHEN rating IN (3,4) THEN 'Moderate'
  ELSE 'No Increment' END AS increment_status FROM salary_revision;

-- ====================================================
--     QUESTION 10 Customer Account Status Evaluation
--=====================================================

CREATE TABLE bank_accounts (account_id INT, customer_name VARCHAR(50), balance DECIMAL(12,2), last_transaction DATE, branch VARCHAR(30));

INSERT INTO bank_accounts VALUES
(501,'ramesh',125000.75,'2024-12-20','hyderabad'),
(502,'sita',8500.40,'2023-06-15','delhi'),
(503,'manoj',-2500.90,'2025-01-05','mumbai');

-- Absolute balance
SELECT customer_name, ABS(balance) AS absolute_balance FROM bank_accounts;

-- Days since last transaction
SELECT customer_name, DATEDIFF(CURDATE(),last_transaction) AS days_since_transaction FROM bank_accounts;

-- Proper case branch name
SELECT branch, INITCAP(branch) AS proper_branch_name FROM bank_accounts;

-- Sign of balance
SELECT customer_name, SIGN(balance) AS balance_sign FROM bank_accounts;

-- Account status classification
SELECT customer_name, balance, last_transaction,
  CASE
  WHEN balance < 0 THEN 'Overdrawn'
  WHEN DATEDIFF(CURDATE(),last_transaction) > 365 THEN 'Dormant' 
  ELSE 'Active' END AS account_status FROM bank_accounts;
