select * from olist_order_payments_dataset;

alter table olist_order_payments_dataset add column total_spending varchar(255);
#Segment customers based on spending into Low Value, Medium Value, High Value, and VIP customers. Students may define appropriate thresholds.
update olist_order_payments_dataset set total_spending = 
CASE
WHEN total_spending >= 2000 THEN 'VIP'
WHEN total_spending >= 1000 THEN 'High Value'
WHEN total_spending >= 500 THEN 'Medium Value'
ELSE 'Low Value'
END;
