                                                  --****************************************
                                                                   LEVEL 1                    
                                                   --***************************************

-- ====================================================
--     QUESTION 1 Salary Risk Flagging Based on Tax Shock
--=====================================================

-- table creation
CREATE TABLE salary_audit (emp_id INT, emp_name VARCHAR(50), salary DECIMAL(10,2), tax_percent DECIMAL(5,2), last_revision DATE);

-- Insert Data
INSERT INTO salary_audit VALUES
(1,'karthik',75000.75,10.5,'2022-01-15'),
(2,'veena',65000.40,18.0,'2023-06-01'),
(3,'ravi',85000.90,25.0,'2020-11-20');

-- Normalize name to lowercase
SELECT emp_name, LOWER(emp_name) AS lower_name FROM salary_audit;

-- Calculate net salary after tax and round it
SELECT emp_name, ROUND(salary - (salary * tax_percent / 100)) AS net_salary FROM salary_audit;

-- Extract revision year
SELECT emp_name, EXTRACT(YEAR FROM last_revision) AS revision_year FROM salary_audit;

-- Find months since revision
SELECT emp_name, DATE_PART('month', AGE(CURRENT_DATE,last_revision)) + DATE_PART('year', AGE(CURRENT_DATE,last_revision))*12 AS months_since_revision FROM salary_audit;

-- Salary risk classification
SELECT emp_name, tax_percent,
CASE
WHEN tax_percent > 20 AND (DATE_PART('month', AGE(CURRENT_DATE,last_revision)) + DATE_PART('year', AGE(CURRENT_DATE,last_revision))*12) > 24 THEN 'Flag Tax Shock'
WHEN tax_percent BETWEEN 15 AND 20 THEN 'Flag Review Needed'
ELSE 'Stable'
END AS risk_status
FROM salary_audit;

-- ====================================================
--     QUESTION 2 Bonus Abuse Detection
--=====================================================

-- table creation
CREATE TABLE bonus_monitor (emp_code INT, emp_name VARCHAR(50), base_salary DECIMAL(10,2), bonus DECIMAL(10,2), bonus_date DATE);

-- Insert Data
INSERT INTO bonus_monitor VALUES
(101,'Anil',70000.10,30000.00,'2025-01-10'),
(102,'Suresh',60000.55,3000.30,'2024-03-15'),
(103,'Ravi',85000.90,15000.75,'2023-12-01');

-- Convert name to proper case
SELECT emp_name, INITCAP(emp_name) AS proper_name FROM bonus_monitor;

-- Calculate bonus percentage
SELECT emp_name, ROUND((bonus/base_salary)*100,2) AS bonus_percentage FROM bonus_monitor;

-- Extract day name
SELECT emp_name, TO_CHAR(bonus_date,'Day') AS day_name FROM bonus_monitor;

-- Find salary bonus difference
SELECT emp_name, ABS(base_salary - bonus) AS difference_amount FROM bonus_monitor;

-- Bonus abuse classification
SELECT emp_name,
CASE
WHEN (bonus/base_salary)*100 > 30 AND TO_CHAR(bonus_date,'Day') IN ('Saturday ','Sunday   ') THEN 'Suspicious'
WHEN (bonus/base_salary)*100 <= 20 THEN 'Normal'
ELSE 'Audit'
END AS bonus_status
FROM bonus_monitor;

-- ====================================================
--     QUESTION 3 Experience Parity Validation
--=====================================================

-- table creation
CREATE TABLE employee_experience (emp_id INT, emp_name VARCHAR(50), joining_date DATE, declared_experience INT, salary DECIMAL(10,2));

-- Insert Data
INSERT INTO employee_experience VALUES
(1,'Veena','2018-07-01',4,65000.40),
(2,'Ravi','2014-01-10',12,85000.90),
(3,'Anil','2020-09-01',3,70000.10);

-- Uppercase name
SELECT emp_name, UPPER(emp_name) AS upper_name FROM employee_experience;

-- Actual experience
SELECT emp_name, DATE_PART('year', AGE(CURRENT_DATE,joining_date)) AS actual_experience FROM employee_experience;

-- Difference between declared and actual experience
SELECT emp_name, ABS(declared_experience - DATE_PART('year', AGE(CURRENT_DATE,joining_date))) AS experience_difference FROM employee_experience;

