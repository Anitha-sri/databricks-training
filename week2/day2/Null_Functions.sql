
                                                                   --*************************
                                                                      -- NULL FUNCTIONS
                                                                   --*************************

-- table schema
CREATE TABLE Employees (
    emp_id INT,
    name VARCHAR(50),
    salary INT,
    bonus INT,
    manager_id INT
);

INSERT INTO Employees VALUES
(1, 'Amit', 50000, NULL, 101),
(2, 'John', NULL, 5000, 102),
(3, 'Sara', 60000, NULL, NULL),
(4, 'David', NULL, NULL, 103),
(5, 'Priya', 45000, 3000, 101),
(6, 'Kiran', NULL, NULL, NULL),
(7, 'Ravi', 70000, 7000, 102),
(8, 'Neha', NULL, 2000, NULL);

CREATE TABLE Orders (
    order_id INT,
    customer_name VARCHAR(50),
    amount INT,
    discount INT,
    coupon_code VARCHAR(20)
);

INSERT INTO Orders VALUES
(101, 'Amit', 1000, NULL, 'DISC10'),
(102, 'John', NULL, 50, NULL),
(103, 'Sara', 2000, NULL, 'DISC20'),
(104, 'David', NULL, NULL, NULL),
(105, 'Priya', 1500, 100, NULL),
(106, 'Kiran', NULL, NULL, 'DISC5'),
(107, 'Ravi', 3000, NULL, NULL),
(108, 'Neha', NULL, 200, 'DISC15');

CREATE TABLE Products (
    product_id INT,
    product_name VARCHAR(50),
    price INT,
    category VARCHAR(50),
    stock INT
);

INSERT INTO Products VALUES
(1, 'Laptop', 50000, 'Electronics', 10),
(2, 'Phone', NULL, 'Electronics', NULL),
(3, 'Tablet', 30000, NULL, 5),
(4, 'Headphones', NULL, NULL, NULL),
(5, 'Monitor', 20000, 'Electronics', 0),
(6, 'Keyboard', NULL, 'Accessories', 15),
(7, 'Mouse', 500, NULL, NULL),
(8, 'Printer', NULL, 'Electronics', 3);

-- LEVEL 1

-- 1. Show all employees whose salary is NULL
SELECT * FROM Employees WHERE salary IS NULL;

-- 2. Show all orders where discount is NOT NULL
SELECT * FROM Orders WHERE discount IS NOT NULL;

-- 3. Get products where category is NULL
SELECT * FROM Products WHERE category IS NULL;

-- 4. Count number of employees with NULL manager_id
SELECT COUNT(*) AS null_manager_count FROM Employees WHERE manager_id IS NULL;

-- LEVEL 2

-- 5. Replace NULL salary with 0
SELECT emp_id,name, IFNULL(salary, 0) AS salary FROM Employees;

-- 6. Replace NULL bonus with 1000
SELECT emp_id, name, IFNULL(bonus, 1000) AS bonus FROM Employees;

-- 7. Show order amount, if NULL replace with 500
SELECT order_id, customer_name, IFNULL(amount, 500) AS amount FROM Orders;

-- 8. Replace NULL stock with 0
SELECT product_id, product_name, IFNULL(stock, 0) AS stock FROM Products;

-- LEVEL 3

-- 9. Show employee earnings using salary, if NULL use bonus
SELECT emp_id,
name,
COALESCE(salary, bonus) AS earnings
FROM Employees;

-- 10. Show first available value salary → bonus → 0
SELECT emp_id,
name,
COALESCE(salary, bonus, 0) AS income
FROM Employees;

-- 11. Show product price price → 1000 default
SELECT product_id,
product_name,
COALESCE(price, 1000) AS final_price
FROM Products;

-- 12. Get customer payment amount → discount → 0
SELECT order_id,
customer_name,
COALESCE(amount, discount, 0) AS payment
FROM Orders;

-- LEVEL 4

-- 13. Convert salary to NULL if salary = 0
SELECT emp_id,
name,
NULLIF(salary, 0) AS updated_salary
FROM Employees;

-- 14. Convert discount to NULL if discount = 0
SELECT order_id,
NULLIF(discount, 0) AS updated_discount
FROM Orders;

-- 15. Use NULLIF to avoid divide by zero
SELECT order_id,
amount / NULLIF(discount, 0) AS division_result
FROM Orders;

-- 16. Replace coupon_code with NULL if it is DISC10
SELECT order_id,
NULLIF(coupon_code, 'DISC10') AS updated_coupon
FROM Orders;

-- LEVEL 5

-- 17. Calculate total earnings salary + bonus
SELECT emp_id,
name,
IFNULL(salary,0) + IFNULL(bonus,0) AS total_earnings
FROM Employees;

-- 18. Show employees where both salary and bonus are NULL
SELECT *
FROM Employees
WHERE salary IS NULL
AND bonus IS NULL;

-- 19. Show products where price is NULL but category is NOT NULL
SELECT *
FROM Products
WHERE price IS NULL
AND category IS NOT NULL;

-- 20. Show orders where both amount and discount are NULL
SELECT *
FROM Orders
WHERE amount IS NULL
AND discount IS NULL;

-- LEVEL 6

-- 21. Show employee income using COALESCE
SELECT emp_id,
name,
COALESCE(salary, bonus, 1000) AS employee_income
FROM Employees;

-- 22. Replace empty discount with NULL using NULLIF
SELECT order_id,
NULLIF(discount, 0) AS cleaned_discount
FROM Orders;

-- 23. Show final payable amount amount - discount
SELECT order_id,
customer_name,
IFNULL(amount,0) - IFNULL(discount,0) AS final_payable
FROM Orders;

-- 24. Find employees where salary is NULL but manager exists
SELECT *
FROM Employees
WHERE salary IS NULL
AND manager_id IS NOT NULL;
