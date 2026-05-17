                                                       -- *******************************
                                                          -- NUMBER MANIPULATION FUNCTIONS
                                                        -- *******************************

-- table schema
CREATE TABLE employee_salary (
emp_id INT PRIMARY KEY,
emp_name VARCHAR(50),
base_salary DECIMAL(10,2),
bonus DECIMAL(10,2),
tax_percent DECIMAL(5,2),
experience_years INT
);

-- insert sample data
INSERT INTO employee_salary VALUES
(1, 'Karthik', 75000.75, 5000.50, 10.00, 6),
(2, 'Veena', 65000.40, 4000.25, 8.50, 4),
(3, 'Ravi', 85000.90, 6000.75, 12.00, 8),
(4, 'Anil', 70000.10, NULL, 9.00, 5),
(5, 'Suresh', 60000.55, 3000.30, 7.50, 3);

-- 1. ABS – Absolute Value
SELECT ABS(-100);

-- 2. ROUND – Round to Decimals
SELECT ROUND(base_salary, 0)
FROM employee_salary;

SELECT ROUND(base_salary, 2)
FROM employee_salary;

-- 3. CEILING / CEIL – Round Up
SELECT CEIL(base_salary)
FROM employee_salary;

-- 4. FLOOR – Round Down
SELECT FLOOR(base_salary)
FROM employee_salary;

-- 5. TRUNCATE – Cut Decimals (No Rounding)
SELECT TRUNCATE(base_salary, 1)
FROM employee_salary;

-- 6. MOD – Remainder
SELECT MOD(experience_years, 2)
FROM employee_salary;

-- 7. POWER / POW – Exponent
SELECT POWER(2, 3);

SELECT POW(5, 2);

-- 8. SQRT – Square Root
SELECT SQRT(64);

-- 9. SIGN – Sign of Number
SELECT SIGN(base_salary)
FROM employee_salary;

-- 10. RAND – Random Number
SELECT RAND();

-- 11. FORMAT – Format Number as String
SELECT FORMAT(base_salary, 2)
FROM employee_salary;

-- 12. GREATEST – Maximum Value
SELECT emp_name,
GREATEST(base_salary, IFNULL(bonus, 0)) AS highest_value
FROM employee_salary;

-- 13. LEAST – Minimum Value
SELECT emp_name,
LEAST(base_salary, IFNULL(bonus, 0)) AS lowest_value
FROM employee_salary;