-- Floor salary
SELECT emp_name, FLOOR(salary) AS floor_salary FROM employee_experience;

-- Experience validation
SELECT emp_name,
CASE
WHEN declared_experience > DATE_PART('year', AGE(CURRENT_DATE,joining_date)) THEN 'Overstated'
WHEN declared_experience < DATE_PART('year', AGE(CURRENT_DATE,joining_date)) THEN 'Understated'
ELSE 'Matched'
END AS experience_status
FROM employee_experience;

-- ====================================================
--     QUESTION 4 Salary Digit Pattern Analysis
--=====================================================

-- table creation
CREATE TABLE salary_digits (emp_id INT, emp_name VARCHAR(50), salary DECIMAL(10,2), credit_date DATE);

-- Insert Data
INSERT INTO salary_digits VALUES
(1,'Karthik',75000.75,'2025-01-01'),
(2,'Veena',65000.40,'2025-01-02'),
(3,'Suresh',60000.55,'2025-01-03');

-- Last two characters of name
SELECT emp_name, RIGHT(emp_name,2) AS last_two_chars FROM salary_digits;

-- Day of month
SELECT emp_name, EXTRACT(DAY FROM credit_date) AS day_of_month FROM salary_digits;

-- Truncate salary
SELECT emp_name, TRUNC(salary) AS truncated_salary FROM salary_digits;

-- MOD on salary
SELECT emp_name, MOD(TRUNC(salary),10) AS salary_mod FROM salary_digits;

-- Pattern classification
SELECT emp_name,
CASE
WHEN MOD(TRUNC(salary),10)=EXTRACT(DAY FROM credit_date) THEN 'Pattern Match'
ELSE 'No Match'
END AS pattern_status
FROM salary_digits;

-- ====================================================
--     QUESTION 5 Odd Even Salary Compliance
--=====================================================

-- table creation
CREATE TABLE payroll_control (emp_id INT, emp_name VARCHAR(50), salary DECIMAL(10,2), payment_date DATE);

-- Insert Data
INSERT INTO payroll_control VALUES
(1,'Ravi',85000.90,'2025-01-15'),
(2,'Anil',70000.10,'2025-01-16'),
(3,'Veena',65000.40,'2025-01-17');

-- Lowercase name
SELECT emp_name, LOWER(emp_name) AS lower_name FROM payroll_control;

-- Extract weekday
SELECT emp_name, TO_CHAR(payment_date,'Day') AS weekday_name FROM payroll_control;

-- Round salary
SELECT emp_name, ROUND(salary) AS rounded_salary FROM payroll_control;

-- Apply MOD on salary
SELECT emp_name, MOD(ROUND(salary),2) AS salary_mod FROM payroll_control;

-- Compliance classification
SELECT emp_name,
CASE
WHEN MOD(ROUND(salary),2)=0 AND MOD(EXTRACT(DAY FROM payment_date),2)=1 THEN 'Violation'
ELSE 'Compliant'
END AS compliance_status
FROM payroll_control;

-- ====================================================
--     QUESTION 6 Salary Inflation Drift
--=====================================================

-- table creation
CREATE TABLE inflation_watch (emp_id INT, emp_name VARCHAR(50), salary DECIMAL(10,2), last_hike DATE);

-- Insert Data
INSERT INTO inflation_watch VALUES
(1,'Karthik',75000.75,'2019-01-01'),
(2,'Veena',65000.40,'2022-01-01'),
(3,'Ravi',85000.90,'2017-01-01');

-- Proper case name
SELECT emp_name, INITCAP(emp_name) AS proper_name FROM inflation_watch;

-- Years since hike
SELECT emp_name, DATE_PART('year', AGE(CURRENT_DATE,last_hike)) AS years_since_hike FROM inflation_watch;

-- Apply POWER function
SELECT emp_name, POWER(2, DATE_PART('year', AGE(CURRENT_DATE,last_hike))) AS power_value FROM inflation_watch;

-- Round salary impact
SELECT emp_name, ROUND(salary * POWER(1.05, DATE_PART('year', AGE(CURRENT_DATE,last_hike)))) AS salary_impact FROM inflation_watch;

-- Inflation classification
SELECT emp_name,
CASE
WHEN DATE_PART('year', AGE(CURRENT_DATE,last_hike)) > 5 THEN 'High Inflation Risk'
WHEN DATE_PART('year', AGE(CURRENT_DATE,last_hike)) BETWEEN 3 AND 5 THEN 'Moderate'
ELSE 'Low'
END AS inflation_status
FROM inflation_watch;

