from pyspark.sql import SparkSession
from pyspark.sql import functions as F

# 1. Spark Session Initialize
spark = SparkSession.builder.appName('SparkPlayground').getOrCreate()

# 2. Source Data Loading
customers = spark.read.option("header", "true").option("inferSchema", "true").csv("/samples/customers.csv")
orders = spark.read.option("header", "true").option("inferSchema", "true").csv("/samples/sales.csv")

# 3. Base Data Cleaning (Null handling)
customers_clean = customers.dropna(subset=["customer_id"])
orders_clean = orders.dropna(subset=["customer_id"])

print("==================================================")
print("🚀 ALL BUSINESS PIPELINE EXERCISES OUTPUTS 🚀")
print("==================================================")

# ------------------------------------------------
# Exercise 1: Daily Sales Calculation
# ------------------------------------------------
print("\n📊 [Exercise 1]: Daily Sales (Cleaned Nulls)")
daily_sales = orders_clean.dropna(subset=["sale_date", "total_amount"]) \
                          .groupby("sale_date") \
                          .agg(F.sum("total_amount").alias("daily_sales")) \
                          .orderBy("sale_date")
daily_sales.show(5)

# ------------------------------------------------
# Exercise 2: City-wise Revenue
# ------------------------------------------------
print("\n🏙️ [Exercise 2]: City-wise Revenue")
city_revenue = orders_clean.join(customers_clean, on="customer_id", how="inner") \
                           .dropna(subset=["city"]) \
                           .groupby("city") \
                           .agg(F.sum("total_amount").alias("city_revenue")) \
                           .orderBy(F.desc("city_revenue"))
city_revenue.show(5)

# ------------------------------------------------
# Exercise 3: Find Repeat Customers (>2 orders)
# ------------------------------------------------
print("\n🔄 [Exercise 3]: Repeat Customers (>2 Orders)")
repeat_customers = orders_clean.groupby("customer_id") \
                               .agg(F.count("sale_id").alias("order_count")) \
                               .filter(F.col("order_count") > 2) \
                               .orderBy(F.desc("order_count"))
repeat_customers.show(5)

# ------------------------------------------------
# Exercise 4: Highest Spending Customer in Each City (Fully Fixed)
# ------------------------------------------------
print("\n👑 [Exercise 4]: Highest Spending Customer in Each City")
# Step A: Total spend per customer per city
customer_spend = orders_clean.join(customers_clean, on="customer_id", how="inner") \
                             .groupby("city", "customer_id") \
                             .agg(F.sum("total_amount").alias("total_spent"))

# Step B: Max spend per city (Renaming city to max_city to avoid ambiguity)
max_spend_per_city = customer_spend.groupby("city") \
                                   .agg(F.max("total_spent").alias("max_spent")) \
                                   .withColumnRenamed("city", "max_city")

# Step C: Join back using string names and select clean columns
highest_spender = customer_spend.join(
    max_spend_per_city,
    (customer_spend.city == max_spend_per_city.max_city) & 
    (customer_spend.total_spent == max_spend_per_city.max_spent),
    how="inner"
).select("city", "customer_id", "total_spent").orderBy("city")

highest_spender.show(5)
# ------------------------------------------------
# Exercise 5: Final Reporting Table
# ------------------------------------------------
print("\n📋 [Exercise 5]: Final Reporting Table")
final_reporting = customers_clean.join(orders_clean, on="customer_id", how="left") \
                                 .groupby("customer_id", "city") \
                                 .agg(F.sum("total_amount").alias("total_spent"),
                                      F.count("sale_id").alias("order_count")) \
                                 .orderBy("customer_id")
final_reporting.show(10)

print("==================================================")
print("✅ All Exercises Executed Successfully!")
print("==================================================")
