
# SQL to PySpark - Phase 4A: Customer Segmentation & Bucketing

This repository contains Phase 4A of my SQL to PySpark learning journey. The focus of this phase is customer segmentation using conditional logic, quantile-based analysis, and bucketing techniques. The same business scenarios are implemented using both SQL and PySpark to understand how analytical logic translates into DataFrame transformations.

## Repository Structure

```text
day5/
├── outputs/
│   ├── phase4a_1&2op.png
│   └── phase4a_3&4op.png
├── customers.csv
├── sales.csv
├── phase4a_questions.txt
├── phase4a_sql_solutions.sql
├── phase4a_pyspark_solutions.py
└── README.md
```

## Files

| File | Description |
|------|-------------|
| `phase4a_questions.txt` | Practice questions and task descriptions |
| `phase4a_sql_solutions.sql` | SQL solutions for all exercises |
| `phase4a_pyspark_solutions.py` | Equivalent PySpark DataFrame solutions |
| `customers.csv` | Sample customer dataset |
| `sales.csv` | Sample sales dataset |
| `outputs/` | Screenshots of the PySpark execution results |

## Topics Covered

- Reading CSV Files
- Data Cleaning
- Aggregations
- Customer Spend Analysis
- Conditional Logic
- Customer Segmentation
- Quantile-Based Segmentation
- Bucketing
- MLlib Bucketizer
- SQL to PySpark Conversion

## Business Scenarios

- Calculate total spend for each customer
- Segment customers into Gold, Silver, and Bronze categories
- Count customers in each segment
- Perform quantile-based customer segmentation
- Compare conditional logic with MLlib Bucketizer
- Analyze customer spending patterns

## Goal

The objective of this phase is to implement customer segmentation techniques using SQL and PySpark while exploring different approaches for categorizing customers based on their spending behavior.

## Prerequisites

- Basic SQL
- Python
- PySpark
- Apache Spark
- Basic understanding of DataFrame operations and aggregations

---

