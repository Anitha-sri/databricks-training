
                                -- --------------------------------------    
                                -- Sql Assignment
                                -- --------------------------------------


-- Table 1: Departments

CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(50),
    Location VARCHAR(50)
);

INSERT INTO Departments VALUES
(1,'HR','New York'),
(2,'Finance','Chicago'),
(3,'IT','Dallas'),
(4,'Marketing','Boston'),
(5,'Sales','Seattle'),
(6,'Operations','Atlanta');

-- Table 2: Employees

CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    EmployeeName VARCHAR(50),
    DepartmentID INT,
    Salary DECIMAL(10,2),
    ManagerID INT,
    JoiningDate DATE
);

INSERT INTO Employees VALUES
(101,'John',1,50000,NULL,'2020-01-15'),
(102,'Emma',2,65000,101,'2021-03-10'),
(103,'David',3,70000,101,'2019-07-22'),
(104,'Sophia',3,72000,103,'2022-05-01'),
(105,'Michael',5,55000,102,'2021-09-18'),
(106,'Olivia',NULL,48000,102,'2023-01-12'),
(107,'James',4,60000,103,'2022-10-20'),
(108,'William',7,75000,101,'2020-08-11'),
(109,'Ava',NULL,52000,NULL,'2024-02-15'),
(110,'Isabella',5,68000,105,'2021-06-05');

-- Table 3: Projects

CREATE TABLE Projects (
    ProjectID INT PRIMARY KEY,
    ProjectName VARCHAR(50),
    DepartmentID INT,
    Budget DECIMAL(12,2)
);

INSERT INTO Projects VALUES
(201,'Payroll System',1,150000),
(202,'Audit System',2,200000),
(203,'Website Redesign',4,100000),
(204,'ERP Upgrade',3,500000),
(205,'Sales Dashboard',5,175000),
(206,'Automation',6,250000),
(207,'AI Chatbot',8,300000);

-- Table 4: EmployeeProjects

CREATE TABLE EmployeeProjects (
    EmployeeID INT,
    ProjectID INT
);

INSERT INTO EmployeeProjects VALUES
(101,201),
(102,202),
(103,204),
(104,204),
(105,205),
(107,203),
(110,205),
(103,207),
(108,207),
(109,202);



-- ********************
-- Assigment
-- ********************

-- INNER JOIN
-- ============

-- Display employee names with department names.
select EmployeeName,DepartmentName from Employees
inner join 
Departments on 
Employees.DepartmentID=Departments.DepartmentID;

-- Display project names with department names.
select ProjectName,DepartmentName from Projects inner join Departments on Projects.DepartmentID=Departments.DepartmentID;

-- Show employees along with project names.
select Employees.EmployeeID, EmployeeName, ProjectName from Employees 
inner join EmployeeProjects on Employees.EmployeeID = EmployeeProjects.EmployeeID 
inner join Projects on EmployeeProjects.ProjectID = Projects.ProjectID;

-- Show employee salary and department location.
select EmployeeID,EmployeeName,Salary,Location from Employees inner join Departments on Employees.DepartmentID=Departments.DepartmentID;

-- Display all employees working on projects.
select Projects.ProjectID, EmployeeName, ProjectName from Employees 
inner join EmployeeProjects on Employees.EmployeeID=EmployeeProjects.EmployeeID 
inner join Projects on EmployeeProjects.ProjectID=Projects.ProjectID;



-- LEFT JOIN
-- ===========

-- Show all employees even if they don't belong to any department.
select EmployeeID,EmployeeName,DepartmentName from Employees left join Departments on Employees.DepartmentID=Departments.DepartmentID;

-- Show all departments even if no employee works there.
select EmployeeID,EmployeeName,DepartmentName from Departments left join Employees on Employees.DepartmentID=Departments.DepartmentID;

-- Show all projects and their department names.
select ProjectName,DepartmentName from Projects left join Departments on Projects.DepartmentID=Departments.DepartmentID;

