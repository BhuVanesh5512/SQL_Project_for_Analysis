use sql_project;

#Calculate  previous month's revenue, revenue difference, and month-over-month growth percentage.

#monthly revenue
select month(shipping_limit_date) as month , year(shipping_limit_date) as year, round(sum(price)+sum(freight_value),2) as revenue_of_month from olist_order_items_dataset group by year, month order by year, revenue_of_month desc;

#previous month's
select *, lag(month_revenue) over (order by year,month) as previous_month_revenue from (select month(shipping_limit_date) as month , year(shipping_limit_date) as year, round(sum(price)+sum(freight_value),2) as month_revenue from olist_order_items_dataset group by year, month order by year,month) as t;

#revenue difference
select * ,  round(month_revenue - previous_month_revenue,2) as differnce_in_revenue from (select *, lag(month_revenue) over (order by year,month) as previous_month_revenue from (select month(shipping_limit_date) as month , year(shipping_limit_date) as year, round(sum(price)+sum(freight_value),2) as month_revenue from olist_order_items_dataset group by year, month order by year,month) as t) as r;

#month-over-month growth percentage
select * ,  round(month_revenue - previous_month_revenue,2) as differnce_in_revenue, round(((month_revenue - previous_month_revenue)/previous_month_revenue)*100) as growth_percentage from (select *, lag(month_revenue) over (order by year,month) as previous_month_revenue from (select month(shipping_limit_date) as month , year(shipping_limit_date) as year, round(sum(price)+sum(freight_value),2) as month_revenue from olist_order_items_dataset group by year, month order by year,month) as t) as r;

-- select month, round(((month_revenue - previous_month_revenue)/previous_month_revenue)*100) as growth_percentage  from (select * , round(month_revenue - previous_month_revenue,2) as differnce_in_revenue from (select * , lag(month_revenue) over (order by month) as previous_month_revenue from (select month(shipping_limit_date) as month, round(sum(price)+sum(freight_value),2) as month_revenue from olist_order_items_dataset group by month) as t) as r) as k; 

-- select month,round(((monthly_revenue - pr)/pr)*100) as growth_percentage from (select *, lag(monthly_revenue) over(order by month) as previous_monthly_revenue from (select month, round(avg(revenue_of_month),2) as monthly_revenue from (select month(shipping_limit_date) as month , year(shipping_limit_date) as year, round(sum(price)+sum(freight_value),2) as revenue_of_month from olist_order_items_dataset group by year, month) as d group by month order by month asc) as t) as d where pr = (select max(previous_monthly_revenue) as pr from (select *, lag(monthly_revenue) over(order by month) as previous_monthly_revenue from (select month, round(avg(revenue_of_month),2) as monthly_revenue from (select month(shipping_limit_date) as month , year(shipping_limit_date) as year, round(sum(price)+sum(freight_value),2) as revenue_of_month from olist_order_items_dataset group by year, month) as d group by month order by month asc) as t) as d);

-- select max(previous_monthly_revenue) as pr from (select *, lag(monthly_revenue) over(order by month) as previous_monthly_revenue from (select month, round(avg(revenue_of_month),2) as monthly_revenue from (select month(shipping_limit_date) as month , year(shipping_limit_date) as year, round(sum(price)+sum(freight_value),2) as revenue_of_month from olist_order_items_dataset group by year, month) as d group by month order by month asc) as t) as d ;
