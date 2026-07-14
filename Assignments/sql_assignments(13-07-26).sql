-- -----------------
-- Table creation
-- -----------------

CREATE TABLE Employees (
    emp_id INT,
    emp_name VARCHAR(50),
    department VARCHAR(50),
    salary INT,
    city VARCHAR(50),
    experience INT
);

 -- -------------------
 -- inserting the data
 -- -------------------
INSERT INTO Employees VALUES
(101, 'Rahul', 'IT', 75000, 'Hyderabad', 5),
(102, 'Anjali', 'HR', 45000, 'Chennai', 3),
(103, 'Kiran', 'IT', 82000, 'Bangalore', 6),
(104, 'Sneha', 'Finance', 67000, 'Hyderabad', 4),
(105, 'Aman', 'HR', 39000, 'Pune', 2),
(106, 'Ravi', 'Finance', 91000, 'Mumbai', 8),
(107, 'Divya', 'IT', 55000, 'Chennai', 3),
(108, 'Meena', 'Sales', 48000, 'Bangalore', 2),
(109, 'Arjun', 'Sales', 61000, 'Hyderabad', 5),
(110, 'Pooja', 'IT', 73000, 'Mumbai', 4),
(111, 'Vikas', 'HR', 52000, 'Pune', 3),
(112, 'Nisha', 'Finance', 88000, 'Bangalore', 7),
(113, 'Tarun', 'Sales', 46000, 'Chennai', 2),
(114, 'Kavya', 'IT', 97000, 'Hyderabad', 9),
(115, 'Manoj', 'Finance', 58000, 'Mumbai', 4);


  -- *SELECT*  
-- Display all employee details.
select * from Employees;
-- Display only employee names and salaries.
select emp_name,salary from Employees;
-- Display employee names and departments.
select emp_name,department from Employees;
-- Display all employees from the IT department.
select  emp_name,department from Employees where department='IT';
-- Display employee names and experience.
select emp_name,experience from Employees;

-- WHERE
-- Find employees with salary greater than 70000.
select emp_name,salary from Employees where salary>70000;
-- Find employees working in Hyderabad.
select  emp_name,city from Employees where city='Hyderabad';
-- Find employees with experience less than 4 years.
select emp_name,experience from Employees where experience < 4;
-- Find employees from Finance department
select emp_name,department from Employees where department='Finance';
-- Find employees whose salary is equal to 52000.
select emp_name,salary from Employees where salary =52000;

-- GROUP BY
-- Find total salary department-wise.
select department,sum(salary) as total_salary from Employees group by department;
-- Find average salary in each department.
select department,avg(salary) as Avg_salary from Employees group by department;
-- Count employees in each city.
select count(emp_name)as Employee_count,city from Employees group by city;
-- Find maximum salary in each department.
select department,max(salary)as max_salary from Employees group by department;
-- Find minimum experience department-wise.
select department,min(experience) as min_experience from Employees group by department;

-- HAVING
-- Find departments having more than 3 employees.
select department,count(emp_name) as employee_count from Employees group by department having employee_count > 3;
-- Find departments where average salary is greater than 60000.
select department,avg(salary) as avg_greaterthan_60k from Employees group by department having avg(salary)>60000;
-- Find cities having more than 2 employees.
select city,count(emp_name) as emp_count from Employees group by city having emp_count >2;
-- Find departments where total salary is greater than 200000.
select department,sum(salary) as total_salary from Employees group by department having sum(salary)>200000;
-- Find departments where maximum salary is above 90000.
select department,max(salary) as max_salary from Employees group by department having max(salary)>90000;

-- TOP
-- Display top 5 highest paid employees.
select TOP 5 emp_name,salary from Employees order by salary desc;
-- Display top 3 employees with highest experience.
select TOP 3 emp_name,experience from Employees order by experience desc;
-- Display top 2 salaries from Finance department.
select TOP 2 salary,department from Employees where department='Finance' order by salary DESC;
-- Display top 4 employees from Hyderabad.
select TOP 4 emp_name,city from Employees where city='Hyderabad';
-- Display top 1 highest salary employee.
select TOP 1 emp_name,salary from Employees order by salary desc;

-- DISTINCT
-- Display distinct department names.
select distinct department from Employees;
 -- Display distinct city names.
 select distinct city from Employees;
-- Display distinct salary values.
select distinct salary from Employees;
-- Display distinct combinations of department and city.
select distinct department,city from Employees;
-- Display distinct experience values.
select distinct experience from Employees;

-- COMPARISON OPERATORS
-- Find employees with salary >= 80000.
select emp_name,salary from Employees where salary>=80000;
-- Find employees with experience <= 3.
select emp_name,experience from Employees where experience <= 3;
-- Find employees whose salary <> 45000.
select emp_name,salary from Employees where salary<>45000;
-- Find employees with salary < 50000.
select emp_name,salary from Employees where salary<50000;
-- Find employees with experience > 5.
select emp_name,experience from Employees where experience > 5;

-- LOGICAL OPERATORS
-- Find employees from IT department AND salary greater than 70000.
select emp_name,department,salary from Employees where department='IT' and salary >70000;
-- Find employees from Hyderabad OR Bangalore.
select emp_name,city from Employees where city='Hyderabad' OR city='Bangalore';
-- Find employees from HR department AND experience less than 3.
select emp_name,department,experience from Employees where department='HR' and experience < 3;
-- Find employees with salary greater than 60000 OR experience greater than 6.
select emp_name,salary,experience from Employees where experience>6 or salary >60000;
-- Find employees NOT from Sales department.
select emp_name,department from Employees where not department= 'Sales';


-- IN AND NOT IN
-- Find employees working in ('Hyderabad', 'Mumbai').
select emp_name, city from Employees where city in ('Hyderabad', 'Mumbai');
-- Find employees whose department IN ('IT', 'Finance').
select emp_name, department from Employees where department in ('IT', 'Finance');
-- Find employees whose city NOT IN ('Chennai', 'Pune').
select emp_name, city from Employees where city not in ('Chennai', 'Pune');
-- Find employees whose salary IN (45000, 75000, 91000).
select emp_name, salary from Employees where salary in (45000, 75000, 91000);
-- Find employees whose department NOT IN ('HR', 'Sales').
select emp_name, department from Employees where department not in ('HR', 'Sales');





-- BETWEEN
-- Find employees with salary BETWEEN 50000 AND 80000.
select emp_name, salary from Employees where salary between 50000 and 80000;
-- Find employees with experience BETWEEN 3 AND 6.
select emp_name, experience from Employees where experience between 3 and 6;
-- Find employees whose emp_id BETWEEN 105 AND 112.
select emp_id, emp_name from Employees where emp_id between 105 and 112;
-- Find employees with salary NOT BETWEEN 40000 AND 60000.
select emp_name, salary from Employees where salary not between 40000 and 60000;
-- Find employees with experience BETWEEN 2 AND 4.
select emp_name, experience from Employees where experience between 2 and 4;




-- LIKE OPERATOR
-- Find employees whose names start with 'R'.
 select emp_name from Employees where emp_name like 'R%';
-- Find employees whose names end with 'a'.
select emp_name from Employees where emp_name like '%a';
-- Find employees whose names contain 'v'.
select emp_name from Employees where emp_name like '%v%';
-- Find employees whose city starts with 'B'.
select emp_name,city from Employees where city like 'B%';
-- Find employees whose department ends with 's'.
select emp_name,department from Employees where department like '%s';

