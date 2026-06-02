

                                                                         --****************************************
                                                                         -- REGEX BASIC ASSIGNMENT (WITH SOLUTIONS)
                                                                         --****************************************
--table structure
CREATE TABLE regex_practice (
    id INT,
    full_text VARCHAR(200),
    email VARCHAR(100),
    phone VARCHAR(30),
    mixed_value VARCHAR(100)
);

-- (Insert 40 rows omitted for brevity)
INSERT INTO regex_practice VALUES
(1,'EMP001_IN_91','karthik@gmail.com','+91-9876543210','abc123xyz'),
(2,'EMP002_US_01','rahul@yahoo.com','+1-7654321098','test45done'),
(3,'EMP003_UK_44','john@outlook.com','+44-9988776655','run9fast'),
(4,'EMP004_AU_61','steve@gmail.com','+61-8899776655','go88home'),
(5,'EMP005_IN_91','arjun@company.in','+91-7788996655','data77lake'),
(6,'EMP006_US_01','meera@gmail.com','+1-9090909090','spark12sql'),
(7,'EMP007_UK_44','rohan@yahoo.com','+44-7878787878','etl999job'),
(8,'EMP008_AU_61','alice@company.au','+61-6665554443','cloud7aws'),
(9,'EMP009_IN_91','vinay@gmail.com','+91-9988776655','hdfs34node'),
(10,'EMP010_US_01','sam@outlook.com','+1-6767676767','map5reduce'),
(11,'USR11_IN','neha@gmail.com','91-8899001122','abc1'),
(12,'USR12_US','tom@yahoo.com','01-9988776655','x9'),
(13,'USR13_UK','harry@company.co.uk','44-6677889900','z88'),
(14,'USR14_AU','olivia@gmail.com','61-4455667788','q777'),
(15,'USR15_IN','ankit@company.in','91-9988001122','karthik99'),
(16,'ACC_1001_91','user1@gmail.com','+91-8877665544','etl1'),
(17,'ACC_1002_01','user2@yahoo.com','+1-2233445566','etl22'),
(18,'ACC_1003_44','user3@outlook.com','+44-3344556677','etl333'),
(19,'ACC_1004_61','user4@gmail.com','+61-5566778899','etl4444'),
(20,'ACC_1005_91','user5@company.in','+91-6677889900','etl55555'),
(21,'ORD-11-IN','a@gmail.com','91-9998887776','a1b2'),
(22,'ORD-22-US','b@yahoo.com','01-1112223334','x2y'),
(23,'ORD-33-UK','c@outlook.com','44-5556667778','m33n'),
(24,'ORD-44-AU','d@gmail.com','61-8887776665','k444'),
(25,'ORD-55-IN','e@company.in','91-4445556667','job5'),
(26,'LOG91DATA','x@gmail.com','91-9090909090','log99'),
(27,'LOG01DATA','y@yahoo.com','01-8080808080','log8'),
(28,'LOG44DATA','z@outlook.com','44-7070707070','log777'),
(29,'LOG61DATA','p@gmail.com','61-6060606060','log6666'),
(30,'LOG91DATA','q@company.in','91-5050505050','log55555'),
(31,'IND91CODE','aa@gmail.com','+91-8889990001','aa1'),
(32,'USA01CODE','bb@yahoo.com','+1-7776665554','bb22'),
(33,'UK44CODE','cc@outlook.com','+44-6665554443','cc333'),
(34,'AUS61CODE','dd@gmail.com','+61-5554443332','dd4444'),
(35,'IND91CODE','ee@company.in','+91-4443332221','ee55555'),
(36,'TEST001','test1@gmail.com','91-1111111111','t1'),
(37,'TEST002','test2@yahoo.com','01-2222222222','t22'),
(38,'TEST003','test3@outlook.com','44-3333333333','t333'),
(39,'TEST004','test4@gmail.com','61-4444444444','t4444'),
(40,'TEST005','test5@company.in','91-5555555555','t55555');



-- Q1: Extract numbers at beginning of mixed_value
SELECT id, REGEXP_SUBSTR(mixed_value,'^[0-9]+') FROM regex_practice;

-- Q2: Extract numbers at end of mixed_value
SELECT id, REGEXP_SUBSTR(mixed_value,'[0-9]+$') FROM regex_practice;

-- Q3: Extract first character of mixed_value
SELECT id, REGEXP_SUBSTR(mixed_value,'^.') FROM regex_practice;

-- Q4: Extract last character of mixed_value
SELECT id, REGEXP_SUBSTR(mixed_value,'.$') FROM regex_practice;

-- Q5: Extract exactly two consecutive digits anywhere in mixed_value
SELECT id, REGEXP_SUBSTR(mixed_value,'[0-9]{2}') FROM regex_practice;

-- Q6: Extract exactly one digit anywhere in mixed_value
SELECT id, REGEXP_SUBSTR(mixed_value,'[0-9]') FROM regex_practice;

-- Q7: Extract country code from phone (starting digits only)
SELECT id, REGEXP_SUBSTR(phone,'^[+]?([0-9]+)') FROM regex_practice;

-- Q8: Extract numeric portion between alphabets in mixed_value
SELECT id, REGEXP_SUBSTR(mixed_value,'[A-Za-z]+([0-9]+)[A-Za-z]+') FROM regex_practice;

-- Q9: Extract text before @ in email
SELECT id, REGEXP_SUBSTR(email,'^[^@]+') FROM regex_practice;

-- Q10: Extract text after @ in email
SELECT id, REGEXP_SUBSTR(email,'@(.+)') FROM regex_practice;

-- Q11: Extract only domain name from email
SELECT id, REGEXP_SUBSTR(email,'@([^@]+)') FROM regex_practice;

-- Q12: Extract email extension (com/in/uk)
SELECT id, REGEXP_SUBSTR(email,'\\.([A-Za-z]+)$') FROM regex_practice;

-- Q13: Extract only alphabets from mixed_value
SELECT id, REGEXP_REPLACE(mixed_value,'[^A-Za-z]','') FROM regex_practice;

-- Q14: Extract only numbers from mixed_value
SELECT id, REGEXP_REPLACE(mixed_value,'[^0-9]','') FROM regex_practice;

-- Q15: Extract first 3 characters of full_text
SELECT id, REGEXP_SUBSTR(full_text,'^.{3}') FROM regex_practice;

-- Q16: Extract last 2 characters of full_text
SELECT id, REGEXP_SUBSTR(full_text,'..$') FROM regex_practice;

-- Q17: Extract employee number between prefix and underscore
SELECT id, REGEXP_SUBSTR(full_text,'[A-Z]+([0-9]+)_') FROM regex_practice;

-- Q18: Extract country code at end of full_text
SELECT id, REGEXP_SUBSTR(full_text,'([0-9]+)$') FROM regex_practice;

-- Q19: Extract text between underscores in full_text
SELECT id, REGEXP_SUBSTR(full_text,'_([A-Z0-9]+)_') FROM regex_practice;

-- Q20: Extract digits after + in phone number
SELECT id, REGEXP_SUBSTR(phone,'\\+([0-9]+)') FROM regex_practice;



