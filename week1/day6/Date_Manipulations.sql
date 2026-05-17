
                                                               --*************************
                                                               -- DATE & TIMESTAMP FUNCTIONS
                                                               --*************************

-- table schema
CREATE TABLE orders (
order_id INT PRIMARY KEY,
customer_name VARCHAR(50),
order_date DATE,
order_timestamp TIMESTAMP,
delivery_date DATE,
order_amount DECIMAL(10,2)
);

-- insert data
INSERT INTO orders VALUES
(1, 'Karthik', '2024-01-15', '2024-01-15 10:30:45', '2024-01-20', 2500.00),
(2, 'Veena', '2024-02-18', '2024-02-18 18:45:20', '2024-02-22', 3200.50),
(3, 'Ravi', '2024-03-02', '2024-03-02 09:15:10', '2024-03-08', 4100.75),
(4, 'Anil', '2024-03-09', '2024-03-09 14:05:55', '2024-03-15', 1800.00),
(5, 'Suresh', '2024-01-07', '2024-01-07 23:55:00', '2024-01-12', 2900.00);

-- 1. Display current date
SELECT CURDATE();

-- 2. Display current date using CURRENT_DATE
SELECT CURRENT_DATE();

-- 3. Display current time
SELECT CURTIME();

-- 4. Display current time using CURRENT_TIME
SELECT CURRENT_TIME();

-- 5. Display current date and time
SELECT NOW();

-- 6. Display current timestamp
SELECT CURRENT_TIMESTAMP;

-- 7. Extract year, month and day from order_date
SELECT
YEAR(order_date),
MONTH(order_date),
DAY(order_date)
FROM orders;

-- 8. Extract year, month and day using EXTRACT()
SELECT
EXTRACT(YEAR FROM order_date),
EXTRACT(MONTH FROM order_date),
EXTRACT(DAY FROM order_date)
FROM orders;

-- 9. Display month name and day name
SELECT
MONTHNAME(order_date),
DAYNAME(order_date)
FROM orders;

-- 10. Display weekday and dayofweek values
SELECT
WEEKDAY(order_date),
DAYOFWEEK(order_date)
FROM orders;

-- 11. Identify weekend orders using DAYNAME
SELECT order_id, order_date
FROM orders
WHERE DAYNAME(order_date) IN ('Saturday', 'Sunday');

-- 12. Identify weekend orders using DAYOFWEEK
SELECT order_id, order_date
FROM orders
WHERE DAYOFWEEK(order_date) IN (1, 7);

-- 13. Identify weekday orders
SELECT order_id, order_date
FROM orders
WHERE DAYOFWEEK(order_date) BETWEEN 2 AND 6;

-- 14. Add 5 days to order_date
SELECT order_date,
DATE_ADD(order_date, INTERVAL 5 DAY)
FROM orders;

-- 15. Subtract 3 days from order_date
SELECT order_date,
DATE_SUB(order_date, INTERVAL 3 DAY)
FROM orders;

-- 16. Add 1 month to order_date
SELECT DATE_ADD(order_date, INTERVAL 1 MONTH)
FROM orders;

-- 17. Subtract 2 months from order_date
SELECT DATE_SUB(order_date, INTERVAL 2 MONTH)
FROM orders;

-- 18. Add 1 year to order_date
SELECT DATE_ADD(order_date, INTERVAL 1 YEAR)
FROM orders;

-- 19. Calculate difference in days using DATEDIFF
SELECT
order_id,
DATEDIFF(delivery_date, order_date) AS delivery_days
FROM orders;

-- 20. Calculate difference using TIMESTAMPDIFF
SELECT
TIMESTAMPDIFF(DAY, order_date, delivery_date) AS days_diff,
TIMESTAMPDIFF(MONTH, order_date, delivery_date) AS months_diff
FROM orders;

-- 21. Display last day of month
SELECT LAST_DAY(order_date)
FROM orders;

-- 22. Display first day of month
SELECT DATE_SUB(order_date, INTERVAL DAY(order_date)-1 DAY)
FROM orders;

-- 23. Format order_date as DD-MM-YYYY
SELECT DATE_FORMAT(order_date, '%d-%m-%Y')
FROM orders;

-- 24. Format order_date as Month DD, YYYY
SELECT DATE_FORMAT(order_date, '%M %d, %Y')
FROM orders;

-- 25. Convert string to date using STR_TO_DATE
SELECT STR_TO_DATE('15-01-2024', '%d-%m-%Y');

-- 26. Format timestamp values
SELECT DATE_FORMAT(order_timestamp, '%d-%m-%Y %H:%i:%s')
FROM orders;

-- 27. Filter January orders
SELECT *
FROM orders
WHERE MONTH(order_date) = 1;

-- 28. Filter February orders
SELECT *
FROM orders
WHERE MONTHNAME(order_date) = 'February';

-- 29. Find financial year using CASE
SELECT order_date,
CASE
WHEN MONTH(order_date) >= 4
THEN CONCAT(YEAR(order_date), '-', YEAR(order_date)+1)
ELSE CONCAT(YEAR(order_date)-1, '-', YEAR(order_date))
END AS financial_year
FROM orders;

-- 30. Find orders placed in last 7 days
SELECT *
FROM orders
WHERE order_date >= CURDATE() - INTERVAL 7 DAY;

-- 31. Find orders placed today
SELECT *
FROM orders
WHERE DATE(order_timestamp) = CURDATE();
