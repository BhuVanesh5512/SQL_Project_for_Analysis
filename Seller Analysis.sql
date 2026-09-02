#1. How many sellers are active?
select * from olist_sellers_dataset;
select count(seller_id) from olist_sellers_dataset;

select count(distinct(s.seller_id)) as active_sellers from olist_sellers_dataset s left join olist_order_items_dataset o on s.seller_id = o.seller_id;
#3095

#2. Which state contains the highest number of sellers?
select seller_state , count(seller_id) as active_members from olist_sellers_dataset group by seller_state order by active_members desc limit 1;
#SP	1849

#3. Which city contains the highest number of sellers?
select seller_city , count(seller_id) from olist_sellers_dataset group by seller_city order by count(seller_id) desc limit 1;
#sao paulo	694

#4. Which sellers processed the most orders?
select s.seller_id , count(order_id) as orders_processed from olist_sellers_dataset s inner join olist_order_items_dataset o on s.seller_id = o.seller_id group by seller_id order by orders_processed desc limit 1;
#6560211a19b47992c3666cc44a7e94c0	2033

#5. Which sellers sold the most products?
select s.seller_id , count(ot.product_id) as product_sold from olist_sellers_dataset s inner join olist_order_items_dataset ot on s.seller_id = ot.seller_id  group by seller_id order by product_sold desc limit 1;
#6560211a19b47992c3666cc44a7e94c0	2033

#6. Which sellers generated the highest revenue?
select s.seller_id , count(order_id) as orders_processed , round(sum(price)+sum(freight_value),2) as revenue from olist_sellers_dataset s inner join olist_order_items_dataset o on s.seller_id = o.seller_id group by seller_id order by orders_processed desc limit 1;
#6560211a19b47992c3666cc44a7e94c0	2033	151265.77

#7. What is the average order value for each seller?
select s.seller_id , count(ot.order_id) as orders_processed , round(avg(price)+avg(freight_value),2) as avg_order_value from olist_sellers_dataset s inner join olist_order_items_dataset ot on s.seller_id = ot.seller_id group by seller_id order by orders_processed desc;


#8. Who are the top 10 sellers by revenue?
select s.seller_id , count(order_id) as orders_processed , round(sum(price)+sum(freight_value),2) as revenue from olist_sellers_dataset s inner join olist_order_items_dataset o on s.seller_id = o.seller_id group by seller_id order by revenue desc limit 10;
#4869f7a5dfa277a7dca6462dcf3b52b2	1156	249640.7
#7c67e1448b00f6e969d365cea6b010ab	1364	239536.44
#53243585a1d6dc2643021fd1853d8905	410	235856.68
#4a3ca9315b744ce9f8e9374361493884	1987	235539.96
#fa1c13f2614d7b5c4749cbc52fecda94	586	204084.73
#da8622b14eb17ae2831f4ac5b9dab84a	1551	185192.32
#7e93a43ef30c4f03f38b393420bc753a	340	182754.05
#1025f0e2d44d7041d6cf58b6550e0bfa	1428	172860.69
#7a67c85e85bb2ce8582c35f2203ad736	1171	162648.38
#955fee9216a65b617aa5c0531780ce60	1499	160602.68