-- ====================================================
--     QUESTION 7 Salary Sign Integrity Check
--=====================================================

-- table creation
CREATE TABLE salary_integrity (emp_id INT, emp_name VARCHAR(50), salary DECIMAL(10,2), record_date DATE);

-- Insert Data
INSERT INTO salary_integrity VALUES
(1,'Anil',-70000.10,'2025-01-10'),
(2,'Veena',65000.40,'2025-01-10'),
(3,'Ravi',0.00,'2025-01-10');

-- Uppercase name
SELECT emp_name, UPPER(emp_name) AS upper_name FROM salary_integrity;

-- Extract year
SELECT emp_name, EXTRACT(YEAR FROM record_date) AS record_year FROM salary_integrity;

-- Apply SIGN on salary
SELECT emp_name, SIGN(salary) AS salary_sign FROM salary_integrity;

-- Absolute salary
SELECT emp_name, ABS(salary) AS absolute_salary FROM salary_integrity;

-- Salary integrity classification
SELECT emp_name,
CASE
WHEN salary < 0 THEN 'Negative Error'
WHEN salary = 0 THEN 'Zero Salary'
ELSE 'Valid'
END AS salary_status
FROM salary_integrity;

-- ====================================================
--     QUESTION 8 Name Length vs Salary Correlation
--=====================================================

-- table creation
CREATE TABLE name_salary (emp_id INT, emp_name VARCHAR(50), salary DECIMAL(10,2), join_date DATE);

-- Insert Data
INSERT INTO name_salary VALUES
(1,'Karthik',75000.75,'2019-03-15'),
(2,'Veena',65000.40,'2021-06-20'),
(3,'Ravi',85000.90,'2016-01-10');

-- Name length
SELECT emp_name, LENGTH(emp_name) AS name_length FROM name_salary;

-- Years of service
SELECT emp_name, DATE_PART('year', AGE(CURRENT_DATE,join_date)) AS years_of_service FROM name_salary;

-- Round salary
SELECT emp_name, ROUND(salary) AS rounded_salary FROM name_salary;

-- Name bias classification
SELECT emp_name,
CASE
WHEN LENGTH(emp_name) > DATE_PART('year', AGE(CURRENT_DATE,join_date)) THEN 'Name Bias'
ELSE 'Neutral'
END AS bias_status
FROM name_salary;


-- ====================================================
--     QUESTION 9 Salary Spike Detection by Month
--=====================================================

-- table creation
CREATE TABLE salary_monthly (emp_id INT, emp_name VARCHAR(50), salary DECIMAL(10,2), paid_date DATE);

-- Insert Data
INSERT INTO salary_monthly VALUES
(1,'Karthik',75000.75,'2025-01-31'),
(2,'Veena',65000.40,'2025-02-28'),
(3,'Ravi',85000.90,'2025-03-31');

-- Extract month name
SELECT emp_name, TO_CHAR(paid_date,'Month') AS month_name FROM salary_monthly;

-- CEIL salary
SELECT emp_name, CEIL(salary) AS ceil_salary FROM salary_monthly;

-- Check last day of month
SELECT emp_name, paid_date, (DATE_TRUNC('MONTH',paid_date) + INTERVAL '1 MONTH - 1 day')::DATE AS last_day FROM salary_monthly;

-- Salary spike classification
SELECT emp_name,
CASE
WHEN paid_date = (DATE_TRUNC('MONTH',paid_date) + INTERVAL '1 MONTH - 1 day')::DATE THEN 'End Month Spike'
ELSE 'Regular'
END AS salary_status
FROM salary_monthly;

-- ====================================================
--     QUESTION 10 Salary Digit Sum Audit
--=====================================================

-- table creation
CREATE TABLE digit_audit (emp_id INT, emp_name VARCHAR(50), salary DECIMAL(10,2), audit_date DATE);

-- Insert Data
INSERT INTO digit_audit VALUES
(1,'Anil',70000.10,'2025-01-01'),
(2,'Veena',65000.40,'2025-01-02');

-- Extract first character
SELECT emp_name, LEFT(emp_name,1) AS first_character FROM digit_audit;

-- Truncate salary
SELECT emp_name, TRUNC(salary) AS truncated_salary FROM digit_audit;

