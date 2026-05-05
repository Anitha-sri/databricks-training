## BASIC QUERIES(5)

-- Q1: Select all columns
SELECT * FROM Employee;
-- Q2: Select name and salary
SELECT name, salary FROM Employee;
-- Q3: Employees older than 30
SELECT * FROM Employee WHERE age > 30;
-- Q4: Names of all departments
SELECT name FROM Department;
-- Q5: Employees in IT department
SELECT e.name,e.age,e.department_id,d.name
FROM Employee e
JOIN Department d ON e.department_id = d.department_id
WHERE d.name = 'IT';


## STRING QUERIES(5)

-- Q6: Names start with 'J'
SELECT * FROM Employee WHERE name LIKE 'J%';
-- Q7: Names end with 'e'
SELECT * FROM Employee WHERE name LIKE '%e';
-- Q8: Names contain 'a'
SELECT * FROM Employee WHERE name LIKE '%a%';
-- Q9: Names with length 9
SELECT * FROM Employee WHERE LENGTH(name) = 9;
-- Q10: Second letter 'o'
SELECT * FROM Employee WHERE name LIKE '_o%';


-- DATE QUERIES(5)

-- Q11: Hired in 2020
SELECT * FROM Employee WHERE YEAR(hire_date) = 2020;
-- Q12: Hired in January
SELECT * FROM Employee WHERE MONTH(hire_date) = 1;
-- Q13: Hired before 2019
SELECT * FROM Employee WHERE hire_date < '2019-01-01';
-- Q14: Hired after March 1, 2021
SELECT * FROM Employee WHERE hire_date >= '2021-03-01';
-- Q15: Hired in last 2 years
SELECT * FROM Employee
WHERE hire_date >= DATE_SUB(CURDATE(), INTERVAL 2 YEAR);
