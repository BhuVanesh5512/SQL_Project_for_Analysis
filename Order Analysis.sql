#How many total orders were placed?
select count(order_id) from olist_orders_dataset;

#How many orders were delivered?
select count(order_id) from olist_orders_dataset where order_status = "delivered";
#96478

#How many orders were cancelled?
select count(order_id) from olist_orders_dataset where order_status = "invoiced";
#314

