-- View Order Table
select * from order_details;

-- What is the date range of this table?
select * from order_details
order by order_date;

-- How many orders were made within this date range?
select count(distinct order_id) from order_details;

-- How many items were ordered within this date range?
select count(*) from order_details;

-- How many orders had more than 12 items?
select COUNT(*) from
(select order_id, count(item_id) as num_items
 from order_details
group by order_id 
having num_items > 12) as num_orders;

-- Combine the menu_items and order_details tables into a single table
select * from menu_items;
select * from order_details;

Select *
from order_details od Left join menu_items mi
	on od.item_id = mi.menu_item_id;

-- What were the least and most ordered items? What categories were they in
select item_name, count(order_details_id) as num
from order_details od Left join menu_items mi
	on od.item_id = mi.menu_item_id
    group by item_name
    order by num desc;
-- What were the top 5 orders that spent the most money?
select order_id, sum(price) as total_spent
from order_details od Left join menu_items mi
	on od.item_id = mi.menu_item_id
group by order_id 
order by total_spent desc
Limit 5;

-- View the details of the highest spend order. What insights can you gather from them
select category, count(item_id) as num_items
from order_details od Left join menu_items mi
	on od.item_id = mi.menu_item_id
    where order_id = 440
    group by category;

-- View the details of the top 5 highest spend orders. what insights can you gather from them
select order_id, category, count(item_id) as num_items
from order_details od Left join menu_items mi
	on od.item_id = mi.menu_item_id
    where order_id in (440,2075, 1957, 330, 2675)
    group by order_id, category;
