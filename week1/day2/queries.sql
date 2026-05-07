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