-- Sum salary digits
SELECT emp_name,
(
SUBSTRING(TRUNC(salary)::TEXT,1,1)::INT +
SUBSTRING(TRUNC(salary)::TEXT,2,1)::INT +
SUBSTRING(TRUNC(salary)::TEXT,3,1)::INT +
SUBSTRING(TRUNC(salary)::TEXT,4,1)::INT +
SUBSTRING(TRUNC(salary)::TEXT,5,1)::INT
) AS digit_sum
FROM digit_audit;

-- Extract day
SELECT emp_name, EXTRACT(DAY FROM audit_date) AS audit_day FROM digit_audit;

-- Digit audit classification
SELECT emp_name,
CASE
WHEN (
SUBSTRING(TRUNC(salary)::TEXT,1,1)::INT +
SUBSTRING(TRUNC(salary)::TEXT,2,1)::INT +
SUBSTRING(TRUNC(salary)::TEXT,3,1)::INT +
SUBSTRING(TRUNC(salary)::TEXT,4,1)::INT +
SUBSTRING(TRUNC(salary)::TEXT,5,1)::INT
) > 10 THEN 'Digit Alert'
ELSE 'Normal'
END AS audit_status
FROM digit_audit;

-- ====================================================
--     QUESTION 11 Weekend Salary Credit Fraud Detection
--=====================================================

-- table creation
CREATE TABLE salary_credit_audit (emp_id INT, emp_name VARCHAR(50), salary DECIMAL(10,2), credit_date DATE, bank_code VARCHAR(10));

-- Insert Data
INSERT INTO salary_credit_audit VALUES
(1,'Karthik',75000.75,'2025-01-04','HDFC01'),
(2,'Veena',65000.40,'2025-01-06','ICIC02'),
(3,'Ravi',85000.90,'2025-01-05','SBIN03'),
(4,'Anil',70000.10,'2025-01-07','AXIS04'),
(5,'Suresh',60000.55,'2025-01-11','HDFC01');

-- Extract bank prefix
SELECT emp_name, LEFT(bank_code,4) AS bank_prefix FROM salary_credit_audit;

-- Weekday name
SELECT emp_name, TO_CHAR(credit_date,'Day') AS weekday_name FROM salary_credit_audit;

-- Round salary
SELECT emp_name, ROUND(salary) AS rounded_salary FROM salary_credit_audit;

-- MOD salary
SELECT emp_name, MOD(ROUND(salary),5) AS salary_mod FROM salary_credit_audit;

-- Fraud detection
SELECT emp_name,
CASE
WHEN TO_CHAR(credit_date,'Day') IN ('Saturday ','Sunday   ') AND MOD(ROUND(salary),5)=0 THEN 'Weekend Fraud'
WHEN LEFT(bank_code,4)='HDFC' THEN 'Bank Review'
ELSE 'Normal'
END AS fraud_status
FROM salary_credit_audit;

-- ====================================================
--     QUESTION 12 Salary Credit Time Drift Analysis
--=====================================================

-- table creation
CREATE TABLE salary_time_drift (emp_id INT, emp_name VARCHAR(50), salary DECIMAL(10,2), credit_ts TIMESTAMP);

-- Insert Data
INSERT INTO salary_time_drift VALUES
(1,'Karthik',75000.75,'2025-01-10 23:45:00'),
(2,'Veena',65000.40,'2025-01-10 09:15:00'),
(3,'Ravi',85000.90,'2025-01-11 00:10:00'),
(4,'Anil',70000.10,'2025-01-09 18:30:00'),
(5,'Suresh',60000.55,'2025-01-10 02:50:00');

-- Extract hour
SELECT emp_name, EXTRACT(HOUR FROM credit_ts) AS credit_hour FROM salary_time_drift;

-- Lowercase name
SELECT emp_name, LOWER(emp_name) AS lower_name FROM salary_time_drift;

-- Floor salary
SELECT emp_name, FLOOR(salary) AS floor_salary FROM salary_time_drift;

-- Difference between salary and hour
SELECT emp_name, FLOOR(salary) - EXTRACT(HOUR FROM credit_ts) AS salary_hour_difference FROM salary_time_drift;

