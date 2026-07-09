                                               -- =====================================================
                                               -- mysql string functions practice
                                               -- =====================================================

-- ================
-- sample table
-- ================

create table employees (
    emp_id int primary key,
    full_name varchar(100),
    email varchar(100),
    department varchar(50),
    city varchar(50),
    salary varchar(20),
    remarks varchar(200)
);

-- ============
-- sample data
-- ============

insert into employees values
(1, 'Karthik Kondpak', 'karthik.k@gmail.com', 'Data Engineering', 'Hyderabad', '75000', ' Top performer '),
(2, 'Veena Reddy', 'veena_r@company.com', 'Analytics', 'Bangalore', '65000', 'Excellent communication'),
(3, 'Ravi kumar', 'ravi.kumar@org.in', 'Data Science', 'Chennai', '85000', 'Needs improvement'),
(4, 'Anil', 'anil@abc.com', 'DEVOPS', 'Pune', '70000', null),
(5, ' Suresh ', 'suresh@xyz.com', 'data engineering', ' hyderabad ', '60000', ' ');

-- =====================================================
-- level 1 (basic)
-- =====================================================

-- 1. show the length of each employee name

select full_name,length(full_name) as total_length from employees;

-- 2. show the character length of each employee name

select full_name, char_length(full_name) as total_characters from employees;

-- 3. convert department to uppercase

select
    department,
    upper(department) as upper_department
from employees;

-- 4. convert city to lowercase

select
    city,
    lower(city) as lower_city
from employees;

-- =====================================================
-- level 2 (trim functions)
-- =====================================================

-- 5. remove spaces from both sides of full_name

select
    full_name,
    trim(full_name) as trimmed_name
from employees;

-- 6. remove leading spaces

select
    full_name,
    ltrim(full_name) as left_trim
from employees;

-- 7. remove trailing spaces

select
    full_name,
    rtrim(full_name) as right_trim
from employees;

-- =====================================================
-- level 3 (concat functions)
-- =====================================================

-- 8. combine employee name and department

select
    concat(full_name, ' - ', department) as employee_details
from employees;

-- 9. combine employee id, name and city using separator

select
    concat_ws(' | ', emp_id, full_name, city) as employee_info
from employees;

-- =====================================================
-- level 4 (substring functions)
-- =====================================================

-- 10. display first 7 characters of email

select
    email,
    substring(email, 1, 7) as email_part
from employees;

-- 11. display first 5 characters using substr

select
    email,
    substr(email, 1, 5) as email_part
from employees;

-- =====================================================
-- level 5 (left and right)
-- =====================================================

-- 12. display first 4 characters of employee name

select
    full_name,
    left(full_name, 4) as first_four
from employees;

-- 13. display last 3 characters of city

select
    city,
    right(city, 3) as last_three
from employees;

-- =====================================================
-- level 6 (search functions)
-- =====================================================

-- 14. find position of @ in email

select
    email,
    instr(email, '@') as at_position
from employees;

-- 15. find position of . in email

select
    email,
    locate('.', email) as dot_position
from employees;

-- =====================================================
-- level 7 (replace and reverse)
-- =====================================================

-- 16. replace data with big data in department

select
    department,
    replace(department, 'Data', 'Big Data') as new_department
from employees;

-- 17. reverse employee name

select
    full_name,
    reverse(full_name) as reverse_name
from employees;

-- =====================================================
-- level 8 (padding functions)
-- =====================================================

-- 18. add leading zeros to employee id

select
    emp_id,
    lpad(emp_id, 5, '0') as formatted_id
from employees;

-- 19. pad city name with *

select
    city,
    rpad(city, 15, '*') as formatted_city
from employees;

-- =====================================================
-- level 9 (combined functions)
-- =====================================================

-- 20. remove all spaces from city

select
    city,
    trim(replace(city, ' ', '')) as clean_city
from employees;

-- =====================================================
-- level 10 (null handling)
-- =====================================================

-- 21. replace null remarks with no remarks

select
    full_name,
    ifnull(remarks, 'No remarks') as remarks
from employees;

-- 22. display first non-null value using coalesce

select
    full_name,
    coalesce(remarks, 'N/A') as remarks
from employees;

-- =====================================================
-- level 11 (find_in_set)
-- =====================================================

-- 23. check analytics in comma separated values

select
    find_in_set('Analytics', 'Data,Analytics,AI') as position;

-- =====================================================
-- bonus practice
-- =====================================================

-- 24. display employee initials

select
    full_name,
    concat(
        left(trim(full_name), 1),
        '.',
        left(
            substring_index(trim(full_name), ' ', -1),
            1
        )
    ) as initials
from employees;

-- 25. extract username from email

select
    email,
    substring_index(email, '@', 1) as username
from employees;

-- 26. extract email domain

select
    email,
    substring_index(email, '@', -1) as domain
from employees;

-- 27. display cleaned employee name and city

select
    trim(full_name) as employee_name,
    trim(city) as city
from employees;

-- 28. display department in uppercase and city in lowercase

select
    upper(department) as department,
    lower(city) as city
from employees;

-- =====================================================
-- end of mysql string functions practice
-- =====================================================
