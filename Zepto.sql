DROP TABLE IF EXISTS zepto;

CREATE TABLE zepto(
sku_id SERIAL PRIMARY KEY,
category VARCHAR(120),
name VARCHAR(150) NOT NULL,
mrp NUMERIC(8,2),
discountPercentage NUMERIC(5,2),
avialableQuantity INTEGER,
dicountSellingPrice NUMERIC(8,2),
weightInGrams Integer,
outOfStock BOOLEAN,
quantity Integer
);

SELECT COUNT(*) FROM zepto; 

--samlpe data
SELECT * FROM zepto;

--categories
SELECT DISTINCT category FROM zepto; 

--product in stock vs out of stock
SELECT outofstock , COUNT(sku_id) FROM zepto
GROUP BY outofstock;

--product name presents multiple times
SELECT name , COUNT(sku_id) FROM zepto
GROUP BY NAME
HAVING COUNT(sku_id) > 1
ORDER BY COUNT(sku_id) DESC;

-- data cleaning

--products with price zero
SELECT * FROM zepto
WHERE mrp = 0;

DELETE FROM zepto
WHERE mrp = 0;

-- convert paise to rupees
UPDATE zepto
SET mrp = mrp/100.0,
dicountsellingprice = dicountsellingprice / 100.0;

SELECT mrp , dicountsellingprice FROM zepto;

--Q1. Find the top 10 best-value products bASed on the discount percentage.
SELECT name, mrp , discountpercentage FROM zepto
ORDER BY discountpercentage DESC
LIMIT 10;

--Q2.What are the Products with High MRP but Out of Stock
SELECT DISTINCT name, mrp , outofstock FROM zepto
WHERE outofstock = 'True'
ORDER BY mrp DESC;

--Q3.Calculate Estimated Revenue for each category
SELECT category , SUM(dicountsellingprice * quantity) AS revenue
FROM zepto
GROUP BY category
ORDER BY revenue;

--Q4. Find all products WHERE MRP is greater than ₹500 and discount is less than 10%.
SELECT DISTINCT name , mrp ,discountpercentage FROM zepto
WHERE mrp > 500 and discountpercentage < 10
	ORDER BY mrp DESC, discountpercentage DESC;

--Q5. Identify the top 5 categories offering the highest average discount percentage.
SELECT category , round(avg(discountpercentage),2) avg_discount FROM zepto
GROUP BY category
ORDER BY avg_discount DESC
LIMIT 5;

--Q6. Find the price per gram for products above 100g and sort by best value.
SELECT DISTINCT name , weightingrams, dicountsellingprice,
round(dicountsellingprice/weightingrams,2) AS price_per_gram
FROM zepto
WHERE weightingrams > 100
ORDER BY price_per_gram;

--Q7.Group the products into categories like Low, Medium, Bulk.
SELECT DISTINCT name , weightingrams,
CASE WHEN weightingrams < 1000 THEN 'Low'
     WHEN weightingrams < 5000 THEN 'Medium'
	 ELSE 'Bulk'
	 END AS weight_category
FROM zepto;

--Q8.What is the Total Inventory Weight Per Category
SELECT category , SUM(weightingrams * quantity) total_wgh FROM zepto
GROUP BY category
ORDER BY total_wgh;