-- Drift classification
SELECT emp_name,
CASE
WHEN EXTRACT(HOUR FROM credit_ts) BETWEEN 0 AND 3 THEN 'Midnight Drift'
WHEN EXTRACT(HOUR FROM credit_ts) > 18 THEN 'After Hours'
ELSE 'Business Hours'
END AS drift_status
FROM salary_time_drift;

-- ====================================================
--     QUESTION 13 Salary Decimal Precision Audit
--=====================================================

-- table creation
CREATE TABLE salary_precision (emp_id INT, emp_name VARCHAR(50), salary DECIMAL(10,4), record_date DATE);

-- Insert Data
INSERT INTO salary_precision VALUES
(1,'Karthik',75000.7567,'2025-01-01'),
(2,'Veena',65000.4044,'2025-01-02'),
(3,'Ravi',85000.9099,'2025-01-03'),
(4,'Anil',70000.1001,'2025-01-04'),
(5,'Suresh',60000.5555,'2025-01-05');

-- Truncate salary
SELECT emp_name, TRUNC(salary,2) AS truncated_salary FROM salary_precision;

-- Difference between rounded and truncated
SELECT emp_name, ROUND(salary,2) - TRUNC(salary,2) AS precision_difference FROM salary_precision;

-- Extract day name
SELECT emp_name, TO_CHAR(record_date,'Day') AS day_name FROM salary_precision;

-- Length of employee name
SELECT emp_name, LENGTH(emp_name) AS name_length FROM salary_precision;

-- Precision audit classification
SELECT emp_name,
CASE
WHEN ROUND(salary,2) - TRUNC(salary,2) > 0.01 THEN 'Precision Loss'
ELSE 'Safe'
END AS precision_status
FROM salary_precision;

-- ====================================================
--     QUESTION 14 Salary Growth Power Index
--=====================================================

-- table creation
CREATE TABLE salary_growth (emp_id INT, emp_name VARCHAR(50), base_salary DECIMAL(10,2), growth_rate DECIMAL(5,2), last_hike DATE);

-- Insert Data
INSERT INTO salary_growth VALUES
(1,'Karthik',75000.75,1.08,'2019-01-01'),
(2,'Veena',65000.40,1.05,'2021-01-01'),
(3,'Ravi',85000.90,1.12,'2017-01-01'),
(4,'Anil',70000.10,1.03,'2022-01-01'),
(5,'Suresh',60000.55,1.06,'2020-01-01');

-- Years since hike
SELECT emp_name, DATE_PART('year', AGE(CURRENT_DATE,last_hike)) AS years_since_hike FROM salary_growth;

-- Apply POWER function
SELECT emp_name, POWER(growth_rate, DATE_PART('year', AGE(CURRENT_DATE,last_hike))) AS growth_power FROM salary_growth;

-- Projected salary
SELECT emp_name, ROUND(base_salary * POWER(growth_rate, DATE_PART('year', AGE(CURRENT_DATE,last_hike)))) AS projected_salary FROM salary_growth;

-- Uppercase name
SELECT emp_name, UPPER(emp_name) AS upper_name FROM salary_growth;

-- Growth classification
SELECT emp_name,
CASE
WHEN ROUND(base_salary * POWER(growth_rate, DATE_PART('year', AGE(CURRENT_DATE,last_hike)))) > 150000 THEN 'Explosive Growth'
WHEN ROUND(base_salary * POWER(growth_rate, DATE_PART('year', AGE(CURRENT_DATE,last_hike)))) BETWEEN 80000 AND 150000 THEN 'Controlled'
ELSE 'Stagnant'
END AS growth_status
FROM salary_growth;

-- ====================================================
--     QUESTION 15 Salary Symmetry Check
--=====================================================

-- table creation
CREATE TABLE salary_symmetry (emp_id INT, emp_name VARCHAR(50), salary DECIMAL(10,2), processed_date DATE);

-- Insert Data
INSERT INTO salary_symmetry VALUES
(1,'Karthik',75557.75,'2025-01-15'),
(2,'Veena',64446.40,'2025-01-16'),
(3,'Ravi',85858.90,'2025-01-17'),
(4,'Anil',70007.10,'2025-01-18'),
(5,'Suresh',60000.55,'2025-01-19');

-- Remove decimals
SELECT emp_name, REPLACE(TRUNC(salary)::TEXT,'.','') AS salary_digits FROM salary_symmetry;

-- Reverse salary digits
SELECT emp_name, REVERSE(REPLACE(TRUNC(salary)::TEXT,'.','')) AS reversed_salary FROM salary_symmetry;

