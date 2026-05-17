                                             --***********************************
                                                            LEVEL 2
                                             --***********************************


-- =================================================================
-- QUESTION 1 Employee Login Discipline & Performance Classification
-- ==================================================================

-- table creation
CREATE TABLE employee_login (emp_id INT, emp_name VARCHAR(50), login_time DATETIME, logout_time DATETIME);

-- insert data
INSERT INTO employee_login VALUES
(1,'Karthik','2025-01-15 09:05:00','2025-01-15 18:10:00'),
(2,'Veena','2025-01-14 10:30:00','2025-01-14 16:00:00'),
(3,'Ravi','2025-01-13 09:00:00','2025-01-13 20:00:00'),
(4,'Anil','2025-01-12 11:00:00','2025-01-12 14:00:00'),
(5,'Suresh','2025-01-11 09:15:00','2025-01-11 17:00:00');

-- convert name to proper case
SELECT emp_name, INITCAP(emp_name) AS proper_name FROM employee_login;

-- identify weekday or weekend
SELECT emp_name, DAYNAME(login_time) AS day_name,
CASE WHEN DAYNAME(login_time) IN ('Saturday','Sunday') THEN 'Weekend'
ELSE 'Weekday' END AS login_type
FROM employee_login;

-- calculate working hours
SELECT emp_name, ROUND(TIMESTAMPDIFF(MINUTE, login_time, logout_time)/60,2) AS working_hours
FROM employee_login;

-- performance classification
SELECT emp_name,
ROUND(TIMESTAMPDIFF(MINUTE, login_time, logout_time)/60,2) AS working_hours,
CASE
WHEN DAYNAME(login_time) NOT IN ('Saturday','Sunday')
AND TIMESTAMPDIFF(MINUTE, login_time, logout_time)/60 >= 8 THEN 'Good Performer'
WHEN DAYNAME(login_time) NOT IN ('Saturday','Sunday')
AND TIMESTAMPDIFF(MINUTE, login_time, logout_time)/60 < 6 THEN 'Bad Performer'
ELSE 'Weekend Login'
END AS performance_status
FROM employee_login;

-- ====================================================
-- QUESTION 2 Past 7 Days Attendance & Productivity Check
-- ====================================================

-- table creation
CREATE TABLE attendance_log (emp_id INT, emp_name VARCHAR(50), login_date DATE, login_time TIME, logout_time TIME);

-- insert data
INSERT INTO attendance_log VALUES
(1,'Karthik','2025-01-14','09:00:00','18:00:00'),
(2,'Karthik','2025-01-13','09:15:00','17:30:00'),
(3,'Veena','2025-01-12','10:00:00','15:00:00'),
(4,'Ravi','2025-01-10','09:00:00','19:00:00'),
(5,'Anil','2025-01-08','11:00:00','14:00:00');

-- uppercase employee name
SELECT emp_name, UPPER(emp_name) AS upper_name FROM attendance_log;

-- check attendance within last 7 days
SELECT emp_name, login_date,
CASE WHEN login_date >= CURRENT_DATE - INTERVAL 7 DAY THEN 'Within 7 Days'
ELSE 'Old Record' END AS attendance_status
FROM attendance_log;

-- identify weekday or weekend
SELECT emp_name, DAYNAME(login_date) AS day_name,
CASE WHEN DAYNAME(login_date) IN ('Saturday','Sunday') THEN 'Weekend'
ELSE 'Weekday' END AS day_type
FROM attendance_log;

-- calculate working hours
SELECT emp_name, TIMEDIFF(logout_time, login_time) AS working_hours
FROM attendance_log;

-- productivity classification
SELECT emp_name,
TIMESTAMPDIFF(HOUR, login_time, logout_time) AS hours_worked,
CASE
WHEN login_date >= CURRENT_DATE - INTERVAL 7 DAY
AND TIMESTAMPDIFF(HOUR, login_time, logout_time) >= 8 THEN 'Active & Productive'
WHEN login_date >= CURRENT_DATE - INTERVAL 7 DAY
AND TIMESTAMPDIFF(HOUR, login_time, logout_time) < 8 THEN 'Active but Low Hours'
ELSE 'Absent from Last 7 Days'
END AS productivity_status
FROM attendance_log;

-- ====================================================
-- QUESTION 3 Weekend Work Abuse Detection
-- ====================================================

-- table creation
CREATE TABLE weekend_monitor (emp_id INT, emp_name VARCHAR(50), work_date DATE, login_time TIME, logout_time TIME);

-- insert data
INSERT INTO weekend_monitor VALUES
(1,'Ravi','2025-01-11','09:00:00','21:00:00'),
(2,'Veena','2025-01-12','10:00:00','13:00:00'),
(3,'Karthik','2025-01-10','09:00:00','18:00:00'),
(4,'Anil','2025-01-09','11:00:00','14:00:00');

