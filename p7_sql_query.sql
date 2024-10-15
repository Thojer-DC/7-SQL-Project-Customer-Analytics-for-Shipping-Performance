CREATE DATABASE shipment_db;

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

SELECT *
FROM shipments;



-- Objectives for the project:
-- 1.	Shipping Performance Analysis:
-- 		Analyze how different modes of shipment affect the delivery performance. We want to understand which modes result in products reaching on time.
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




-- 2.	Customer Satisfaction Metrics:
-- 		Evaluate the relationship between customer ratings and whether the products reached on time.
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



-- 3.	Impact of Discounts:
-- 		Investigate how discounts offered on products correlate with customer ratings and shipping performance.
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


-- 4.	Weight Analysis:
-- 		Analyze how the weight of products influences delivery performance and customer ratings.
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



-- 5.	Warehouse Block Analysis:
-- 		Examine if the warehouse block (A, B, C, D, E) has any impact on shipping times and customer satisfaction.
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