-- Show every employee and their assigned projects.
select EmployeeName,ProjectName from Employees
left join EmployeeProjects on EmployeeProjects.EmployeeID=Employees.EmployeeID
left join Projects on EmployeeProjects.ProjectID=Projects.ProjectID;

-- Display all employees even if they are not assigned to any project.
select EmployeeName, ProjectName from Employees
left join EmployeeProjects on Employees.EmployeeID = EmployeeProjects.EmployeeID
left join Projects on EmployeeProjects.ProjectID = Projects.ProjectID;



-- right join 
-- ============

-- show all departments even if there are no employees.
select d. DepartmentID, d.DepartmentName,e.EmployeeName from Employees e right join Departments d on e.DepartmentID=d.DepartmentID;

-- show all projects even if no employee is assigned.
select ProjectName,EmployeeName from Employees right join EmployeeProjects
  on Employees.EmployeeID=EmployeeProjects.EmployeeID right join Projects on EmployeeProjects.ProjectID=Projects.ProjectID; 

-- Display every department and employees.
SELECT d.DepartmentID, d.DepartmentName, e.EmployeeName 
FROM Employees e 
Right join Departments d ON e.DepartmentID = d.DepartmentID
UNION
SELECT d.DepartmentID, d.DepartmentName, e.EmployeeName 
FROM Departments d 
RIGHT JOIN Employees e ON e.DepartmentID = d.DepartmentID;

-- Show all projects with departments.
select p.ProjectID,p.ProjectName,d. DepartmentName from Projects p right join Departments d on p.DepartmentID=d.DepartmentID
union
select p.ProjectID,p.ProjectName,d. DepartmentName from Departments d right join Projects p on p.DepartmentID=d.DepartmentID;

-- Show every project assignment including projects without employees.
SELECT p.ProjectID, p.ProjectName, e.EmployeeName 
FROM Employees e 
RIGHT JOIN EmployeeProjects ep ON e.EmployeeID = ep.EmployeeID 
RIGHT JOIN Projects p ON ep.ProjectID = p.ProjectID;



-- FULL JOIN
-- ===========
-- Show all employees and all departments.
select e.EmployeeID, e.EmployeeName, d.DepartmentID, d.DepartmentName 
from Employees e 
full join Departments d on e.DepartmentID = d.DepartmentID;

-- Show all departments and projects.
select d.DepartmentID,d.DepartmentName,p.projectID,p.ProjectName from Departments d 
full join Projects p on d.DepartmentID=p.DepartmentID;

-- Display all employees and projects.
select e.EmployeeID, e.EmployeeName, p.ProjectID, p.ProjectName 
from Employees e 
full join EmployeeProjects ep on e.EmployeeID = ep.EmployeeID 
full join Projects p on ep.ProjectID = p.ProjectID;

-- Show every department whether employees exist or not.
select d.DepartmentID, d.DepartmentName, e.EmployeeName 
from Departments d 
full join Employees e on d.DepartmentID = e.DepartmentID;

-- Show all departments and projects including unmatched records.
select d.DepartmentID, d.DepartmentName, p.ProjectID, p.ProjectName 
from Departments d 
full join Projects p on d.DepartmentID = p.DepartmentID;


-- ---------------------------------------------------------------------------------------------------------------------
-- INTERMEDIATE ASSIGNMENTS
-- ---------------------------------------------------------------------------------------------------------------------


-- INNER JOIN
-- ==========

-- Show employees whose department is IT.
select e.EmployeeName,d.DepartmentName from Employees e inner join Departments d on e.DepartmentID=d.DepartmentID where DepartmentName='IT';

-- Display employees working on projects with budget above 200000.
select e.EmployeeName,p.ProjectName,p.Budget from Employees e inner join EmployeeProjects ep on ep.EmployeeID=e.EmployeeID inner join Projects p on p.ProjectID = ep.ProjectID where p.Budget > 200000;

