-- Create a cleaned analytical view.


CREATE OR REPLACE VIEW vw_zepto_products AS

WITH dedup AS (
    SELECT
        r.*,
        ROW_NUMBER() OVER (
            PARTITION BY
                category,name,mrp,discount_percent,available_quantity,discounted_selling_price,weight_in_gms,out_of_stock,quantity
            ORDER BY name
        ) AS duplicate_rank
    FROM zepto_products r
)

SELECT
    category, TRIM(name) AS product_name, mrp AS mrp_raw, discounted_selling_price AS selling_price_raw,
	ROUND(mrp / 100.0, 2) AS mrp,
    ROUND(discounted_selling_price / 100.0, 2) AS selling_price,
    discount_percent, available_quantity, weight_in_gms, out_of_stock, quantity,
    ROUND((mrp - discounted_selling_price) / 100.0,2) AS savings_amount,
    CASE
        WHEN mrp > 0 THEN
            ROUND(100.0 * (mrp - discounted_selling_price)/ mrp,2)
        ELSE NULL
    END AS calculated_discount_percent,
    CASE
        WHEN mrp = 0 THEN 'INVALID_OR_MISSING_MRP'
        WHEN discounted_selling_price > mrp
            THEN 'SELLING_PRICE_ABOVE_MRP'
        WHEN available_quantity < 0 THEN 'NEGATIVE_STOCK'
        WHEN weight_in_gms <= 0
            THEN 'MISSING_OR_INVALID_WEIGHT'
        ELSE 'OK'
    END AS data_quality_status
FROM dedup
WHERE duplicate_rank = 1;

#check the view
SELECT *
FROM vw_zepto_products
LIMIT 10;


-- Compare raw and cleaned row counts.

SELECT
    (SELECT COUNT(*)
     FROM zepto_products) AS raw_rows,

    (SELECT COUNT(*)
     FROM vw_zepto_products) AS cleaned_rows;


-- Summarize the cleaned data-quality statuses.

SELECT
    data_quality_status,
    COUNT(*) AS records
FROM vw_zepto_products
GROUP BY data_quality_status
ORDER BY records DESC;