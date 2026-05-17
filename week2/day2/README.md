
# SQL NULL Functions Practice

This repository contains SQL practice questions and solutions focused on handling `NULL` values in MySQL using:

* `IS NULL`
* `IS NOT NULL`
* `ISNULL()`
* `COALESCE()`
* `NULLIF()`



# Files Description

## 1. NULL_Functions.sql

Contains:

* Sample table creation
* Insert statements with NULL values
* NULL handling queries
* Real-time SQL scenarios
* Advanced NULL function examples

---

# Tables Used

## Employees

Contains employee details with NULL salary, bonus, and manager values.

### Columns

* `emp_id`
* `name`
* `salary`
* `bonus`
* `manager_id`

---

## Orders

Contains customer orders with NULL amount, discount, and coupon values.

### Columns

* `order_id`
* `customer_name`
* `amount`
* `discount`
* `coupon_code`

---

## Products

Contains product details with NULL price, category, and stock values.

### Columns

* `product_id`
* `product_name`
* `price`
* `category`
* `stock`

---

# SQL Concepts Practiced

## NULL Filtering

* `IS NULL`
* `IS NOT NULL`

Examples:

* Find employees with NULL salary
* Find orders with available discounts
* Find products with missing categories

---

## ISNULL()

Used to replace NULL values with default values.

Examples:

* Replace NULL salary with `0`
* Replace NULL stock with `0`
* Replace NULL amount with `500`

---

## COALESCE()

Returns the first non-NULL value.

Examples:

* Salary → Bonus → Default value
* Product price fallback
* Customer payment fallback

---

## NULLIF()

Returns NULL when two values are equal.

Examples:

* Convert `0` discount to NULL
* Avoid divide-by-zero errors
* Replace specific coupon codes with NULL

---

# Practice Levels

| Level   | Topics                   |
| ------- | ------------------------ |
| Level 1 | Basic NULL Filtering     |
| Level 2 | ISNULL()                 |
| Level 3 | COALESCE()               |
| Level 4 | NULLIF()                 |
| Level 5 | Real-Time NULL Scenarios |
| Level 6 | Advanced NULL Handling   |

---

# Topics Covered

## NULL Conditions

* `IS NULL`
* `IS NOT NULL`

## NULL Functions

* `ISNULL()`
* `COALESCE()`
* `NULLIF()`

## Real-Time Scenarios

* Salary calculations
* Bonus handling
* Product stock validation
* Order payment calculations
* Divide-by-zero prevention

---

# Total Practice Questions

| Section | Questions |
| ------- | --------- |
| Level 1 | 4         |
| Level 2 | 4         |
| Level 3 | 4         |
| Level 4 | 4         |
| Level 5 | 4         |
| Level 6 | 4         |
| Total   | 24        |

---

# Learning Outcomes

After completing this practice set, you will understand:

* How to handle NULL values in SQL
* Difference between `ISNULL`, `COALESCE`, and `NULLIF`
* Writing NULL-safe calculations
* Real-world NULL handling scenarios
* Preventing calculation and division errors in SQL

---

# SQL Functions Used

## NULL Functions

* `ISNULL()`
* `COALESCE()`
* `NULLIF()`

## Conditional Operators

* `IS NULL`
* `IS NOT NULL`

## Numeric Operations

* Addition
* Subtraction
* Division

---

