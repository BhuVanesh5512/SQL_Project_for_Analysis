-- use sql_project

#1.How many total orders were placed?
select count(order_id) from olist_orders_dataset;
#99441

#2.How many orders were delivered?
select count(order_id) from olist_orders_dataset where order_status = "delivered";
#96478

#3.How many orders were cancelled?
select count(order_id) from olist_orders_dataset where order_status = "canceled";
#625

#4. What percentage of orders were successfully delivered?
select ( ((select count(order_id) from olist_orders_dataset where order_status = "delivered")/(select count(order_id) from olist_orders_dataset))*100) as delivered_percentage;
#97.0200

# 5. What percentage of orders were cancelled?
select ( ((select count(order_id) from olist_orders_dataset where order_status = "canceled")/(select count(order_id) from olist_orders_dataset))*100) as canceled_percentage;
#0.6300

#6.What are the different order statuses?
select distinct(order_status) from olist_orders_dataset;
#delivered,invoiced,shipped,processing,unavailable,canceled,created,approved #8

#7. How many orders belong to each status?
select order_status,count(order_status) as count from olist_orders_dataset group by order_status;
-- delivered	96478
-- invoiced	314
-- shipped	1107
-- processing	301
-- unavailable	609
-- canceled	625
-- created	5
-- approved	2