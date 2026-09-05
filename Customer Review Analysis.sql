use sql_project;
select * from olist_order_reviews_dataset;

#1. What is the average review score?
select round(avg(review_score),2) as average_review_score from olist_order_reviews_dataset;
#4.01

#2. How many reviews received each rating from 1 to 5?
select review_score , count(review_score) as count_rating from olist_order_reviews_dataset group by review_score order by count_rating desc;

#3. What percentage of reviews are positive?
select (round((select sum(count_rating) as positive from (select review_score , count(review_score) as count_rating from olist_order_reviews_dataset group by review_score order by count_rating desc limit 3) as t1)/(select sum(count_rating) as total_rating from (select review_score , count(review_score) as count_rating from olist_order_reviews_dataset group by review_score order by count_rating desc) as t2),2))*100 as percentage_of_positive;
#86.00

#4. What percentage are negative?
select (round((select sum(count_rating) as positive from (select review_score , count(review_score) as count_rating from olist_order_reviews_dataset group by review_score order by count_rating asc limit 2) as t1)/(select sum(count_rating) as total_rating from (select review_score , count(review_score) as count_rating from olist_order_reviews_dataset group by review_score order by count_rating asc) as t2),2))*100 as percentage_of_negative;
#14.00

#5. Which product categories have the highest average ratings?
select product_category_name,count(p.product_id) as no_of_products,round(avg(review_score),2) as average_rating ,count(review_score) as given_by from olist_order_reviews_dataset r inner join olist_order_items_dataset ot on r.order_id = ot.order_id inner join  olist_products_dataset p on ot.product_id = p.product_id group by product_category_name having no_of_products>20 order by  average_rating desc limit 1; 
#informatica_acessorios	21	4.43	21

#6. Which product categories have the lowest ratings?
select product_category_name,count(p.product_id) as no_of_products,round(avg(review_score),2) as average_rating ,count(review_score) as given_by from olist_order_reviews_dataset r inner join olist_order_items_dataset ot on r.order_id = ot.order_id inner join  olist_products_dataset p on ot.product_id = p.product_id group by product_category_name having no_of_products>20 order by  average_rating asc; 
#utilidades_domesticas	31	3.55	31

#7. Which sellers have the highest average ratings?
select p.seller_id,count(ot.product_id) as no_of_products,round(avg(review_score),2) as average_rating ,count(review_score) as given_by from olist_order_reviews_dataset r inner join olist_order_items_dataset ot on r.order_id = ot.order_id inner join  olist_sellers_dataset p on ot.seller_id = p.seller_id group by p.seller_id having no_of_products>5 order by average_rating desc limit 1; 
#d71d863e5ef30d94e440c11be17dcd8f	6	5.00	6

#8.  Which sellers have the lowest average ratings?
select p.seller_id,count(ot.product_id) as no_of_products,round(avg(review_score),2) as average_rating ,count(review_score) as given_by from olist_order_reviews_dataset r inner join olist_order_items_dataset ot on r.order_id = ot.order_id inner join  olist_sellers_dataset p on ot.seller_id = p.seller_id group by p.seller_id having no_of_products>5 order by average_rating asc limit 1; 
#955fee9216a65b617aa5c0531780ce60	6	1.00	6