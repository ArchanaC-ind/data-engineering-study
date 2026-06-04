
-- 1. Inner Join Practice: Get: order_id, customer email, sales
select order_id, emailid, sales
from fact_orders o
join dim_customers c
on o.customer_id=c.customer_id;

-- 2. Join Fact + Product Dimension: Get: product name, category, quantity, profit
select product_name, category, quantity, profit
from fact_orders o
join dim_products p
on o.product_id=p.product_id;

-- 3. Total Sales by State
select state, round(sum(sales),2) as total_sales
from fact_orders o
join dim_customers c 
on o.customer_id=c.customer_id
group by state;

-- 4. Total Profit by Category
select category, round(sum(profit),2) as total_profit
from fact_orders o
join dim_products p
on o.product_id=p.product_id
group by category;

-- 5.Orders with Customer and Product Info: Return: order_id, customer email, product name, category, sales
select o.order_id, emailid, product_name, category, sales
from fact_orders o
join dim_customers c
join dim_products p 
on o.customer_id=c.customer_id and 
	o.product_id=p.product_id;
    
-- 6. Customers with No Orders
select c.emailid 
from dim_customers c
left join fact_orders o
on c.customer_id=o.customer_id
where order_id is null;

-- 7. Products Never Sold
select product_name
from dim_products p
join fact_orders o
on p.product_id=o.product_id
where order_id is null;

-- 8. Include Zero Sales States
select c.state,order_id
from dim_customers c
left join fact_orders o
on c.customer_id=o.customer_id
where order_id is null;
-- 9.right join
-- 10. Find Missing Dimension Records
-- Suppose some products failed to load into dimension.
-- Find orders whose products do not exist in dim_products.

select order_id
from fact_orders o
left join dim_products p
on o.product_id=p.product_id
union
select order_id
from fact_orders o
left join dim_products p
on o.product_id=p.product_id;


 