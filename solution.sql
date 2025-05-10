create database zomato;

use zomato;

-- 1)  find The Total Numbers of orders 

select count(*) from order_details;

-- 2)  sample Function in sql 
-- replicated sample function from pandas

SELECT * FROM users ORDER BY rand() LIMIT 5;

-- 3) To find the NULL values 

select * from orders
where restaurant_rating is null;

-- 4) To replace NULL values with 0

update orders set restaurant_rating = 0
where restaurant_rating is null;


select * from orders;


-- 5)   find The Number of OderS For The Specific Users 

select u.name,count(*) from orders as o
join users as u on o.user_id=u.user_id
group by u.user_id,u.name;


-- Q6) Find The Number of Mneu items For The specific restaurants 

select r_name,count(*) from menu as m
join restaurants as r on m.r_id = r.r_id
group by r.r_id,r_name;

-- Q7) Find The Number of votes , average Restaurants Ratings From the datasets 

select r_name,count(*) as no_of_votes,round(avg(restaurant_rating),2) as avg_rating from orders as o
join restaurants as r on o.r_id=r.r_id
where restaurant_rating != 0
group by r.r_id,r_name;

-- Q8) Find The frequency of food from the Menu 

select f_name,count(*)as freq from menu as m
join food as f on m.f_id = f.f_id
group by f.f_id,f_name
ORDER BY COUNT(*) DESC ;

-- Q9) -> Month By Month Revenue of the July 

select r_name,sum(amount) as revenue from orders as o 
join restaurants as r on o.r_id = r.r_id
where monthname(date(date))='July'
group by o.r_id,r_name
order by revenue desc;


-- Q10)  month by month revenue for a particular restautant = kfc

select r_name,sum(amount),monthname(date(date)) as revenue from orders as o 
join restaurants as r on o.r_id = r.r_id
where r_name='kfc'
group by monthname(date(date))
order by monthname(date(date)) desc;



-- Q10  find The restaurants Of reveniue Generated of Specific reveneue greater THAN The threashold 

select r_name,sum(amount) as revenue from orders as o
join restaurants as r on o.r_id = r.r_id
group by r.r_id,r_name
having revenue>1500;

-- Q11) Findf The User who Never Ordered 

select user_id,name from users
where user_id not in (select user_id from orders);


-- Q12) Find The User ordered Details of Specific Person of Certain Range of The dates 

SELECT t1.order_id,f_name,date FROM orders t1
JOIN order_details t2
ON t1.order_id = t2.order_id
JOIN food t3
ON t2.f_id = t3.f_id
where user_id=2 and date between '2022-05-01' and'2022-07-03';

-- Q13) count The No of Food Items ordered By the specific Users 

select f_id,count(od.f_id) from users as u
join orders as o on u.user_id = o.user_id
join order_details as od on o.order_id = od.order_id
where u.user_id=4
group by f_id;
 

-- Q14) Find The average Price of the restaurants Food items and 



select r_name,sum(price)/count(*) as avg_price from menu m
join restaurants as r on m.r_id = r.r_id
join food as f on m.f_id=f.f_id
group by r.r_id,r_name
order by avg_price asc;

-- find The cheapest average Food items 

select f_name,sum(price)/count(*) from food as f
join menu as m on m.f_id=f.f_id
join restaurants as r on m.r_id = r.r_id
group by f.f_id,f_name
order by sum(price)/count(*) asc;

-- Q15) Fnd The partner name and The salary

select partner_name,count(*)*100 + avg(delivery_rating)*1000 as salary from orders as o
join delivery_partner as d on o.partner_id = d.partner_id
group by d.partner_id,partner_name
order by salary desc;
 
-- Q17) Is there any Correlation Between the delivery time and the delivery ratings 


select ((count(*)*sum(delivery_time*delivery_rating))-(sum(delivery_time)*sum(delivery_rating)))/
		sqrt(((count(*)*sum(delivery_time*delivery_time))-(sum(delivery_time)*sum(delivery_time)))*
        ((count(*)*sum(delivery_rating*delivery_rating))-(sum(delivery_rating)*sum(delivery_rating)))) as corr
from orders;

-- There is strong negative correlation between delivery_time and delivery_rating


 -- Q19) Find The Minimum and The maximum items of the veg items From thje restaurants 
 
select r_name,count(type) as veg_items from food as f
join menu as m on f.f_id=m.f_id
join restaurants as r on r.r_id = m.r_id 
where type like 'Veg'
group by r.r_id,r_name;


-- Find The restaurants where Minimum and The maximum items are veg items 

select r_name from food as f
join menu as m on f.f_id=m.f_id
join restaurants as r on r.r_id = m.r_id 
group by r.r_id,r_name
having max(type) like 'Veg' and min(type) like 'Veg';

-- Q20) – summarize The users min , max , average , count OF ordered DetaiLS From the dataset


select name,min(amount),max(amount),avg(amount), count(order_id) from orders as o
join users as u on o.user_id=u.user_id
group by u.user_id,name;









 
 
 
 
 
 
 
 
 
 
 