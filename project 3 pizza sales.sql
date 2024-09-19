select*from pizza_sales

select sum(total_price) as 'total revenue' from pizza_sales

select sum(total_price)/count(distinct order_id) as 'average order value' from pizza_sales

select SUM(quantity) as 'total pizza sold' from pizza_sales

select count (distinct order_id) as 'total orders' from pizza_sales

exec sp_rename 'pizza_sales.conerted_order_date','converted_order_date','column'

select DATENAME(weekday,converted_order_date) as order_day,count(distinct order_id) as total_order
from pizza_sales
group by DATENAME(DW,converted_order_date)
order by  count(distinct order_id) 

select DATENAME(month,converted_order_date) as month_name,count(distinct order_id) as total_orders
from pizza_sales
group by DATENAME(month,converted_order_date)
order by count(distinct order_id) desc

select pizza_category ,sum(total_price) * 100/(select SUM(total_price) from pizza_sales) as PCT
from pizza_sales
group by pizza_category 
order by 2 desc

select pizza_size ,datepart (quarter,converted_order_date) ,sum(total_price) * 100/(select SUM(total_price) from pizza_sales) as PCT
from pizza_sales
group by pizza_size,converted_order_date
order by 2,3 desc

select top 5 pizza_name,sum(total_price) as revenue
from pizza_sales
group by pizza_name
order by sum(total_price)

select top 5 with ties pizza_name,sum(quantity) as total_quantity
from pizza_sales
group by pizza_name
order by sum(quantity)

select order_date,cast(order_date as date) 
from pizza_sales

alter table pizza_sales
add conerted_order_date date

update pizza_sales
set conerted_order_date=cast(order_date as date)

alter table pizza_sales 
drop column order_date 

select order_time ,cast(order_time as time)
from pizza_sales

alter table pizza_sales
add converted_order_time time

update pizza_sales
set converted_order_time=cast(order_time as time)

alter table pizza_sales
drop column order_time

select 
PARSENAME(REPLACE(order_timee,',','.'),2)

from pizza_sales
 
 alter table pizza_sales
 add order_timeee time

 update pizza_sales
 set order_timeee=PARSENAME(REPLACE(order_timee,',','.'),2)

 alter table pizza_sales
 drop column order_timeee

 select pizza_size from pizza_sales
 group by pizza_size

SELECT 
    CASE 
        WHEN pizza_size = 'L' THEN 'large'
        WHEN pizza_size = 'M' THEN 'medium'
        WHEN pizza_size = 'S' THEN 'regular'
        WHEN pizza_size = 'X' THEN 'X-large'
        WHEN pizza_size = 'XXL' THEN 'XX-large'
        ELSE pizza_size
    END  
	from pizza_sales

update pizza_sales
set pizza_size=CASE 
        WHEN pizza_size = 'L' THEN 'large'
        WHEN pizza_size = 'M' THEN 'medium'
        WHEN pizza_size = 'S' THEN 'regular'
        WHEN pizza_size = 'X' THEN 'X-large'
        WHEN pizza_size = 'XXL' THEN 'XX-large'
        ELSE pizza_size
    END  