
select * from olist_orders_dataset;
select count(order_id) from olist_orders_dataset;
 
use sql_project;
#1. What is the average delivery time?
select * from (select datediff(order_delivered_customer_date, order_purchase_timestamp) as days_of_delivery from (select order_delivered_customer_date,order_purchase_timestamp from olist_orders_dataset where order_status = "delivered" and order_delivered_customer_date is not null and order_purchase_timestamp is not null) as t1 order by days_of_delivery asc) as t2 where days_of_delivery is not null;

select round(avg(day(days_of_delivery)),2) as average_delivered_time  from (select datediff(order_delivered_customer_date, order_purchase_timestamp) as days_of_delivery from (select order_delivered_customer_date,order_purchase_timestamp from olist_orders_dataset where order_status = "delivered" and order_delivered_customer_date is not null and order_purchase_timestamp is not null) as t1 order by days_of_delivery asc) as t2 where days_of_delivery is not null;
#11.20 

#2. What is the minimum delivery time?
select min(day(days_of_delivery)) as average_delivered_time  from (select datediff(order_delivered_customer_date, order_purchase_timestamp) as days_of_delivery from (select order_delivered_customer_date,order_purchase_timestamp from olist_orders_dataset where order_status = "delivered" and order_delivered_customer_date is not null and order_purchase_timestamp is not null) as t1 order by days_of_delivery asc) as t2 where days_of_delivery is not null;
#0

#3. What is the maximum delivery time?
select max(day(days_of_delivery)) as average_delivered_time  from (select datediff(order_delivered_customer_date, order_purchase_timestamp) as days_of_delivery from (select order_delivered_customer_date,order_purchase_timestamp from olist_orders_dataset where order_status = "delivered" and order_delivered_customer_date is not null and order_purchase_timestamp is not null) as t1 order by days_of_delivery asc) as t2 where days_of_delivery is not null;
#31

#4.  Which states have the fastest delivery?


#5. Which states have the slowest delivery?


#6. Which cities experience the longest delivery times?


#7. How many orders arrived before the estimated delivery date?
select count(order_id) as order_count from (select order_id , days_delivery_time from (select order_id, datediff(order_estimated_delivery_date, order_delivered_customer_date) as days_delivery_time from olist_orders_dataset where order_status = "delivered" and order_estimated_delivery_date is not null and order_delivered_customer_date is not null) as t1 where days_delivery_time is not null and days_delivery_time>= 0) as t2;
#88644 #89936

select count(order_id) as order_count from olist_orders_dataset where order_status = "delivered" and order_estimated_delivery_date is not null and order_delivered_customer_date is not null and order_estimated_delivery_date > order_delivered_customer_date;
#88652

#8. How many orders arrived after the estimated delivery date?
select count(order_id) from (select order_id , days_delivery_time from (select order_id, datediff(order_estimated_delivery_date, order_delivered_customer_date) as days_delivery_time from olist_orders_dataset where order_status = "delivered" and order_estimated_delivery_date is not null and order_delivered_customer_date is not null) as t1 where days_delivery_time is not null and days_delivery_time< 0) as t2;
#6534
select count(order_id) as order_count from olist_orders_dataset where order_status = "delivered" and order_estimated_delivery_date is not null and order_delivered_customer_date is not null and order_estimated_delivery_date < order_delivered_customer_date;
#7826

#9. What percentage of orders were delivered late?
alter table olist_orders_dataset add column arrived varchar(255);

update olist_orders_dataset set arrived = 
CASE
WHEN order_delivered_customer_date >
order_estimated_delivery_date
THEN 'Late'
ELSE 'On Time'
END;

select arrived, count(arrived) as each_count from olist_orders_dataset group by arrived;
select sum(each_count) from (select arrived, count(arrived) as each_count from olist_orders_dataset group by arrived) as t1;

select arrived, round((each_count)/(select sum(each_count) from (select arrived, count(arrived) as each_count from olist_orders_dataset group by arrived) as t1),2)*100 as percentage from (select arrived, count(arrived) as each_count from olist_orders_dataset group by arrived) as t2;

-- On Time	92.00
-- Late	8.00