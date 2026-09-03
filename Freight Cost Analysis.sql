#1. What is the total freight value?
select round(sum(freight_value),2) as total_freight from olist_order_items_dataset;

#2. What is the average freight value per order?
select order_id,count(order_id) as order_placed_count, round(avg(freight_value),2) as avg_freight from olist_order_items_dataset group by order_id order by avg_freight,order_placed_count desc;

#3. Which states have the highest freight costs?
select seller_state, round(avg(freight_value),2) as avg_freight from olist_order_items_dataset ot inner join olist_sellers_dataset s on ot.seller_id =s.seller_id group by seller_state order by avg_freight desc;

#4. Which product categories have the highest average freight costs?
select product_category_name, round(avg(freight_value),2) as avg_freight from olist_order_items_dataset ot inner join olist_products_dataset s on ot.product_id =s.product_id group by product_category_name order by avg_freight desc;

#5. Which products have unusually high freight charges?
select product_id , count(product_id) as product_placed_count,round(avg(freight_value),2) as avg_freight from olist_order_items_dataset group by product_id order by  product_placed_count desc;


##6. Calculate freight percentage as Freight Value / Product Price × 100 and identify products where shipping cost is unusually high compared with product value.

