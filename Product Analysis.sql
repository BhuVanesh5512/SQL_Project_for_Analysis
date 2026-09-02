select * from olist_products_dataset;

#1 How many unique products were sold
select product_category_name,count(s.product_id) as sold from olist_products_dataset p inner join olist_order_items_dataset s where p.product_id = s.product_id group by product_category_name order by sold desc;

#2 How many product categories exist?
select count(distinct(product_category_name)) as count_product_categoy from olist_products_dataset;

#3 Which categories have the highest number of products?
select product_category_name,count(product_id) as sold from olist_products_dataset  group by product_category_name order by sold desc limit 1;
#cama_mesa_banho	3029

#4 Which products sold the most units?
select p.product_id,count(s.product_id) as sold from olist_products_dataset p inner join olist_order_items_dataset s where p.product_id = s.product_id group by product_id order by sold desc limit 1;
#aca2eb7d00ea1a7b8ebd4e68314663af	527

#5 Which product categories sold the most units?
select product_category_name,count(s.product_id) as sold from olist_products_dataset p inner join olist_order_items_dataset s where p.product_id = s.product_id group by product_category_name order by sold desc limit 1;
#cama_mesa_banho	11115

#6 Which categories generated the highest revenue?
select product_category_name,count(s.product_id) as sold,round(SUM(PRICE),2) as revenue from olist_products_dataset p inner join olist_order_items_dataset s where p.product_id = s.product_id group by product_category_name order by revenue desc limit 1;
#beleza_saude	9670	1258681.34

#7 Which categories generated the lowest revenue?
select product_category_name,count(s.product_id) as sold,round(SUM(PRICE),2) as revenue from olist_products_dataset p inner join olist_order_items_dataset s where p.product_id = s.product_id group by product_category_name order by revenue asc limit 1;
#seguros_e_servicos	2	283.29

#8 What is the average product price by category?
select product_category_name, round(avg(price),2) as average_product_price from olist_products_dataset p inner join olist_order_items_dataset s on p.product_id = s.product_id group by product_category_name order by average_product_price desc;

#9  What are the top 10 product categories by revenue?
select product_category_name,count(s.product_id) as sold,round(SUM(PRICE),2) as revenue from olist_products_dataset p inner join olist_order_items_dataset s where p.product_id = s.product_id group by product_category_name order by revenue desc limit 10;

#10 What percentage of total revenue comes from the top 10 categories?
select round(sum(revenue),2) as top_10_revenue from (select product_category_name,count(s.product_id) as sold,round(SUM(PRICE),2) as revenue from olist_products_dataset p inner join olist_order_items_dataset s where p.product_id = s.product_id group by product_category_name order by revenue desc limit 10) as t;
#8475957.56 top10_revenue_total
select round(sum(revenue),2) as total_revenue from (select product_category_name,count(s.product_id) as sold,round(SUM(PRICE),2) as revenue from olist_products_dataset p inner join olist_order_items_dataset s where p.product_id = s.product_id group by product_category_name order by revenue desc) as t;
#13410174.42 total_revenue
select round((select round(sum(revenue),2) as top_10_revenue from (select product_category_name,count(s.product_id) as sold,round(SUM(PRICE),2) as revenue from olist_products_dataset p inner join olist_order_items_dataset s where p.product_id = s.product_id group by product_category_name order by revenue desc limit 10) as t)/(select round(sum(revenue),2) as total_revenue from (select product_category_name,count(s.product_id) as sold,round(SUM(PRICE),2) as revenue from olist_products_dataset p inner join olist_order_items_dataset s where p.product_id = s.product_id group by product_category_name order by revenue desc) as r),2) *100 as top_10_percentage_over_overall;
#top_10_percentage_over_overall 63
