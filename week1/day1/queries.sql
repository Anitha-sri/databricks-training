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


--++++++++++++++++++++++++
-- Aggregate Queries(5)
--++++++++++++++++++++++++

--16Q)  Select the total salary of all employees.
select sum(salary) from Employee;
--17Q   Select the average salary of employees.
select avg(salary) from Employee;
--18Q   Select the minimum salary in the Employee table.
select min(salary) from Employee;
--19Q    Select the number of employees in each department.
select department_id,count(*) from Employee group by department_id;
--20Q   Select the average salary of employees in each department.
select department_id,avg(salary) from Employee group by department_id;



--++++++++++++++++++++++++
-- Group by Queries(5)
--++++++++++++++++++++++++

--21. Select the total salary for each department.
select sum(salary) from Employee group by department_id;
--22. Select the average age of employees in each department.
select avg(age) from Employee group by department_id;
--23. Select the number of employees hired in each year.
select hire_date,count(*) from Employee group by hire_date;
--24. Select the highest salary in each department.
select department_id,max(salary) from Employee group by department_id;
--25. Select the department with the highest average salary.
SELECT department_id, AVG(salary) AS average_salary
FROM Employee
GROUP BY department_id
ORDER BY average_salary DESC
LIMIT 1;

--++++++++++++++++++++++++
-- HAVING Clause Queries(5)
--++++++++++++++++++++++++

--26Q) Select departments with more than 2 employees.
SELECT department_id, COUNT(*) AS employee_count FROM Employee GROUP BY department_id HAVING COUNT(*) > 2;
--27Q) Select departments with an average salary greater than 55000.
SELECT department_id, AVG(salary) AS avg_salary FROM Employee GROUP BY department_id HAVING AVG(salary) > 55000;
--28Q) Select years with more than 1 employee hired.
SELECT YEAR(hire_date) AS hire_year, COUNT(*) AS employee_count FROM Employee GROUP BY YEAR(hire_date) HAVING COUNT(*) > 1;
--29Q) Select departments with total salary less than 100000.
SELECT department_id, SUM(salary) AS total_salary FROM Employee GROUP BY department_id HAVING SUM(salary) < 100000;
--30Q) Select departments with maximum salary greater than 75000.
SELECT department_id, MAX(salary) AS highest_salary FROM Employee GROUP BY department_id HAVING MAX(salary) > 75000;


--++++++++++++++++++++++++
-- ORDER BY Queries(5)
--++++++++++++++++++++++++

--31Q) Select employees ordered by salary.
SELECT * FROM Employee ORDER BY salary ASC;
--32Q) Select employees ordered by age descending.
SELECT * FROM Employee ORDER BY age DESC;
--33Q) Select employees ordered by hire date.
SELECT * FROM Employee ORDER BY hire_date ASC;
--34Q) Select employees ordered by department and salary.
SELECT * FROM Employee ORDER BY department_id, salary ASC;
--35Q) Select departments ordered by total salary.
SELECT department_id, SUM(salary) AS total_salary FROM Employee GROUP BY department_id ORDER BY total_salary DESC;


--++++++++++++++++++++++++
-- JOIN Queries(10)
--++++++++++++++++++++++++

--36Q) Select employee names with department names.
SELECT e.name AS employee_name,d.name AS department_name FROM Employee e JOIN Department d ON e.department_id = d.department_id;
--37Q) Select project names with department names.
SELECT p.name AS project_name,d.name AS department_name FROM Project p JOIN Department d ON p.department_id = d.department_id;
--38Q) Select project names with employee names.
SELECT p.name AS project_name,e.name AS employee_name FROM Project pJOIN Employee e ON p.department_id = e.department_id;
--39Q) Select all employees and their departments.
SELECT e.name,d.name FROM Employee e LEFT JOIN Department d ON e.department_id = d.department_id;

--40Q) Select all departments and their employees.
SELECT d.name,e.name FROM Department d LEFT JOIN Employee e ON d.department_id = e.department_id;
--41Q) Select employees not assigned to any project.
SELECT e.name FROM Employee e LEFT JOIN Project p ON e.department_id = p.department_idWHERE p.project_id IS NULL;
--42Q) Select employees and number of projects.
SELECT e.name,COUNT(p.project_id) AS total_projects FROM Employee e LEFT JOIN Project p ON e.department_id = p.department_id GROUP BY e.name;
--43Q) Select departments with no employees.
SELECT d.name FROM Department d LEFT JOIN Employee e ON d.department_id = e.department_id WHERE e.emp_id IS NULL;
--44Q) Select employees in same department as John Doe.
SELECT name FROM Employee WHERE department_id = (SELECT department_id FROM Employee WHERE name = 'John Doe');
--45Q) Select department with highest average salary.
SELECT d.name,AVG(e.salary) AS avg_salary FROM Department d JOIN Employee e ON e.department_id = d.department_id GROUP BY d.name ORDER BY AVG(e.salary) DESC LIMIT 1;