-- Extract weekday
SELECT emp_name, TO_CHAR(processed_date,'Day') AS weekday_name FROM salary_symmetry;

-- Proper case employee name
SELECT emp_name, INITCAP(emp_name) AS proper_name FROM salary_symmetry;

-- Symmetry classification
SELECT emp_name,
CASE
WHEN REPLACE(TRUNC(salary)::TEXT,'.','') = REVERSE(REPLACE(TRUNC(salary)::TEXT,'.','')) THEN 'Symmetric Pay'
ELSE 'Asymmetric'
END AS symmetry_status
FROM salary_symmetry;

-- ====================================================
--     QUESTION 16 Leap Year Salary Adjustment Audit
--=====================================================

-- table creation
CREATE TABLE leap_salary (emp_id INT, emp_name VARCHAR(50), salary DECIMAL(10,2), credit_date DATE);

-- Insert Data
INSERT INTO leap_salary VALUES
(1,'Karthik',75000.75,'2024-02-29'),
(2,'Veena',65000.40,'2025-02-28'),
(3,'Ravi',85000.90,'2020-02-29'),
(4,'Anil',70000.10,'2023-02-28'),
(5,'Suresh',60000.55,'2024-02-28');

-- Extract year
SELECT emp_name, EXTRACT(YEAR FROM credit_date) AS credit_year FROM leap_salary;

-- Check leap year logic
SELECT emp_name,
CASE
WHEN (EXTRACT(YEAR FROM credit_date) % 4 = 0 AND EXTRACT(YEAR FROM credit_date) % 100 <> 0)
OR (EXTRACT(YEAR FROM credit_date) % 400 = 0)
THEN 'Leap Year'
ELSE 'Non Leap Year'
END AS leap_year_status
FROM leap_salary;

-- CEIL salary
SELECT emp_name, CEIL(salary) AS ceil_salary FROM leap_salary;

-- Calculate day of year
SELECT emp_name, EXTRACT(DOY FROM credit_date) AS day_of_year FROM leap_salary;

-- Leap credit classification
SELECT emp_name,
CASE
WHEN EXTRACT(MONTH FROM credit_date)=2 AND EXTRACT(DAY FROM credit_date)=29 THEN 'Leap Credit'
ELSE 'Non-Leap Credit'
END AS leap_credit_status
FROM leap_salary;

-- ====================================================
--     QUESTION 17 Fiscal Year Boundary Salary Check
--=====================================================

-- table creation
CREATE TABLE fiscal_salary (emp_id INT, emp_name VARCHAR(50), salary DECIMAL(10,2), credit_date DATE);

-- Insert Data
INSERT INTO fiscal_salary VALUES
(1,'Karthik',75000.75,'2025-03-31'),
(2,'Veena',65000.40,'2025-04-01'),
(3,'Ravi',85000.90,'2024-03-30'),
(4,'Anil',70000.10,'2024-04-02'),
(5,'Suresh',60000.55,'2025-03-29');

-- Determine fiscal year
SELECT emp_name,
CASE
WHEN EXTRACT(MONTH FROM credit_date) >= 4
THEN CONCAT(EXTRACT(YEAR FROM credit_date),'-',EXTRACT(YEAR FROM credit_date)+1)
ELSE CONCAT(EXTRACT(YEAR FROM credit_date)-1,'-',EXTRACT(YEAR FROM credit_date))
END AS fiscal_year
FROM fiscal_salary;

-- Extract month
SELECT emp_name, TO_CHAR(credit_date,'Month') AS month_name FROM fiscal_salary;

-- Format salary
SELECT emp_name, TO_CHAR(salary,'99,99,999.99') AS formatted_salary FROM fiscal_salary;

-- Lowercase employee name
SELECT emp_name, LOWER(emp_name) AS lower_name FROM fiscal_salary;

-- Fiscal year classification
SELECT emp_name,
CASE
WHEN EXTRACT(MONTH FROM credit_date)=3 THEN 'Year End Credit'
WHEN EXTRACT(MONTH FROM credit_date)=4 THEN 'Year Start Credit'
ELSE 'Mid Year'
END AS fiscal_status
FROM fiscal_salary;

-- ====================================================
--     QUESTION 18 Salary Random Sampling for Audit
--=====================================================

