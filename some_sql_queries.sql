--what is total revenue genrated by male vs female
select gender,sum(purchase_amount) as revenue from customer group by gender

--which customer used discount but still spent more than average purchase amount 
select customer_id,purchase_amount from customer where discount_applied = 'Yes' 
and purchase_amount >=
(select avg(purchase_amount) from customer)

--which is most top five product with the highet average review rating
select item_purchased, round(avg(review_rating::numeric),2) as "average product rating"
from customer
group by item_purchased
order by avg(review_rating) desc
limit 5

--comapre the average purcahsed amount between standared and express shipping
select shipping_type,
round(avg(purchase_amount),2)
from customer
where shipping_type in ('Standard','Express')
group by shipping_type

--do subscribed customer spend more? comapre average apend and tottal revenue between
--subscriber and non susbscriber
select subscription_status,
count(customer_id) as total_customers,
round(avg(purchase_amount),2) as avg_spend,
round(sum(purchase_amount),2) as total_revenue
from customer
group by subscription_status
order by total_revenue,avg_spend desc;

--which 5 product have the highest percentage of purchases with discount applied
select item_purchased,
round(100*sum(case when discount_applied ='Yes' then 1 else 0 end)/count(*),2) as discount_rate
from customer
group by item_purchased
order by discount_rate desc
limit 5

--

