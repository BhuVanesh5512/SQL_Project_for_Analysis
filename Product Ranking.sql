#Rank products based on sales. Use ROW_NUMBER(), RANK(), and DENSE_RANK(). Find the top 5 products by revenue in each product category.

select * from olist_productS_dataset;

select count(distinct(product_id)) from olist_order_items_dataset;

select *  ,  row_number() OVER(PARTITION BY product_category_name  order BY revenue DESC) as row_num from (select p.product_category_name, s.product_id,count(s.product_id) as sold,round(SUM(PRICE)+SUM(freight_value),2) as revenue from  olist_order_items_dataset s inner join olist_products_dataset p where s.product_id = p.product_id group by product_category_name, product_id) as t;
select * from (select *  ,  row_number() OVER(PARTITION BY product_category_name  order BY revenue DESC) as row_num from (select p.product_category_name, s.product_id,count(s.product_id) as sold,round(SUM(PRICE)+SUM(freight_value),2) as revenue from  olist_order_items_dataset s inner join olist_products_dataset p where s.product_id = p.product_id group by product_category_name, product_id) as t) as r where row_num<=5 ORDER BY product_category_name, revenue DESC;


select *  ,  RANK() OVER(PARTITION BY product_category_name  order BY revenue DESC) as rank_num from (select p.product_category_name, s.product_id,count(s.product_id) as sold,round(SUM(PRICE)+SUM(freight_value),2) as revenue from  olist_order_items_dataset s inner join olist_products_dataset p where s.product_id = p.product_id group by product_category_name, product_id) as t;
select * from (select *  ,  RANK() OVER(PARTITION BY product_category_name  order BY revenue DESC) as rank_num from (select p.product_category_name, s.product_id,count(s.product_id) as sold,round(SUM(PRICE)+SUM(freight_value),2) as revenue from  olist_order_items_dataset s inner join olist_products_dataset p where s.product_id = p.product_id group by product_category_name, product_id) as t) as r where rank_num<=5 ORDER BY product_category_name, revenue DESC;


select *  ,  DENSE_RANK() OVER(PARTITION BY product_category_name  order BY revenue DESC) as dense_rank_num from (select p.product_category_name, s.product_id,count(s.product_id) as sold,round(SUM(PRICE)+SUM(freight_value),2) as revenue from  olist_order_items_dataset s inner join olist_products_dataset p where s.product_id = p.product_id group by product_category_name, product_id) as t;


select * from (SELECT product_category_name,product_id,sold,revenue,DENSE_RANK() OVER (PARTITION BY product_category_name ORDER BY revenue DESC) AS dense_rank_num FROM (
SELECT p.product_category_name,s.product_id,COUNT(s.product_id) AS sold,ROUND(SUM(s.price)+SUM(freight_value), 2) AS revenue FROM olist_order_items_dataset s INNER JOIN olist_products_dataset p ON s.product_id = p.product_id GROUP BY p.product_category_name, s.product_id ) AS t ) as r
WHERE dense_rank_num<= 5
ORDER BY product_category_name, revenue DESC;
