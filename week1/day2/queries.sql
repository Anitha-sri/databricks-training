--++++++++++++++++++++++++
-- Aggregate Queries(5)
--++++++++++++++++++++++++

--15Q) Find minimum experience department-wise.
SELECT department, MIN(experience) AS min_experience FROM Employees GROUP BY department;
--16Q) Find departments having more than 3 employees.
SELECT department, COUNT(*) AS employee_count FROM Employees GROUP BY department HAVING COUNT(*) > 3;
--17Q) Find departments where average salary is greater than 60000.
SELECT department, AVG(salary) AS average_salary FROM Employees GROUP BY department HAVING AVG(salary) > 60000;
--18Q) Find cities having more than 2 employees.
SELECT city, COUNT(*) AS employee_count FROM Employees GROUP BY city HAVING COUNT(*) > 2;
--19Q) Find departments where total salary is greater than 200000.
SELECT department, SUM(salary) AS total_salary FROM Employees GROUP BY department HAVING SUM(salary) > 200000;
--20Q) Find departments where maximum salary is above 90000.
SELECT department, MAX(salary) AS max_salary FROM Employees GROUP BY department HAVING MAX(salary) > 90000;


--++++++++++++++++++++++++
-- TOP Queries(5)
--++++++++++++++++++++++++

--21Q) Display top 5 highest paid employees.
SELECT * FROM Employees ORDER BY salary DESC LIMIT 5;
--22Q) Display top 3 employees with highest experience.
SELECT * FROM Employees ORDER BY experience DESC LIMIT 3;
--23Q) Display top 2 salaries from Finance department.
SELECT * FROM Employees WHERE department = 'Finance' ORDER BY salary DESC LIMIT 2;
--24Q) Display top 4 employees from Hyderabad.
SELECT * FROM Employees WHERE city = 'Hyderabad' LIMIT 4;
--25Q) Display top 1 highest salary employee.
SELECT * FROM Employees ORDER BY salary DESC LIMIT 1;

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
SELECT e.name AS employee_name, d.name AS department_name FROM Employee e JOIN Department d ON e.department_id = d.department_id;
--37Q) Select project names with department names.
SELECT p.name AS project_name, d.name AS department_name FROM Project p JOIN Department d ON p.department_id = d.department_id;
--38Q) Select project names with employee names.
SELECT p.name AS project_name, e.name AS employee_name FROM Project p JOIN Employee e ON p.department_id = e.department_id;
--39Q) Select all employees and their departments.
SELECT e.name, d.name FROM Employee e LEFT JOIN Department d ON e.department_id = d.department_id;
--40Q) Select all departments and their employees.
SELECT d.name, e.name FROM Department d LEFT JOIN Employee e ON d.department_id = e.department_id;
--41Q) Select employees not assigned to any project.
SELECT e.name FROM Employee e LEFT JOIN Project p ON e.department_id = p.department_id WHERE p.project_id IS NULL;
--42Q) Select employees and number of projects.
SELECT e.name, COUNT(p.project_id) AS total_projects FROM Employee e LEFT JOIN Project p ON e.department_id = p.department_id GROUP BY e.name;
--43Q) Select departments with no employees.
SELECT d.name FROM Department d LEFT JOIN Employee e ON d.department_id = e.department_id WHERE e.emp_id IS NULL;
--44Q) Select employees in same department as John Doe.
SELECT name FROM Employee WHERE department_id = (SELECT department_id FROM Employee WHERE name = 'John Doe');
--45Q) Select department with highest average salary.
SELECT d.name, AVG(e.salary) AS avg_salary FROM Department d JOIN Employee e ON e.department_id = d.department_id GROUP BY d.name ORDER BY AVG(e.salary) DESC LIMIT 1;


--++++++++++++++++++++++++
-- Subquery Queries(10)
--++++++++++++++++++++++++

--46Q) Select employee with highest salary.
SELECT * FROM Employee WHERE salary = (SELECT MAX(salary) FROM Employee);
--47Q) Select employees earning above average salary.
SELECT * FROM Employee WHERE salary > (SELECT AVG(salary) FROM Employee);
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
