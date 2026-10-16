-- Data cleaning and validation
use zepto_analytics;

-- Null Values
SELECT
    SUM(category IS NULL) AS null_category,
    SUM(name IS NULL) AS null_name,
    SUM(mrp IS NULL) AS null_mrp,
    SUM(discount_percent IS NULL) AS null_discount,
    SUM(available_quantity IS NULL) AS null_available_quantity,
    SUM(discounted_selling_price IS NULL)
        AS null_selling_price,
    SUM(weight_in_gms IS NULL) AS null_weight,
    SUM(out_of_stock IS NULL) AS null_stock_status,
    SUM(quantity IS NULL) AS null_quantity
FROM zepto_products;

-- Identify exact duplicate records
SELECT
    category,name,mrp,discount_percent,available_quantity,discounted_selling_price,weight_in_gms,out_of_stock,quantity,
    COUNT(*) AS duplicate_count
FROM zepto_products
GROUP BY category,name,mrp,discount_percent,available_quantity,discounted_selling_price,weight_in_gms,out_of_stock,quantity
HAVING COUNT(*) > 1
ORDER BY duplicate_count DESC;

-- Check price-related anomalies
SELECT *
FROM zepto_products
WHERE mrp < 0
   or discounted_selling_price < 0
   or discount_percent>100
   or discounted_selling_price > mrp;
   
 -- Check invalid or missing product weights.
 SELECT *
FROM zepto_products
WHERE weight_in_gms IS NULL
   OR weight_in_gms <= 0;
   
-- Compare the listed discount with the discount calculated from MRP and selling price.
select name, mrp, discounted_selling_price, discount_percent,
round(100*(mrp-discounted_selling_price)/nullif(mrp,0),2) as calculated_discount_percent
from zepto_products
where mrp >0 
and abs(discount_percent-100*(mrp-discounted_selling_price)/nullif(mrp,0)>2);

