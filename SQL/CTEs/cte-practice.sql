-- 1. Find customers whose total sales exceed 5000
with cust_sales as
(
select customer_id,round(sum(sales),2) as total_sales
from fact_orders
group by customer_id
)
select * from cust_sales
where total_sales >5000;

-- 2. Find products with average profit greater than 1000
with product_profit as
(
select product_id, round(avg(profit),2) as avg_profit
from fact_orders
group by product_id
)
select * from product_profit
where avg_profit >1000;

-- 3. Calculate total sales by state
with state_sales as
(
select state, round(sum(sales),2) as total_sales
from fact_orders o 
join dim_customers c 
on o.customer_id=c.customer_id
group by state
)
select * from state_sales
order by state asc;
-- 4. Find the top-selling category
with sales_category as
(
select category,sum(sales) as total_sales
from fact_orders o
join  dim_products p
on o.product_id=p.product_id
group by category
)
select * from sales_category
order by total_sales desc
limit 1;
-- 5. Find customers whose sales are above average customer sales
with customer_sales as
( 
select customer_id, round(sum(sales),2) as total_sales
from fact_orders
group by customer_id
),
avg_sales as
(
select avg(total_sales) as avg_total_sales
from customer_sales
)
select * from customer_sales
where total_sales>(select avg_total_sales from avg_sales);

-- 6. Calculate profit contribution percentage by category
with categorywise as
(
select category, sum(profit) as category_profit
from fact_orders o 
join dim_products p
on o.product_id=p.product_id
group by category
),
total_category_profit as
(
select sum(category_profit) as total_profit
from categorywise
)
select category, round(category_profit/total_profit *100,2) as percent
from total_category_profit
cross join categorywise;

-- 7. Find orders shipped later than average shipping time
with shipping_days as
(
select distinct order_id,datediff(ship_date,order_date) as ship_days
from fact_orders
),
avg_shipping_days as
(
select avg(ship_days) as avg_ship_days 
from shipping_days
)
select * from shipping_days
where ship_days>(select avg_ship_days from avg_shipping_days);

-- 8. Rank customers by total sales
with ranking as
(
select customer_id, round(sum(sales),2) as total_sales,
 dense_rank() over(
			order by sum(sales) desc
			) as rank_sales
from fact_orders
group by customer_id
)
select * from ranking;
-- 9. Find top 3 customers in each state
with customer_sales as
(
select o.customer_id,state, round(sum(sales),2) as total_sales
from fact_orders o
join dim_customers c
on o.customer_id=c.customer_id
group by o.customer_id,state
),
rnk as
(
select customer_id, state, total_sales, rank() over(partition by state order by total_sales desc) as rank_customer
from customer_sales
)
select * 
from rnk
where rank_customer<=3;
-- 10. Find month-over-month sales growth
with month_sales as
(
select date_format(order_date,'%m') as sale_month,sum(sales) as total_sales
from fact_orders
group by sale_month
order by sale_month asc
)
select * from month_sales;