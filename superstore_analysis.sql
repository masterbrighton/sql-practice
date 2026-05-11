--What are the total sales?
select sum(sales) as total_sales from superstore;

--What was the best selling category?
select category, sum(sales) as category_sales from superstore group by category order by category_sales desc limit 1;

-- What were the sales per year?
select extract(year from order_date) as order_year, sum(sales) as year_sales from superstore group by order_year;

--What are top 10 customers?
select customer_name, sum(sales) as purchase_amount from superstore group by customer_name order by purchase_amount desc limit 10;
