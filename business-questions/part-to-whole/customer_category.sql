/*Customer distribution by product category*/
WITH customer_sales AS (
SELECT 
    c.CAT AS category, COUNT(DISTINCT s.sls_cust_id) AS customer_category
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
    customer_category,
    SUM(customer_category) OVER () AS overall_customer,
    CONCAT( ROUND( (customer_category/SUM(customer_category) OVER ())*100, 2), '%') AS percentage_total
FROM
    customer_sales
    ORDER BY customer_category DESC;