-- extract day name
SELECT emp_name, DAYNAME(work_date) AS day_name FROM weekend_monitor;

-- lowercase employee name
SELECT emp_name, LOWER(emp_name) AS lower_name FROM weekend_monitor;

-- calculate working hours
SELECT emp_name, CEIL(TIMESTAMPDIFF(MINUTE, login_time, logout_time)/60) AS working_hours
FROM weekend_monitor;

-- abuse detection
SELECT emp_name,
CEIL(TIMESTAMPDIFF(MINUTE, login_time, logout_time)/60) AS working_hours,
CASE
WHEN DAYNAME(work_date) IN ('Saturday','Sunday')
AND TIMESTAMPDIFF(HOUR, login_time, logout_time) >= 8 THEN 'Weekend Overtime'
WHEN DAYNAME(work_date) IN ('Saturday','Sunday')
AND TIMESTAMPDIFF(HOUR, login_time, logout_time) < 4 THEN 'Suspicious Login'
ELSE 'Normal Working Day'
END AS work_status
FROM weekend_monitor;

-- ====================================================
-- QUESTION 4 Login Time Deviation & Discipline Score
-- ====================================================

-- table creation
CREATE TABLE login_discipline (emp_id INT, emp_name VARCHAR(50), login_datetime DATETIME, logout_datetime DATETIME);

-- insert data
INSERT INTO login_discipline VALUES
(1,'Karthik','2025-01-15 08:55:00','2025-01-15 18:10:00'),
(2,'Veena','2025-01-15 10:45:00','2025-01-15 16:00:00'),
(3,'Ravi','2025-01-15 09:00:00','2025-01-15 20:30:00'),
(4,'Anil','2025-01-15 11:30:00','2025-01-15 14:00:00');

-- extract login hour
SELECT emp_name, HOUR(login_datetime) AS login_hour FROM login_discipline;

-- calculate working hours
SELECT emp_name,
TRUNCATE(TIMESTAMPDIFF(MINUTE, login_datetime, logout_datetime)/60,1) AS working_hours
FROM login_discipline;

-- discipline score
SELECT emp_name,
DAYNAME(login_datetime) AS weekday_name,
TRUNCATE(TIMESTAMPDIFF(MINUTE, login_datetime, logout_datetime)/60,1) AS working_hours,
CASE
WHEN HOUR(login_datetime) < 9
AND TIMESTAMPDIFF(HOUR, login_datetime, logout_datetime) >= 8 THEN 'Disciplined'
WHEN HOUR(login_datetime) > 10 THEN 'Late Comer'
ELSE 'Poor Discipline'
END AS discipline_status
FROM login_discipline;

-- ====================================================
-- QUESTION 5 Absenteeism vs Performance Correlation
-- ====================================================

-- table creation
CREATE TABLE performance_tracker (emp_id INT, emp_name VARCHAR(50), work_date DATE, login_time TIME, logout_time TIME);

-- insert data
INSERT INTO performance_tracker VALUES
(1,'Karthik','2025-01-09','09:00:00','18:00:00'),
(2,'Karthik','2025-01-10','09:10:00','17:50:00'),
(3,'Veena','2025-01-05','10:00:00','15:00:00'),
(4,'Ravi','2025-01-14','09:00:00','19:00:00'),
(5,'Anil','2025-01-03','11:00:00','14:00:00');

-- identify records within last 7 days
SELECT emp_name, work_date,
CASE WHEN work_date >= CURRENT_DATE - INTERVAL 7 DAY THEN 'Recent'
ELSE 'Old Record' END AS record_status
FROM performance_tracker;

-- identify weekday or weekend
SELECT emp_name, DAYNAME(work_date) AS weekday_name,
CASE WHEN DAYNAME(work_date) IN ('Saturday','Sunday') THEN 'Weekend'
ELSE 'Weekday' END AS day_type
FROM performance_tracker;

-- calculate total hours worked
SELECT emp_name,
FLOOR(TIMESTAMPDIFF(MINUTE, login_time, logout_time)/60) AS total_hours
FROM performance_tracker;

-- performance correlation
SELECT emp_name,
FLOOR(TIMESTAMPDIFF(MINUTE, login_time, logout_time)/60) AS total_hours,
CASE
WHEN work_date >= CURRENT_DATE - INTERVAL 7 DAY
AND DAYNAME(work_date) NOT IN ('Saturday','Sunday')
AND TIMESTAMPDIFF(HOUR, login_time, logout_time) >= 8 THEN 'Consistent Performer'
WHEN TIMESTAMPDIFF(HOUR, login_time, logout_time) < 6 THEN 'Irregular Performer'
ELSE 'Absent / Old Record'
END AS performance_status
FROM performance_tracker;
