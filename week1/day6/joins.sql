                                                     --*************************
                                                               JOINS
                                                     --**************************


--table schema
CREATE TABLE employees (
emp_id INT PRIMARY KEY,
emp_name VARCHAR(50),
manager_id INT,
dept_id INT
);

INSERT INTO employees (emp_id, emp_name, manager_id, dept_id) VALUES
(1, 'Karthik', NULL, 1),
(2, 'Ajay', 1, 1),
(3, 'Vijay', 1, 2),
(4, 'Vinay', 2, 2),
(5, 'Meena', 3, 3),
(6, 'Veer', NULL, 4),
(7, 'Keerthi', 4, 5),
(8, 'Priya', 4, 5);

CREATE TABLE departments (
dept_id INT PRIMARY KEY,
dept_name VARCHAR(50)
);

INSERT INTO departments (dept_id, dept_name) VALUES
(1, 'HR'),
(2, 'IT'),
(3, 'Finance'),
(4, 'Marketing'),
(5, 'Sales');

CREATE TABLE projects (
project_id INT PRIMARY KEY,
project_name VARCHAR(50),
emp_id INT
);

INSERT INTO projects (project_id, project_name, emp_id) VALUES
(1, 'Project A', 1),
(2, 'Project B', 2),
(3, 'Project C', 3),
(4, 'Project D', 4),
(5, 'Project E', 5);

-- 1. Retrieve employee names and their managers including employees without managers
SELECT e.emp_name AS employee_name,
m.emp_name AS manager_name
FROM employees e
LEFT JOIN employees m
ON e.manager_id = m.emp_id;

-- 2. Display all employees and their departments including employees without department
SELECT e.emp_name,
d.dept_name
FROM employees e
LEFT JOIN departments d
ON e.dept_id = d.dept_id;

-- 3. List employees who report to managers with manager names
SELECT e.emp_name AS employee_name,
m.emp_name AS manager_name
FROM employees e
INNER JOIN employees m
ON e.manager_id = m.emp_id;

-- 4. Find employees and their departments including departments without employees
SELECT d.dept_name,
e.emp_name
FROM departments d
LEFT JOIN employees e
ON d.dept_id = e.dept_id;

-- 5. Display employees who do not belong to any department
SELECT e.emp_name
FROM employees e
LEFT JOIN departments d
ON e.dept_id = d.dept_id
WHERE d.dept_id IS NULL;

-- 6. Fetch employees and their projects including employees without projects
SELECT e.emp_name,
p.project_name
FROM employees e
LEFT JOIN projects p
ON e.emp_id = p.emp_id;

-- 7. List employees who completed at least one project
SELECT e.emp_name,
p.project_name
FROM employees e
INNER JOIN projects p
ON e.emp_id = p.emp_id;

-- 8. Show all projects and employees ensuring no project is omitted
SELECT e.emp_name,
p.project_name
FROM employees e
RIGHT JOIN projects p
ON e.emp_id = p.emp_id;

-- 9. Find employees and salary records showing NULL for missing salary
SELECT e.emp_name,
NULL AS salary
FROM employees e;

-- 10. Retrieve employees and department names including employees without departments
SELECT e.emp_name,
d.dept_name
FROM employees e
LEFT JOIN departments d
ON e.dept_id = d.dept_id;

-- 11. Find all departments and employees including departments without employees
SELECT d.dept_name,
e.emp_name
FROM departments d
LEFT JOIN employees e
ON d.dept_id = e.dept_id;

-- 12. List employees with contact information including missing contacts
SELECT e.emp_name,
NULL AS contact_info
FROM employees e;

-- 13. Show employees and department names including unmatched records
SELECT e.emp_name,
d.dept_name
FROM employees e
FULL OUTER JOIN departments d
ON e.dept_id = d.dept_id;

-- 14. Find employees who have not completed any project
SELECT e.emp_name,
p.project_name
FROM employees e
LEFT JOIN projects p
ON e.emp_id = p.emp_id
WHERE p.project_id IS NULL;

-- 15. Retrieve employees and their project names including employees without projects
SELECT e.emp_name,
p.project_name
FROM employees e
LEFT JOIN projects p
ON e.emp_id = p.emp_id;

-- 16. List all projects and assigned employees including projects without employees
SELECT p.project_name,
e.emp_name
FROM projects p
LEFT JOIN employees e
ON p.emp_id = e.emp_id;

-- 17. Show employees with both manager and project
SELECT e.emp_name AS employee_name,
m.emp_name AS manager_name,
p.project_name
FROM employees e
INNER JOIN employees m
ON e.manager_id = m.emp_id
INNER JOIN projects p
ON e.emp_id = p.emp_id;

-- 18. List employees and departments excluding employees without departments
SELECT e.emp_name,
d.dept_name
FROM employees e
INNER JOIN departments d
ON e.dept_id = d.dept_id;

-- 19. Display employees and department names
SELECT e.emp_name,
d.dept_name
FROM employees e
INNER JOIN departments d
ON e.dept_id = d.dept_id;

-- 20. List all departments and employees including empty departments
SELECT d.dept_name,
e.emp_name
FROM departments d
LEFT JOIN employees e
ON d.dept_id = e.dept_id;

-- 21. Retrieve employees with projects but without departments
SELECT e.emp_name,
p.project_name
FROM employees e
INNER JOIN projects p
ON e.emp_id = p.emp_id
WHERE e.dept_id IS NULL;

-- 22. Find total employees in each department including empty departments
SELECT d.dept_name,
COUNT(e.emp_id) AS total_employees
FROM departments d
LEFT JOIN employees e
ON d.dept_id = e.dept_id
GROUP BY d.dept_name;

-- 23. Show employees who report to managers only
SELECT e.emp_name AS employee_name,
m.emp_name AS manager_name
FROM employees e
INNER JOIN employees m
ON e.manager_id = m.emp_id;

-- 24. Display all employees and managers including employees without managers
SELECT e.emp_name AS employee_name,
m.emp_name AS manager_name
FROM employees e
LEFT JOIN employees m
ON e.manager_id = m.emp_id;

-- 25. Find departments and employee counts including empty departments
SELECT d.dept_name,
COUNT(e.emp_id) AS employee_count
FROM departments d
LEFT JOIN employees e
ON d.dept_id = e.dept_id
GROUP BY d.dept_name;

-- 26. List all employees and departments including empty departments
SELECT e.emp_name,
d.dept_name
FROM departments d
LEFT JOIN employees e
ON d.dept_id = e.dept_id;

-- 27. Show employees without salary records
SELECT e.emp_name
FROM employees e;

-- 28. Retrieve employees and project assignments including employees without projects
SELECT e.emp_name,
p.project_name
FROM employees e
LEFT JOIN projects p
ON e.emp_id = p.emp_id;

-- 29. List employees with department and project assignments
SELECT e.emp_name,
d.dept_name,
p.project_name
FROM employees e
LEFT JOIN departments d
ON e.dept_id = d.dept_id
LEFT JOIN projects p
ON e.emp_id = p.emp_id;

-- 30. Display employees with departments including employees without departments
SELECT e.emp_name,
d.dept_name
FROM employees e
LEFT JOIN departments d
ON e.dept_id = d.dept_id;
