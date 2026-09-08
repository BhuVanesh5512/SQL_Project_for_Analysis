
select * from olist_orders_dataset;
select count(order_id) from olist_orders_dataset;
 
use sql_project;
#1. What is the average delivery time?
select * from (select timestampdiff(hour,order_purchase_timestamp,order_delivered_customer_date) as time_of_delivery from (select order_delivered_customer_date,order_purchase_timestamp from olist_orders_dataset where order_status = "delivered" and order_delivered_customer_date is not null and order_purchase_timestamp is not null) as t1 order by time_of_delivery desc) as t2 where time_of_delivery is not null;

select round(avg((time_of_delivery)),2) as average_delivered_time  from (select timestampdiff(hour,order_purchase_timestamp,order_delivered_customer_date) as time_of_delivery from (select order_delivered_customer_date,order_purchase_timestamp from olist_orders_dataset where order_status = "delivered" and order_delivered_customer_date is not null and order_purchase_timestamp is not null) as t1 order by time_of_delivery asc) as t2 where time_of_delivery is not null;
#12.54 / 300.90

#2. What is the minimum delivery time?
select round(min(time_of_delivery)/24,2) as min_time from (select timestampdiff(hour,order_purchase_timestamp,order_delivered_customer_date) as time_of_delivery from (select order_delivered_customer_date,order_purchase_timestamp from olist_orders_dataset where order_status = "delivered" and order_delivered_customer_date is not null and order_purchase_timestamp is not null) as t1 order by time_of_delivery asc) as t2 where time_of_delivery is not null;
#12 /0.50

#3. What is the maximum delivery time?
select round(max(time_of_delivery)/24,2) as max_time from (select timestampdiff(hour,order_purchase_timestamp,order_delivered_customer_date) as time_of_delivery from (select order_delivered_customer_date,order_purchase_timestamp from olist_orders_dataset where order_status = "delivered" and order_delivered_customer_date is not null and order_purchase_timestamp is not null) as t1 order by time_of_delivery asc) as t2 where time_of_delivery is not null;
#5031 / 209.63

#4.  Which states have the fastest delivery?
use sql_project;
select customer_state, round(avg(time_of_delivery),2) as average_delivered_time  from (select customer_state, timestampdiff(hour,order_purchase_timestamp, order_delivered_customer_date) as time_of_delivery from (select customer_state, order_delivered_customer_date,order_purchase_timestamp from olist_orders_dataset o inner join  olist_customers_dataset c on o.customer_id = c.customer_id where order_status = "delivered" and order_delivered_customer_date is not null and order_purchase_timestamp is not null ) as t1 order by time_of_delivery asc) as t2 where time_of_delivery is not null group by customer_state order by average_delivered_time asc limit 1;
#SP	209.77

#5. Which states have the slowest delivery?
select customer_state, round(avg(time_of_delivery),2) as average_delivered_time  from (select customer_state, timestampdiff(hour,order_purchase_timestamp, order_delivered_customer_date) as time_of_delivery from (select customer_state, order_delivered_customer_date,order_purchase_timestamp from olist_orders_dataset o inner join  olist_customers_dataset c on o.customer_id = c.customer_id where order_status = "delivered" and order_delivered_customer_date is not null and order_purchase_timestamp is not null ) as t1 order by time_of_delivery asc) as t2 where time_of_delivery is not null group by customer_state order by average_delivered_time desc limit 1;
#RR	704.73

#6. Which cities experience the longest delivery times?
select customer_city, round(avg(time_of_delivery),2) as average_delivered_time  from (select customer_city, timestampdiff(hour,order_purchase_timestamp, order_delivered_customer_date) as time_of_delivery from (select customer_city, order_delivered_customer_date,order_purchase_timestamp from olist_orders_dataset o inner join  olist_customers_dataset c on o.customer_id = c.customer_id where order_status = "delivered" and order_delivered_customer_date is not null and order_purchase_timestamp is not null ) as t1 order by time_of_delivery asc) as t2 where time_of_delivery is not null group by customer_city order by average_delivered_time desc limit 1;
#novo brasil	3556.00

#7. How many orders arrived before the estimated delivery date?
select count(order_id) as early_delivery_count from olist_orders_dataset where order_status = "delivered" and order_estimated_delivery_date is not null and order_delivered_customer_date is not null and order_estimated_delivery_date > order_delivered_customer_date;
#88652

-- select count(order_id) as order_count from (select order_id , time_of_delivery from (select order_id, timestampdiff(order_estimated_delivery_date, order_delivered_customer_date) as days_delivery_time from olist_orders_dataset where order_status = "delivered" and order_estimated_delivery_date is not null and order_delivered_customer_date is not null) as t1 where days_delivery_time is not null and days_delivery_time>= 0) as t2;
-- #88644 #89936

-- select count(order_id) as order_count from olist_orders_dataset where order_status = "delivered" and order_estimated_delivery_date is not null and order_delivered_customer_date is not null and order_estimated_delivery_date > order_delivered_customer_date;
-- #88652

#8. How many orders arrived after the estimated delivery date?
select count(order_id) as late_delivery_count from olist_orders_dataset where order_status = "delivered" and order_estimated_delivery_date is not null and order_delivered_customer_date is not null and order_estimated_delivery_date < order_delivered_customer_date;
#7826


-- select count(order_id) from (select order_id , days_delivery_time from (select order_id, datediff(order_estimated_delivery_date, order_delivered_customer_date) as days_delivery_time from olist_orders_dataset where order_status = "delivered" and order_estimated_delivery_date is not null and order_delivered_customer_date is not null) as t1 where days_delivery_time is not null and days_delivery_time< 0) as t2;
-- #6534
-- select count(order_id) as order_count from olist_orders_dataset where order_status = "delivered" and order_estimated_delivery_date is not null and order_delivered_customer_date is not null and order_estimated_delivery_date < order_delivered_customer_date;
-- #7826

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