-- Show employee names, department names and project names.
select e.EmployeeName, d.DepartmentName, p.ProjectName 
from Employees e 
inner join Departments d on e.DepartmentID = d.DepartmentID
inner join EmployeeProjects ep on e.EmployeeID = ep.EmployeeID
inner join Projects p on ep.ProjectID = p.ProjectID;

-- Display total employees in each department.
select d.DepartmentName,count(e.EmployeeName)as Employee_count from Employees e inner join Departments d on e.DepartmentID=d.DepartmentID group by d.DepartmentName;

-- Show average salary department-wise.
select d.DepartmentName,avg(e.Salary)as avg_Salary from Employees e inner join Departments d on e.DepartmentID=d.DepartmentID group by d.DepartmentName;



-- LEFT JOIN
-- ============
-- Find employees without departments.
select e.EmployeeName,d.DepartmentName from Employees e left join Departments d on e.DepartmentID=d.DepartmentID where DepartmentName is NULL;

-- Find employees without projects.
select e.EmployeeName,p.ProjectName from Employees e left join EmployeeProjects ep on ep.EmployeeID=e.EmployeeID left join Projects p
  on ep.ProjectID=p.ProjectID where ProjectName is null;

-- Find departments without employees.
select e.EmployeeName,d.DepartmentName from Departments  d left join Employees e on e.DepartmentID=d.DepartmentID where EmployeeName is NULL;

-- Find projects without departments.
select p.ProjectID, p.ProjectName 
from Projects p 
left join Departments d on p.DepartmentID = d.DepartmentID 
where d.DepartmentID is null;
.
-- Show departments with total employees including zero employees.
select d.DepartmentName, count(e.EmployeeID) as Employee_count 
from Departments d 
left join Employees e on d.DepartmentID = e.DepartmentID 
group by d.DepartmentName;



-- RIGHT JOIN
-- ===========

-- Find departments having no employees.
select d.DepartmentName from Employees e right join Departments d on d.DepartmentID=e.DepartmentID where e.EmployeeID is Null;

-- Find projects without employees..
select p.ProjectName 
from EmployeeProjects ep 
right join Projects p on p.ProjectID = ep.ProjectID 
where ep.ProjectID is null;

-- Show departments even if no projects exist.
select d.DepartmentName,p.ProjectName from Projects p right join Departments d on d.DepartmentID=p.DepartmentID ; 

-- Count employees in every department.
select d.DepartmentName,count(e.EmployeeName) from Employees e right join Departments d on d.DepartmentID=e.DepartmentID group by DepartmentName;

-- List every project whether employees are assigned or not
select p.ProjectName, e.EmployeeName
from Employees e
inner join EmployeeProjects ep on e.EmployeeID = ep.EmployeeID
right join Projects p on ep.ProjectID = p.ProjectID;

-- ==========
-- FULL JOIN
-- ===========
-- Display all departments and employees.
SELECT d.DepartmentName, e.EmployeeName
FROM Employees e 
FULL JOIN Departments d ON d.DepartmentID = e.DepartmentID;

-- Show unmatched employees.
SELECT e.EmployeeName, e.DepartmentID
FROM Employees e 
FULL JOIN Departments d ON d.DepartmentID = e.DepartmentID
WHERE e.DepartmentID IS NULL;

-- Show unmatched departments.
SELECT d.DepartmentName,e.EmployeeID
FROM Employees e 
FULL JOIN Departments d ON d.DepartmentID = e.DepartmentID
WHERE e.EmployeeID IS NULL;

-- Show all employees and departments with NULL handling.
SELECT 
    COALESCE(d.DepartmentName, 'No Department') AS Department, 
    COALESCE(e.EmployeeName, 'No Employee') AS Employee
FROM Employees e 
FULL JOIN Departments d ON d.DepartmentID = e.DepartmentID;

-- Display departments and projects including unmatched rows.
SELECT d.DepartmentName, p.ProjectName
FROM Projects p
FULL JOIN Departments d ON d.DepartmentID = p.DepartmentID;
