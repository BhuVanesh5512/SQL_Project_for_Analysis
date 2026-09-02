
select * from olist_order_payments_dataset; 

#1. What payment methods are available?
select distinct(payment_type) as payment_methods from olist_order_payments_dataset where payment_type!="not_defined";
#credit_card,boleto,voucher,debit_card

#2.Which payment method is used most frequently?
select payment_type , count(payment_type) as payment_type_frequency from olist_order_payments_dataset where payment_type!="not_defined" group by payment_type order by payment_type_frequency desc limit 1;
#credit_card	76795

#3. How much revenue comes through each payment method?
select payment_type , round(sum(payment_value),2) as revenue from olist_order_payments_dataset where payment_type!="not_defined" group by payment_type order by revenue desc;

#4. What percentage of payments belong to each payment type?
select payment_type , round(sum(payment_value),2) as revenue from olist_order_payments_dataset where payment_type!="not_defined" group by payment_type order by revenue desc;

select * , round(revenue/(select sum(payment_value) from olist_order_payments_dataset),2)*100 as revenue_percentage from (select payment_type , round(sum(payment_value),2) as revenue from olist_order_payments_dataset where payment_type!="not_defined" group by payment_type order by revenue desc) as t group by payment_type, revenue order by revenue_percentage desc;

#5. What is the average payment value by payment type?
select payment_type, round(avg(payment_value),1) as average_payment from olist_order_payments_dataset where payment_type!="not_defined" group by payment_type order by average_payment desc;

#6. What is the maximum number of installments used?
select order_id, max(payment_installments) from olist_order_payments_dataset group by order_id order by max(payment_installments) desc;
select payment_installments, count(payment_installments) as maxium_installments_used from olist_order_payments_dataset group by payment_installments order by maxium_installments_used desc;

select payment_type, max(payment_installments) as maxium_installments from olist_order_payments_dataset group by payment_type order by maxium_installments desc;


#7. What is the average number of installments?
select payment_installments, round(avg(payment_installments),2) as avg_installments_used from olist_order_payments_dataset group by payment_installments order by avg_installments_used desc;
select order_id, round(avg(payment_installments),2) as avg_installments_used from olist_order_payments_dataset group by order_id order by avg_installments_used desc;


select payment_type, round(avg(payment_installments),2) as avg_installments_used from olist_order_payments_dataset group by payment_type order by avg_installments_used desc;

#8. How does average transaction value differ between payment methods?
select payment_type,sum(payment_value) over(partition by payment_type) as rev from olist_order_payments_dataset where payment_type!="not_defined";

select payment_type,rev from (select payment_type,sum(payment_value) over(partition by payment_type) as rev from olist_order_payments_dataset where payment_type!="not_defined" ) as t1 group by payment_type,rev;

select payment_type,rev, lag(rev) over(order by payment_type) as per from (select payment_type,rev from (select payment_type,sum(payment_value) over(partition by payment_type) as rev from olist_order_payments_dataset where payment_type!="not_defined" ) as t1 group by payment_type,rev order by rev) as t2; 

select payment_type,avg(per) as cper, max(per) as mper from (select payment_type,rev , lag(rev) over(order by payment_type) as per from (select payment_type,rev from (select payment_type,sum(payment_value) over(partition by payment_type) as rev from olist_order_payments_dataset where payment_type!="not_defined" ) as t1  order by rev) as t2) as t3;
