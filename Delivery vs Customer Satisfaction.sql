use sql_project;
select * from olist_orders_dataset;
select * from olist_order_reviews_dataset;

#Compare order counts and average review score for On Time and Late deliveries
select arrived, avg(review_score) as avg_score from olist_orders_dataset o inner join olist_order_reviews_dataset r on o.order_id = r.order_id where order_status = "delivered" group by arrived order by avg_score desc;