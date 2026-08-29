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
