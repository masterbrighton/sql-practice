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