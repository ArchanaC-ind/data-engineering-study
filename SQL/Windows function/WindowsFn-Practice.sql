-- 1. Running Total Sales (Global)
select order_id, order_date, sales,
	round(sum(sales) over(
				order by order_date, order_id desc
                ),2) as running_total
from fact_orders;
-- 2. Row Number per Customer
select customer_id,order_id,order_date, 
	row_number() over(
    partition by customer_id order by order_date asc
    ) as row_no
from fact_orders; 
-- 3. First and Last Order per Customer
select customer_id,order_date, first_value(order_date) over(partition by customer_id order by order_date ) as first_order,
last_value(order_date) over(partition by customer_id order by order_date RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW ) as last_order
from fact_orders;

-- 4. Customer Lifetime Value (CLV Ranking)
with customer_sales as 
(
select customer_id, round(sum(sales),2) as total_sales
from fact_orders
group by customer_id
)
select customer_id, total_sales, dense_rank() over(order by total_sales desc) as CLV
from customer_sales;
-- 5. Days Between Orders (Customer Behavior)
with order_gap as
(
select customer_id,order_id, order_date,
	lag(order_date) over(partition by customer_id order by order_date) as prev_order_date
    from fact_orders
    order by customer_id, order_date
)
select *,datediff(order_date, prev_order_date)
from order_gap;

-- 6. Moving Average Sales (7-day trend)
with day_sales as
(
select order_date, sum(sales) as daily_sales
from fact_orders
group by order_date 
)
select order_date, 
	round(avg(daily_sales) over(
	order by order_date 
    rows between 6 preceding and current row
		),2) as moving_avg
from day_sales;

-- 7. Product Contribution to Category Sales
with category_product as
(
select category, o.product_id,
 sum(sales) as product_sales,
 sum(sum(sales)) over(partition by category) as category_sales
from fact_orders o
join dim_products p
on o.product_id=p.product_id
group by category, o.product_id
)
select *, round(product_sales/category_sales*100,2) as contribution
from category_product;
-- 8. Top 3 Products per Category 
with category_sales as
(
select category, o.product_id, round(sum(sales),2) as total_sales
from fact_orders o
join dim_products p 
on o.product_id=p.product_id
group by category, product_id
),
ranking as
(
select *, dense_rank() over(partition by category order by total_sales desc) as rnk
from category_sales
)
select * from ranking 
where rnk<=3;

-- 9. Customer Churn Detection (30-day gap rule)
with days_gap as
(
select customer_id,order_date, lag(order_date) over(partition by customer_id order by order_date , customer_id) as prev_order
from fact_orders
)
select *, datediff(order_date,prev_order),case 
when datediff(order_date,prev_order) >30 then 1
else 0
end as churn_flag
from days_gap
-- 10. Percentile-Based Customer Segmentation (Real DE task)

-- 11. Rolling 3-Order Profit Trend (Advanced window frame)
-- 12. Customer Revenue Share Over Time (Complex window + division)