--++++++++++++++++++++++++
-- Subquery Queries(10)
--++++++++++++++++++++++++

--46Q) Select employee with highest salary.
SELECT * FROM Employee WHERE salary = (SELECT MAX(salary)FROM Employee);
--47Q) Select employees earning above average salary.
SELECT *FROM Employee WHERE salary > (SELECT AVG(salary)FROM Employee);
--48Q) Select second highest salary.
SELECT MAX(salary) AS second_highest_salary FROM Employee WHERE salary < (SELECT MAX(salary) FROM Employee);
--49Q) Select department with most employees.
SELECT department_id, COUNT(*) AS employee_count FROM Employee GROUP BY department_id ORDER BY employee_count DESC LIMIT 1;
--50Q) Select employees earning above department average.
SELECT name, salary, department_id FROM Employee e WHERE salary > (SELECT AVG(salary) FROM Employee WHERE department_id = e.department_id);
--51Q) Select 3rd highest salary.
SELECT DISTINCT salary FROM Employee ORDER BY salary DESC LIMIT 1 OFFSET 2;
--52Q) Select employees older than all HR employees.
SELECT * FROM Employee WHERE age > ALL (SELECT age FROM Employee WHERE department_id = (SELECT department_id FROM Department WHERE Department.name = 'HR'));
--53Q) Select departments with average salary greater than 55000.
SELECT department_id FROM Employee GROUP BY department_id HAVING AVG(salary) > 55000;
--54Q) Select employees working in departments with at least 2 projects.
SELECT DISTINCT e.name FROM Employee e JOIN Project p ON e.department_id = p.department_id GROUP BY e.name, e.department_id HAVING COUNT(p.project_id) >= 2;
--55Q) Select employees hired on same date as Jane Smith.
SELECT name FROM Employee WHERE hire_date = (SELECT hire_date FROM Employee WHERE name = 'Jane Smith');


--++++++++++++++++++++++++
-- Advanced Queries(10)
--++++++++++++++++++++++++

--56Q) Select total salary of employees hired in 2020.
SELECT SUM(salary) AS total_salary FROM Employee WHERE YEAR(hire_date) = 2020;
--57Q) Select average salary by department ordered descending.
SELECT department_id, AVG(salary) AS avg_salary FROM Employee GROUP BY department_id ORDER BY avg_salary DESC;
--58Q) Select departments with more than 1 employee and average salary above 55000.
SELECT department_id, COUNT(*) AS employee_count, AVG(salary) AS avg_salary FROM Employee GROUP BY department_id HAVING COUNT(*) > 1 AND AVG(salary) > 55000;
--59Q) Select employees hired in last 2 years.
SELECT * FROM Employee WHERE hire_date >= DATE_SUB(CURDATE(), INTERVAL 2 YEAR) ORDER BY hire_date ASC;
--60Q) Select total employees and average salary for departments with more than 2 employees.
SELECT department_id, COUNT(*) AS employee_count, AVG(salary) AS avg_salary FROM Employee GROUP BY department_id HAVING COUNT(*) > 2;
--61Q) Select employees earning above department average salary.
SELECT name, salary FROM Employee e WHERE salary > (SELECT AVG(salary) FROM Employee WHERE department_id = e.department_id);
--62Q) Select employees hired on earliest hire date.
SELECT name FROM Employee WHERE hire_date = (SELECT MIN(hire_date) FROM Employee);
--63Q) Select departments with total projects.
SELECT d.name, COUNT(p.project_id) AS total_projects FROM Department d LEFT JOIN Project p ON d.department_id = p.department_id GROUP BY d.name ORDER BY total_projects DESC;
--64Q) Select highest salary employee in each department.
SELECT e.name, e.department_id, e.salary FROM Employee e WHERE salary = (SELECT MAX(salary) FROM Employee WHERE department_id = e.department_id);
--65Q) Select employees older than department average age.
SELECT name, salary FROM Employee e WHERE age > (SELECT AVG(age) FROM Employee WHERE department_id = e.department_id);
