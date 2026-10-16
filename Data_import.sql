create database zepto_analytics;
use zepto_analytics;

DROP TABLE IF EXISTS zepto_products;
create table zepto_products(
category varchar(100),
name varchar(255),
mrp int,
discount_percent int,
available_quantity int,
discounted_selling_price int,
weight_in_gms int,
out_of_stock varchar(100),
quantity int
);

-- Verify that out_of_stock is imported correctly
-- Confirm the number of imported rows.
select count(*) from zepto_products;
-- Preview the imported data.
select * from zepto_products
limit 10;
-- Inspect category distribution.
select category, COUNT(*) AS product_records 
from zepto_products
group by category
order by COUNT(*) desc;