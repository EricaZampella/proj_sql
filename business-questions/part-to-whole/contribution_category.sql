/*Contribution of the category in the overall sales*/
WITH category_sales AS (
SELECT 
    c.CAT AS category, SUM(s.sls_sales) AS sales_category
FROM
    crm_sales_sylver s
        LEFT JOIN (SELECT 
        prd_key, MAX(cat_id) AS cat_id
    FROM
        crm_product_sylver
    GROUP BY prd_key)p ON s.sls_prd_key = p.prd_key
        INNER JOIN
    erp_px_cat c ON p.cat_id = c.ID
GROUP BY c.CAT
)

SELECT 
    category,
    sales_category,
    SUM(sales_category) OVER () AS overall_sales,
    CONCAT( ROUND( (sales_category/SUM(sales_category) OVER ())*100, 2), '%') AS percentage_total
FROM
    category_sales
    ORDER BY sales_category DESC;