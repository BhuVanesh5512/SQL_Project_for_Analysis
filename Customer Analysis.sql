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
