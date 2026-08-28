#1. What is the total product sales value?
select round(sum(price)) as total_product_sales from olist_order_items_dataset;
#13591644

#2. What is the total freight value?
select round(sum(freight_value),2) as total_freight_value from olist_order_items_dataset;
#2251909.54

#3. What is the total revenue including freight?
select round(sum(price)+sum(freight_value),2) as total_revenue from olist_order_items_dataset;
#15843553.24

#4. What is the average order value?
select round(avg(price)) as average_order_value from olist_order_items_dataset;
#121

#5. What is the highest-value order?
select max(price) as highest_value_order from olist_order_items_dataset;
#6735

#6. What is the lowest-value order?
select min(price) as lowest_value_order from olist_order_items_dataset;
#0.85


#7. How much revenue is generated each year?
select year(shipping_limit_date) as year , round(sum(price)+sum(freight_value),2) as revenue_of_year from olist_order_items_dataset group by year;

-- 2017	7000608.86
-- 2018	8785262.97
-- 2016	57183.21
-- 2020	498.2

#8. How much revenue is generated each month?
select month(shipping_limit_date) as month , year(shipping_limit_date) as year, round(sum(price)+sum(freight_value),2) as revenue_of_month from olist_order_items_dataset group by year, month order by year, revenue_of_month desc;

#9. Which month generated the highest revenue?
select month, year, revenue_of_month from (select * ,row_number() over(partition by year) w from (select month(shipping_limit_date) as month , year(shipping_limit_date) as year, round(sum(price)+sum(freight_value),2) as revenue_of_month from olist_order_items_dataset group by year, month order by year,revenue_of_month desc) as t) as j where w = 1;

#10. Which month generated the lowest revenue?
select month, year, revenue_of_month  from (select * ,row_number() over(partition by year) w from (select month(shipping_limit_date) as month , year(shipping_limit_date) as year, round(sum(price)+sum(freight_value),2) as revenue_of_month from olist_order_items_dataset group by year, month order by year,revenue_of_month) as t) as j where w = 1;

