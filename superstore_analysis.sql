--What are the total sales?
select sum(sales) as total_sales from superstore;

--What was the best selling category?
select category, sum(sales) as category_sales from superstore group by category order by category_sales desc limit 1;

-- What were the sales per year?
select extract(year from order_date) as order_year, sum(sales) as year_sales from superstore group by order_year;

--What are top 10 customers?
select customer_name, sum(sales) as purchase_amount from superstore group by customer_name order by purchase_amount desc limit 10;

--What are the sales per region ?
select region, sum(sales) as regional_sales from superstore group by region;

--What is the profit per category ?
select category, sum(sales) as category_profit from superstore group by category;

--What are the sales per region
select region, sum(sales) as regional_sales from superstore group by region;

--What is the profit per category
select category, sum(sales) as category_profit from superstore group by category;

--Who is the top customer per region
select customer_name, region, sales from superstore where sales in (select max(sales) from superstore group by region);

--What are the running total of sales
select order_date, sales, sum(sales) over (order by order_date, row_id) as running_profit from superstore;

--Rank customers by revenue
select customer_name, sales, rank() over (order by sales desc) from (
    select customer_name, sum(sales) as sales from superstore group by customer_name );

--Which category is declining?
with category_trend as 
(select category, extract(year from order_date) as order_year, sum(sales) as category_sales from superstore group by category, order_year order by order_year)
select category, order_year, category_sales, lag(category_sales) over (partition by category order by order_year) as lag_sales, 
case 
	when category_sales > lag(category_sales) over (partition by category order by order_year) then 'increase'
	when category_sales < lag(category_sales) over (partition by category order by order_year) then 'decline' 
	when category_sales = lag(category_sales) over (partition by category order by order_year) then 'no change' 
	else 'null' 
end as trend 
from category_trend;

--Which is the most profitable region?
select region, sum(sales) as most_profitable_region from superstore group by region order by most_profitable_region desc limit 1;

--What is the monthly growth trend?
with monthly_data as 
(select extract(year from order_date) as order_year, extract(month from order_date) as order_month, sum(sales) as monthly_sales from superstore group by order_year, order_month order by order_year, order_month)
select order_year, order_month, monthly_sales, lag(monthly_sales) over (order by order_year, order_month) as previous_month_sales,
round((monthly_sales - lag(monthly_sales) over (order by order_year, order_month)) * 100/
nullif (lag(monthly_sales) over (order by order_year, order_month), 0), 2) as monthly_growth_percentage
from monthly_data;

--What is the average shipping delay?
select avg((ship_date - order_date)) as average_shipping_delay
from superstore;