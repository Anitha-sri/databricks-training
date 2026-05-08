--created tables

--Students
  CREATE TABLE students (
    student_id INT,
    student_name VARCHAR(100),
    email VARCHAR(100)
);

--Courses
CREATE TABLE courses (
    course_id INT,
    course_name VARCHAR(100),
    instructor_id INT
);

--instructors
CREATE TABLE instructors (
    instructor_id INT,
    instructor_name VARCHAR(100)
);
--enrollements
CREATE TABLE enrollments (
    enrollment_id INT,
    student_id INT,
    course_id INT,
    enrollment_date DATE
);

-- Insert into students
INSERT INTO students VALUES
(1,'Alice Johnson','alice@email.com'),
(2,'Bob Smith','bob@email.com'),
(3,'Charlie Brown','charlie@email.com'),
(4,'Diana Prince','diana@email.com'),
(5,'Ethan Hunt','ethan@email.com');

-- Insert into courses
INSERT INTO courses VALUES
(101,'SQL Basics',1),
(102,'Python Fundamentals',2),
(103,'Data Analytics',NULL),
(104,'Cloud Computing',3),
(105,'Machine Learning',NULL);

-- Insert into instructors
INSERT INTO instructors VALUES
(1,'John Miller'),
(2,'Sarah Lee'),
(3,'David Wilson');

-- Insert into enrollments
INSERT INTO enrollments VALUES
(1,1,101,'2026-01-10'),
(2,2,102,'2026-01-11'),
(3,3,101,'2026-01-12'),
(4,4,104,'2026-01-13');


--=================
--solutions
--=================


-- Q1: Display all students and the courses they are enrolled in
SELECT s.student_id,s.student_name,c.course_name FROM students s LEFT JOIN enrollments e ON s.student_id=e.student_id LEFT JOIN courses c ON e.course_id=c.course_id;
-- Q2: Find all courses that currently have no students enrolled
SELECT c.course_id,c.course_name FROM courses c LEFT JOIN enrollments e ON c.course_id=e.course_id WHERE e.student_id IS NULL;
-- Q3: Display all instructors and the courses they teach
SELECT i.instructor_id,i.instructor_name,c.course_name FROM instructors i LEFT JOIN courses c ON i.instructor_id=c.instructor_id;
-- Q4: Find all courses that do not have an instructor assigned
SELECT course_id,course_name FROM courses WHERE instructor_id IS NULL;
-- Q5: Display all students and enrollment information using RIGHT JOIN
SELECT s.student_id,s.student_name,e.course_id,e.enrollment_date FROM students s RIGHT JOIN enrollments e ON s.student_id=e.student_id;
-- Q6: Find students who are not enrolled in any course
SELECT s.student_id,s.student_name FROM students s LEFT JOIN enrollments e ON s.student_id=e.student_id WHERE e.course_id IS NULL;
-- Q7: Display all students and enrollments using FULL OUTER JOIN
SELECT s.student_id,s.student_name,e.course_id,e.enrollment_date FROM students s FULL OUTER JOIN enrollments e ON s.student_id=e.student_id;
-- Q8: Find all courses that never appeared in enrollments
SELECT c.course_id,c.course_name FROM courses c LEFT JOIN enrollments e ON c.course_id=e.course_id WHERE e.course_id IS NULL;
-- Q9: Display all instructors and courses using FULL OUTER JOIN
SELECT i.instructor_id,i.instructor_name,c.course_id,c.course_name FROM instructors i FULL OUTER JOIN courses c ON i.instructor_id=c.instructor_id;
-- Q10: Display student name, course name, and instructor name
SELECT s.student_name,c.course_name,i.instructor_name FROM students s LEFT JOIN enrollments e ON s.student_id=e.student_id LEFT JOIN courses c ON e.course_id=c.course_id LEFT JOIN instructors i ON c.instructor_id=i.instructor_id;
-- BONUS: List every student and every course
SELECT s.student_name,c.course_name FROM students s CROSS JOIN courses c;
