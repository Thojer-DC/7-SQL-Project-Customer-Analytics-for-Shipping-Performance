# Customer Analytics for Shipping Performance

![](https://github.com/Thojer-DC/7-SQL-Project-Customer-Analytics-for-Shipping-Performance/blob/main/shipment.jpg)

## Overview
In order to assess shipping performance and customer happiness, this project analyzes customer data. The goal is to determine everything that affect the speed of delivery and how they connect to discounts and ratings from customers.

## Objective
1. Analyze shipping speed according to the shipment method.
2. Analyze the connection between shipment performance and customer ratings.
3. Analyze how discounts affect shipment performance and consumer happiness.
4. Analyze how product weight affects speed of delivery.
5. Compare the difference in performance between different warehouse blocks.

## Dataset
The data for this project is sourced from Kaggle
Dataset Link: https://www.kaggle.com/datasets/prachi13/customer-analytics


## SQL Schema
**Creating database** 
```SQL
   CREATE DATABASE shipment_db;

```

**Creating table** 
```SQL
   DROP TABLE IF EXISTS shipments;
   CREATE TABLE shipments
   (
      Customer_id INT,
      Warehouse_block VARCHAR(5),
      Shipment_mode VARCHAR(10),
      Customer_care_calls INT,
      Customer_rating INT,
      Cost_of_the_Product DECIMAL(10,2),
      Prior_purchases INT,
      Product_importance VARCHAR(15),
      Gender VARCHAR(5),
      Discount_offered DECIMAL(10,2),
      Weight_in_gms INT,
      Reached_on_Time INT
   );
```


## SQL Query

**Shipping Performance by Mode of Shipment**

```SQL
   SELECT
      shipment_mode,
      ROUND(
         COUNT(CASE WHEN reached_on_time = 1 THEN 1 END)::numeric / COUNT(*) * 100, 2
      )AS on_time_percentage,
      ROUND(
         COUNT(CASE WHEN reached_on_time = 0 THEN 1 END)::numeric / COUNT(*) * 100, 2
      )AS late_percentage
   FROM shipments
   GROUP BY shipment_mode;
```


**Customer Satisfaction Metrics**

```SQL
   SELECT 
      customer_rating,
      ROUND(
         COUNT(CASE WHEN reached_on_time = 1 THEN 1 END)::numeric / COUNT(*) * 100, 2
      )AS on_time_percentage,
      ROUND(
         COUNT(CASE WHEN reached_on_time = 0 THEN 1 END)::numeric / COUNT(*) * 100, 2
      )AS late_percentage
   FROM shipments
   GROUP BY customer_rating
   ORDER BY customer_rating;
```


**Impact of Discounts on Shipping Performance**

```SQL
   SELECT 
      CASE 
         WHEN discount_offered < 10 THEN 'Small Discount'
         WHEN discount_offered BETWEEN 10 AND 30 THEN 'Medium Discount'
         ElSE 'Large Discount'
      END AS discount_catergory,
      ROUND(AVG(customer_rating),2) AS average_rating,
      ROUND(
         COUNT(CASE WHEN reached_on_time = 1 THEN 1 END)::numeric / COUNT(*) * 100, 2
      )AS on_time_percentage,
      ROUND(
         COUNT(CASE WHEN reached_on_time = 0 THEN 1 END)::numeric / COUNT(*) * 100, 2
      )AS late_percentage
   FROM shipments
   GROUP BY discount_catergory
```


**Weight Analysis**

```SQL
   SELECT 
      CASE 
         WHEN weight_in_gms < 2000 THEN 'light'
         WHEN weight_in_gms BETWEEN 2000 AND 5000 THEN 'medium'
         ElSE 'heavy'
      END AS weight_catergory,
      ROUND(
         COUNT(CASE WHEN reached_on_time = 1 THEN 1 END)::numeric / COUNT(*) * 100, 2
      )AS on_time_percentage,
      ROUND(
         COUNT(CASE WHEN reached_on_time = 0 THEN 1 END)::numeric / COUNT(*) * 100, 2
      )AS late_percentage
   FROM shipments
   GROUP BY weight_catergory; 
```


**Warehouse Block Analysis**

```SQL
   SELECT 
      warehouse_block,
      ROUND(
         COUNT(CASE WHEN reached_on_time = 1 THEN 1 END)::numeric / COUNT(*) * 100, 2
      )AS on_time_percentage,
      ROUND(
         COUNT(CASE WHEN reached_on_time = 0 THEN 1 END)::numeric / COUNT(*) * 100, 2
      )AS late_percentage
   FROM shipments
   GROUP BY warehouse_block
   ORDER BY warehouse_block;
```

## Findings and Recommendations

**Findings:**  

1. The mode of shipment Flight has the highest percentage of on-time time delivery rates with 60.16 compared to others
2. High customer ratings have to do with increased shipment performance, implying that satisfied customers are more likely to receive their orders on time.
3. Discounts don't seem significantly correlated with customer ratings, showing that price reductions alone could not boost customer satisfaction.
4. Heavier products have lower percentages of on-time deliveries, which could be caused by transporting challenges.
5. Some warehouse blocks show number on-time performance, focusing on potential improvements in operation.

**Recommendations:**
  
1. Consider prioritizing faster shipping method to enhance customer satisfaction.
2. Consider improving customer suppport to address shipment inquiries effectively with products with low on-time performance
3. Further analyze consumer buying trends to develop focused offers that can raise satisfaction ratings.
4. Examine the logistical procedures for Heavier items in order to find and fix any problems.
5. Look into and improve warehouse operations to increase ratings in blocks that aren't operating well.


