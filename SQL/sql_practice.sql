select * from sales;
-- 1. Show all orders from California
select * 
from sales
where state="California";

-- 2. Find total sales
select sum(sales) as 'total sales'
from sales;

-- 3. Find total profit by state
select state, sum(profit) as 'total profit'
from sales
group by state;

-- 4.Find top 5 products by sales
select product_name, sum(sales) as 'total sales'
from sales
group by product_name
order by sum(sales) desc limit 5;

-- 5. count total orders
select count( distinct order_id) from sales;

-- 6. Find average profit margin by category
select category, avg(profit_margin) 
from sales
group by category;

-- 7. Find orders shipped after 3 days
select order_date, ship_date, ship_date-order_date as shipping_days
from sales
where order_date+3<ship_date;

-- 8. Find top 3 cities with highest sales
select city, sum(sales) as 'total sales'
from sales
group by city
order by 'total sales' desc
limit 3;

-- 9. Find customers who made multiple orders
select order_id,count(order_id)
from sales
group by order_id
having count(order_id)>1;

-- 10. Find loss-making products
select product_name, sum(profit)
from sales
group by product_name
having sum(profit)<0;

-- 11. Find monthly sales trend
select sum(sales) as monthly_sales, sum(profit) as monthly_profit,month(order_date) as sales_month
from sales
group by sales_month
order by sales_month asc;

-- 12. Find running total sales
select order_date,sales,
sum(sales) over(order by order_date) as running_total
from sales;

-- 13. Rank products by sales within each category
select category, product_name, sum(sales), rank()
over(partition by category order by sum(sales) )
from sales
group by category, product_name;

-- 14.Find second highest sales in each state
with statewise_sales as
(
select state,sales, dense_rank() over(partition by state order by sales desc) as highest
from sales
)
select * from statewise_sales
where highest=2;

-- 15. Find percentage contribution of each category to total sales
select category,round(sum(sales)/(select sum(sales) from sales)*100,2)
from sales
group by category;
-- alternate solution using window fn
select category, round(sum(sales)*100/sum(sum(sales)) over(),2) from sales 
group by category;

-- 16. Detect duplicate records


