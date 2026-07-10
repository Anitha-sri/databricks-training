from pyspark.sql import SparkSession
from pyspark.sql import functions as F

spark = SparkSession.builder.appName('Spark Playground').getOrCreate()
customers = spark.read.option("header", "true").option("inferSchema","true").csv("/samples/customers.csv")
orders = spark.read.option("header", "true").option("inferSchema","true").csv("/samples/sales.csv")


# Data Cleaning 
customers = customers.dropna(subset=["customer_id"])
orders = orders.dropna(subset=["customer_id"])


 -- SOLUTIONS

# 1. Total order amount for each customer
total_count = orders.groupby("customer_id").agg(
    F.sum("total_amount").alias("total_spent")
)
display(total_count)


# 2. Top 3 customers by total spend
top_3_customers = total_count.join(customers, on="customer_id", how="inner") \
                             .select(
                                 "customer_id",
                                 F.concat_ws(" ", customers.first_name, customers.last_name).alias("name"), 
                                 "total_spent"
                             ) \
                             .orderBy(F.desc("total_spent")) \
                             .limit(3)
display(top_3_customers)


# 3. Customers with no orders
no_orders = customers.join(orders, on="customer_id", how="left_anti") \
                     .select(
                         "customer_id", 
                         F.concat_ws(" ", "first_name", "last_name").alias("name")
                     )
display(no_orders)


# 4. City-wise total revenue
city_revenue = orders.join(customers, on="customer_id", how="inner") \
                     .groupby("city") \
                     .agg(F.sum("total_amount").alias("total_revenue")) \
                     .orderBy(F.desc("total_revenue"))
display(city_revenue)


# 5. Average order amount per customer
avg_orders = orders.groupby("customer_id") \
                    .agg(F.avg("total_amount").alias("avg_order_amount"))
display(avg_orders)


# 6. Customers with more than one order
frequent_customers = orders.groupby("customer_id") \
                           .agg(F.count("sale_id").alias("order_count")) \
                           .filter(F.col("order_count") > 1) \
                           .join(customers, on="customer_id", how="inner") \
                           .select(
                               "customer_id", 
                               F.concat_ws(" ", customers.first_name, customers.last_name).alias("name"), 
                               "order_count"
                           )
display(frequent_customers)


# 7. Sort customers by total spend descending
sorted_spend = total_count.join(customers, on="customer_id", how="inner") \
                          .select(
                              "customer_id", 
                              F.concat_ws(" ", customers.first_name, customers.last_name).alias("name"), 
                              "total_spent"
                          ) \
                          .orderBy(F.desc("total_spent"))
display(sorted_spend)

