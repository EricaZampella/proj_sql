/*Segment products based on cost range*/
WITH product_segment AS (
SELECT DISTINCT
    prd_key AS product_key,
    MAX(prd_nm) AS product_nm,
    MAX(prd_cost) AS cost,
    CASE
        WHEN MAX(prd_cost) < 100 THEN 'Less then 100'
        WHEN MAX(prd_cost) BETWEEN 100 AND 500 THEN '100 - 500'
        WHEN MAX(prd_cost) BETWEEN 500 AND 1000 THEN '500 - 1000'
        ELSE 'More then 1000'
    END AS cost_range
FROM
    crm_product_sylver
GROUP BY prd_key
)
SELECT 
    cost_range, COUNT(product_key) AS howmany_products
FROM
    product_segment
GROUP BY cost_range
ORDER BY howmany_products DESC;