-- table creation
CREATE TABLE salary_sampling (emp_id INT, emp_name VARCHAR(50), salary DECIMAL(10,2), record_date DATE);

-- Insert Data
INSERT INTO salary_sampling VALUES
(1,'Karthik',75000.75,'2025-01-01'),
(2,'Veena',65000.40,'2025-01-02'),
(3,'Ravi',85000.90,'2025-01-03'),
(4,'Anil',70000.10,'2025-01-04'),
(5,'Suresh',60000.55,'2025-01-05'),
(6,'Amit',72000.60,'2025-01-06'),
(7,'Neha',68000.80,'2025-01-07');

-- Generate random value
SELECT emp_name, RANDOM() AS random_value FROM salary_sampling;

-- Round salary
SELECT emp_name, ROUND(salary) AS rounded_salary FROM salary_sampling;

-- Extract day name
SELECT emp_name, TO_CHAR(record_date,'Day') AS day_name FROM salary_sampling;

-- Extract first character
SELECT emp_name, LEFT(emp_name,1) AS first_character FROM salary_sampling;

-- Sampling classification
SELECT emp_name,
CASE
WHEN RANDOM() > 0.7 THEN 'Sampled'
ELSE 'Skipped'
END AS sampling_status
FROM salary_sampling;

-- ====================================================
--     QUESTION 19 Salary ASCII Integrity Check
--=====================================================

-- table creation
CREATE TABLE salary_ascii (emp_id INT, emp_name VARCHAR(50), salary DECIMAL(10,2), join_date DATE);

-- Insert Data
INSERT INTO salary_ascii VALUES
(1,'Karthik',75000.75,'2019-03-15'),
(2,'Veena',65000.40,'2021-06-20'),
(3,'Ravi',85000.90,'2016-01-10'),
(4,'Anil',70000.10,'2020-09-01'),
(5,'Suresh',60000.55,'2022-11-25');

-- ASCII value of first character
SELECT emp_name, ASCII(LEFT(emp_name,1)) AS ascii_value FROM salary_ascii;

-- Years since joining
SELECT emp_name, DATE_PART('year', AGE(CURRENT_DATE,join_date)) AS years_since_joining FROM salary_ascii;

-- Floor salary
SELECT emp_name, FLOOR(salary) AS floor_salary FROM salary_ascii;

-- ASCII integrity classification
SELECT emp_name,
CASE
WHEN ASCII(LEFT(emp_name,1)) > DATE_PART('year', AGE(CURRENT_DATE,join_date)) THEN 'Name Dominates'
ELSE 'Experience Dominates'
END AS integrity_status
FROM salary_ascii;

-- ====================================================
--     QUESTION 20 Salary vs Calendar Symmetry Logic
--=====================================================

-- table creation
CREATE TABLE salary_calendar (emp_id INT, emp_name VARCHAR(50), salary DECIMAL(10,2), credit_date DATE);

-- Insert Data
INSERT INTO salary_calendar VALUES
(1,'Karthik',75000.75,'2025-01-15'),
(2,'Veena',65000.40,'2025-02-14'),
(3,'Ravi',85000.90,'2025-03-31'),
(4,'Anil',70000.10,'2025-04-04'),
(5,'Suresh',60000.55,'2025-05-05');

-- Extract day and month
SELECT emp_name, EXTRACT(DAY FROM credit_date) AS day_value, EXTRACT(MONTH FROM credit_date) AS month_value FROM salary_calendar;

-- Extract last two digits of salary
SELECT emp_name, RIGHT(TRUNC(salary)::TEXT,2) AS last_two_digits FROM salary_calendar;

-- Uppercase employee name
SELECT emp_name, UPPER(emp_name) AS upper_name FROM salary_calendar;

-- Absolute difference between day and month
SELECT emp_name, ABS(EXTRACT(DAY FROM credit_date) - EXTRACT(MONTH FROM credit_date)) AS difference_value FROM salary_calendar;

-- Calendar symmetry classification
SELECT emp_name,
CASE
WHEN EXTRACT(DAY FROM credit_date)=EXTRACT(MONTH FROM credit_date)
OR RIGHT(TRUNC(salary)::TEXT,2)=LPAD(EXTRACT(MONTH FROM credit_date)::TEXT,2,'0')
THEN 'Calendar Match'
ELSE 'Calendar Drift'
END AS calendar_status
FROM salary_calendar;
