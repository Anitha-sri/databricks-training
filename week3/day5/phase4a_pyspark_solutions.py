from pyspark.sql import SparkSession
from pyspark.sql import functions as F
from pyspark.ml.feature import Bucketizer

# 1. Initialize Spark Session
spark = SparkSession.builder.appName('SparkPlayground_Phase4A').getOrCreate()

# 2. Load Real Playground Datasets
customers = spark.read.option("header", "true").option("inferSchema", "true").csv("/samples/customers.csv")
sales = spark.read.option("header", "true").option("inferSchema", "true").csv("/samples/sales.csv")

# Clean baseline datasets (drop entries missing critical customer links)
customers_clean = customers.dropna(subset=["customer_id"])
sales_clean = sales.dropna(subset=["customer_id"])

# Fix: Create the 'name' column by concatenating first_name and last_name
customers_with_name = customers_clean.withColumn(
    "name", 
    F.concat_ws(" ", F.col("first_name"), F.col("last_name"))
)

# 3. Create Aggregated Metrics (Total Spend per Customer)
customer_spend = sales_clean.groupby("customer_id") \
                            .agg(F.sum("total_amount").alias("total_spend")) \
                            .join(customers_with_name.select("customer_id", "name"), on="customer_id", how="inner") \
                            .cache() # Cache for multiple method testing

print("==================================================")
print("🚀 PHASE 4A: BUCKETING & SEGMENTATION OUTPUTS 🚀")
print("==================================================")

# ------------------------------------------------
# Task 1 & 2: Conditional Logic & Aggregation
# ------------------------------------------------
print("\n📊 [Task 1 & 2]: Conditional Logic Segmentation & Counts")
df_conditional = customer_spend.withColumn(
    "segment_conditional",
    F.when(F.col("total_spend") > 5000, "Gold")
     .when((F.col("total_spend") >= 1000) & (F.col("total_spend") <= 5000), "Silver")
     .otherwise("Bronze")
)
df_conditional.select("customer_id", "name", "total_spend", "segment_conditional").show(10)

# Group data by segment and count customers
print("🧮 Customer Distribution by Segment:")
df_conditional.groupby("segment_conditional").count().orderBy(F.desc("count")).show()


# ------------------------------------------------
# Task 3: Quantile-based Segmentation
# ------------------------------------------------
print("\n📈 [Task 3]: Quantile-based Segmentation (33rd & 66th Percentiles)")
quantiles = customer_spend.approxQuantile("total_spend", [0.33, 0.66], 0.01)
q33, q66 = quantiles[0], quantiles[1]

print(f"Calculated Dynamic Thresholds -> 33rd Pct: ${q33:.2f}, 66th Pct: ${q66:.2f}")

df_quantile = customer_spend.withColumn(
    "segment_quantile",
    F.when(F.col("total_spend") > q66, "Tier 1 (High)")
     .when((F.col("total_spend") >= q33) & (F.col("total_spend") <= q66), "Tier 2 (Mid)")
     .otherwise("Tier 3 (Low)")
)
df_quantile.select("customer_id", "name", "total_spend", "segment_quantile").show(10)


# ------------------------------------------------
# Task 4: Bucketizer (MLlib Approach for Comparison)
# ------------------------------------------------
print("\n🪣 [Task 4]: Comparison using MLlib Bucketizer")
splits = [-float("inf"), 1000.0, 5000.0, float("inf")]
bucketizer = Bucketizer(splits=splits, inputCol="total_spend", outputCol="bucket_index")

df_bucketed = bucketizer.transform(customer_spend)
df_bucketed.select("customer_id", "name", "total_spend", "bucket_index").show(10)

print("==================================================")
