drop table if exists zepto;

create table zepto (
sku_id SERIAL PRIMARY KEY,
category VARCHAR(120),
name VARCHAR(150) NOT NULL,
mrp NUMERIC(8,2),
discountPercent NUMERIC(5,2),
availableQuantity INTEGER,
discountedSellingPrice NUMERIC(8,2),
weightInGms INTEGER,
outOfStock BOOLEAN,	
quantity INTEGER
);


--data exploration

--count of rows
select count(*) from zepto;

--sample data
SELECT * FROM zepto
LIMIT 10;

--null values
SELECT * FROM zepto
WHERE name IS NULL
OR
category IS NULL
OR
mrp IS NULL
OR
discountPercent IS NULL
OR
discountedSellingPrice IS NULL
OR
weightInGms IS NULL
OR
availableQuantity IS NULL
OR
outOfStock IS NULL
OR
quantity IS NULL;

--different product categories
SELECT DISTINCT category
FROM zepto
ORDER BY category;

--products in stock vs out of stock
SELECT outOfStock, COUNT(sku_id)
FROM zepto
GROUP BY outOfStock;

--product names present multiple times
select name , count(sku_id) as "number of SKUs"
from zepto
group by name
having count(sku_id) >1
order by count(sku_id) desc

--data cleaning

--products with price=0
select * from zepto
where mrp =0 or discountedSellingPrice =0

delete from zepto 
where mrp =0

--convert paise to rupees
update zepto
set mrp = mrp/100.0,
discountedSellingPrice=discountedSellingPrice/100.0

select mrp, discountedSellingPrice from zepto


-- business insights and data analysis

-- Q1. Find the top 10 best-value products based on the discount percentage.
select distinct name, mrp, discountPercent
from zepto
order by discountPercent desc
limit 10

--Q2.What are the Products with High MRP but Out of Stock
select distinct name, mrp
from zepto
where outOfStock= true and mrp >300
order by mrp desc

--Q3.Calculate Estimated Revenue for each category
select category,
sum(discountedSellingPrice * availableQuantity) as total_revenue
from zepto
group by category
order by total_revenue

-- Q4. Find all products where MRP is greater than ₹500 and discount is less than 10%.
select distinct name, mrp, discountPercent
from zepto
where mrp>500 and discountPercent <10
order by mrp desc , discountPercent desc

-- Q5. Identify the top 5 categories offering the highest average discount percentage.
select category, 
round(avg(discountPercent),2) as avg_discount
from zepto
group by category
order by avg_discount desc
limit 5

-- Q6. Find the price per gram for products above 100g and sort by best value.
select distinct name, weightInGms, discountedSellingPrice,
round((discountedSellingPrice/weightInGms),2) as price_per_gram
from zepto
where weightInGms>=100
order by price_per_gram

--Q7.Group the products into weight categories like Low, Medium, Bulk.
select distinct name, weightInGms,
case when weightInGms <1000 then 'LOW'
     when weightInGms < 5000 then 'MEDIUM'
	 else 'BULK'
	 end as weight_category
from zepto	

--Q8.What is the Total Inventory Weight Per Category 
SELECT category,
sum(weightInGms * availableQuantity) as total_weight
from zepto
group by category
order by total_weight

--Q9. Inventory Value per Category
select category,
round(sum(mrp * availableQuantity),2) as inventory_value
from zepto
group by category
order by inventory_value

--Q10. Rank the Most Expensive Products Within Each Category
select distinct name, category, discountedSellingPrice,
RANK()  over(partition by category order by discountedSellingPrice desc) as price_rank
from zepto
order by price_rank

--Q11. Top 3 Most Expensive Products Per Category
with ranked_products as (
select distinct name, category, discountedSellingPrice,
RANK()  over(partition by category order by discountedSellingPrice desc) as rank_in_category
from zepto
order by  rank_in_category
)

select * from ranked_products
where rank_in_category <=3

--Q12. Category Contribution to Total Revenue    (this is a very important business KPI)
select category,
sum(discountedSellingPrice * availableQuantity) as category_revenue,
Round(sum(discountedSellingPrice * availableQuantity) * 100.0/ sum(sum(discountedSellingPrice * availableQuantity)) over(),2) as revenue_percentage
from zepto
group by category
order by revenue_percentage desc

--Q13. Identify Products Priced Above Their Category Average.
select distinct name, category,mrp, avg_price
from(
       select distinct name, category, mrp,
	   round(avg(mrp) over(partition by category),2) as avg_price
	   from zepto
      )as subquery
	  where mrp > avg_price
	  order by category, mrp desc

