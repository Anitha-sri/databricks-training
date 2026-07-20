# E-Commerce Data Engineering Mini Project

## Project Overview

This project demonstrates a simple Data Engineering pipeline using PySpark in Databricks following the Medallion Architecture.

### Bronze Layer
- Read raw CSV data
- Store raw data in Parquet

### Silver Layer
- Remove null values
- Remove duplicate records
- Create calculated columns
- Store cleaned data

### Gold Layer
- Region-wise Sales
- Category-wise Profit
- Monthly Revenue
- Top Selling Products
- Payment Mode Analysis

## Technologies

- PySpark
- Spark SQL
- Databricks
- Parquet

## Architecture

Raw CSV
↓
Bronze
↓
Silver
↓
Gold

## Output

- Bronze Parquet
- Silver Parquet
- Gold Business Reports
