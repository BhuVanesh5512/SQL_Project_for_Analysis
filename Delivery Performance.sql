
select * from olist_orders_dataset;

 #-- 
-- select order_id, time(order_approved_at) as st, time(order_delivered_customer_date) as ed from olist_orders_dataset where order_status="delivered";
-- select order_id,  from (select order_id, time(order_approved_at) as st, time(order_delivered_customer_date) as ed from olist_orders_dataset where order_status="delivered") as t1 group by order_id;
#--
use sql_project;
#1. What is the average delivery time?
select minute(order_delivered_customer_date) from olist_orders_dataset;

select datediff(order_delivered_customer_date,order_approved_at) as days_of_delivery from olist_orders_dataset where order_status = "delivered";

select round((avg(day(days_of_delivery))),2) as average_delivery_time from (select datediff(order_delivered_customer_date,order_approved_at) as days_of_delivery from olist_orders_dataset where order_status = "delivered") as p;

#2. What is the minimum delivery time?
select min(minute(days_of_delivery)) as minium_delivery_time from (select datediff(order_delivered_customer_date,order_approved_at) as days_of_delivery from olist_orders_dataset where order_status = "delivered") as p;

