-- SQL Retailsales Analysis 
CREATE DATABASE SQL_Project;

USE SQL_Project;

-- Create Table
DROP TABLE IF EXISTS retail_sales;
CREATE TABLE retail_sales
	(
	transactions_id INT PRIMARY KEY,
    sale_date DATE,
    sale_time TIME,
    customer_id	INT,
    gender VARCHAR(15),
    age	INT,
    category VARCHAR(15),	
    quantity	INT,
    price_per_unit FLOAT,	
    cogs FLOAT,
    total_sale FLOAT
);

-- Print Data
SELECT * FROM retail_sales;

-- Total Data 
SELECT 
	COUNT(*)
FROM `sql_project`.`retail_sales`;

-- How many sales we have?
SELECT 
	COUNT(total_sale)
FROM retail_sales;

-- How many customers?
SELECT 
	COUNT(DISTINCT customer_id)
FROM retail_sales;

-- How many category we have?
SELECT
	COUNT(DISTINCT category)
FROM retail_sales;

-- Name the category?
SELECT
	DISTINCT category
FROM retail_sales;

-- DATA ANALYSIS QUESTION

-- 1. Write a SQL query to retrive all columns for sales made on 2022-11-05
SELECT 
	*
FROM retail_sales
WHERE 
	sale_date = "2022-11-05";

-- 2. Write a SQL query to retrive all transactions where the category is "Clothing" and the quantity is sold is more than 10 in the month of Nov-2022
SELECT *
FROM retail_sales
WHERE 
	category = 'Clothing'
    AND 
	quantity >= 4
    AND
    DATE_FORMAT(sale_date, '%Y-%m') = '2022-11';

-- 3. Write a SQL query to calculate the total sales (total_sale) for each category.
SELECT 
	category,
    SUM(total_sale)
FROM retail_sales
GROUP BY category;

-- 4. Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category
SELECT 
	ROUND(AVG(age), 2)
FROM retail_sales
WHERE category = 'Beauty';

-- 5. Write a SQL query to find all transactions where the total_sale is greater than 1000.:
SELECT 
	*
FROM retail_sales
WHERE total_sale >= 1000;

-- 6. Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
SELECT 
	category,
    gender,
    count(*)
FROM retail_sales
GROUP BY category,
	gender
ORDER BY 
	category;

-- 7. Write a SQL query to calculate the average sale for each month. Find out best selling month in each year 
SELECT 
	year,
    month,
    avg_sale
FROM
(
	SELECT 
		YEAR(sale_date) AS year,
		MONTH(sale_date) AS month,
		ROUND(AVG(total_sale), 2) AS avg_sale,
		RANK() OVER(PARTITION BY YEAR(sale_date) ORDER BY(AVG(total_sale)) DESC) as Rank_sale
	FROM retail_sales
	GROUP BY  year, month
) as SQ
WHERE Rank_sale = 1;

-- 8. Write a SQL query to find the top 5 customers based on the highest total sales
SELECT 
	customer_id as Id,
    SUM(total_sale) as Total_sale
FROM retail_sales
GROUP BY Id
ORDER BY total_sale DESC
LIMIT 5;

-- 9. Write a SQL query to find the number of unique customers who purchased items from each category.
SELECT 
    category,
    COUNT(DISTINCT customer_id)
FROM retail_sales
GROUP BY category;

-- 10. Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)
WITH hourly_sale
AS
(
SELECT *,
	CASE
		WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
		WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
		ELSE 'Evening'
	END AS shift
FROM retail_sales
)

SELECT 
	shift,
    COUNT(*)
FROM hourly_sale
GROUP BY shift
	


-- END OF PROJECT


	