use sql_project;

select * from olist_customers_dataset;

#1.How many unique customers exist?
select count(distinct(customer_unique_id)) from olist_customers_dataset;
#96096

#2.Which state has the highest number of customers?
select customer_state, count(customer_state) as customer_count from olist_customers_dataset group by customer_state order by customer_count desc limit 1;
#SP - 41746

#3. Which city has the highest number of customers?
select customer_city, count(customer_city) as customer_count from olist_customers_dataset group by customer_city order by customer_count desc limit 1;
#sao paulo - 15540

#4. What are the top 10 cities by customer count?
select customer_city, count(customer_city) as customer_count from olist_customers_dataset group by customer_city order by customer_count desc limit 10;
-- sao paulo	15540
-- rio de janeiro	6882
-- belo horizonte	2773
-- brasilia	2131
-- curitiba	1521
-- campinas	1444
-- porto alegre	1379
-- salvador	1245
-- guarulhos	1189
-- sao bernardo do campo	938

#5. How many customers placed more than one order?
select c.customer_id, count(order_id) as order_count  from olist_customers_dataset c inner join olist_orders_dataset o where c.customer_id = o.customer_id group by customer_id order by order_count desc;

select count(customer_id) from (select customer_id,count(order_id) from olist_orders_dataset  group by customer_id having count(order_id)>1) as t;
#0

#6.  What percentage of customers are repeat customers?
select ((count(customer_id)/(select count(customer_id) as total from olist_customers_dataset))*100) as percentage_of_repeat_cutomers from (select customer_id,count(order_id) from olist_orders_dataset  group by customer_id having count(order_id)>1) as t;
#0

#7. Which customers placed the most orders?
select customer_id,count(order_id) as order_placed from olist_orders_dataset  group by customer_id order by count(order_id) desc;

#8.  Which customers generated the highest revenue?
select c.customer_id ,round(sum(price)+sum(freight_value),2) as total_spent from olist_customers_dataset c  inner join olist_orders_dataset o on c.customer_id = o.customer_id  inner join olist_order_items_dataset ot where  o.order_id = ot.order_id  group by customer_id order by total_spent desc limit 1;
#1617b1357756262bfa56ab541c47bc16	13664.08