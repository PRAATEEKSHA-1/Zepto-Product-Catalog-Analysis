-- Business analysis queries
USE zepto_analytics;
select * from zepto_products;

-- 1. overall catalog health
SELECT
    COUNT(*) AS catalog_skus,
    COUNT(DISTINCT product_name) AS distinct_product_names,
    SUM(out_of_stock = TRUE) AS out_of_stock_skus,
    ROUND(100 * AVG(out_of_stock = TRUE), 2) AS stockout_rate_pct,
    ROUND(AVG(discount_percent), 2) AS avg_listed_discount_pct,
    ROUND(AVG(selling_price), 2) AS avg_selling_price,
    SUM(data_quality_status <> 'OK') AS flagged_rows
FROM vw_zepto_products;


-- 2. Which categories have the highest stockout rates
SELECT
    category, COUNT(*) AS sku_count, SUM(out_of_stock = TRUE) AS out_of_stock_skus, ROUND(100 * AVG(out_of_stock = TRUE), 2) AS stockout_rate_pct,
    ROUND(AVG(discount_percent), 2) AS avg_discount_pct
FROM vw_zepto_products
GROUP BY category
HAVING COUNT(*) >= 20
ORDER BY stockout_rate_pct DESC, sku_count DESC;


-- 3. Which categories make up the largest share of the catalog
SELECT
    category,COUNT(*) AS sku_count,
    ROUND(
        100 * COUNT(*) /(SELECT COUNT(*) FROM vw_zepto_products),2) AS catalog_share_pct
FROM vw_zepto_products
GROUP BY category
ORDER BY sku_count DESC;


-- 4. Which available products have discounts of 25% or more?
SELECT
    category, product_name, mrp, selling_price, discount_percent, savings_amount, available_quantity, weight_in_gms
FROM vw_zepto_products
WHERE out_of_stock = FALSE
  AND discount_percent >= 25
ORDER BY discount_percent DESC, savings_amount DESC
LIMIT 10;


-- 5. Which in-stock products have the largest difference between MRP and selling price?
SELECT category, product_name, mrp, selling_price, discount_percent, savings_amount
FROM vw_zepto_products
WHERE out_of_stock = FALSE
  AND mrp > 0
ORDER BY savings_amount DESC
LIMIT 25;


-- 6. Find product names listed under multiple categories
SELECT name, COUNT(DISTINCT category) AS category_count,
    GROUP_CONCAT(
        DISTINCT category
        ORDER BY category
        SEPARATOR ' | '
    ) AS categories
FROM zepto_products
GROUP BY name
HAVING COUNT(DISTINCT category) > 1
ORDER BY category_count DESC, name;


-- 7. Unavailable products with higher listed discounts first
SELECT category, product_name, mrp, selling_price, discount_percent, available_quantity, weight_in_gms
FROM vw_zepto_products
WHERE out_of_stock = TRUE
ORDER BY discount_percent DESC, mrp DESC
LIMIT 10;


-- 8. Price distribution by category
SELECT
    category, COUNT(*) AS sku_count,
    ROUND(MIN(selling_price), 2) AS min_price,
    ROUND(AVG(selling_price), 2) AS avg_price,
    ROUND(MAX(selling_price), 2) AS max_price,
    ROUND(AVG(weight_in_gms), 1) AS avg_weight_g
FROM vw_zepto_products
WHERE data_quality_status = 'OK'
GROUP BY category
ORDER BY avg_price DESC;


