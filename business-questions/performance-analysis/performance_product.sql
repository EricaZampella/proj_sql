/*Performance of products by comparing sales, average sales and previous year*/
WITH product_sales AS (
SELECT 
    YEAR(s.sls_order_dt) AS order_year,
    p.prd_nm AS product_name,
    SUM(s.sls_sales) AS products_sales
FROM
    crm_sales_sylver s
        LEFT JOIN
    crm_product_sylver p ON s.sls_prd_key = p.prd_key
WHERE
    YEAR(s.sls_order_dt) IS NOT NULL
GROUP BY YEAR(s.sls_order_dt) , p.prd_nm
)
SELECT order_year,
product_name,
products_sales,
ROUND(AVG(products_sales) OVER (PARTITION BY product_name), 2) AS average_sales,
products_sales - ROUND(AVG(products_sales) OVER (PARTITION BY product_name), 2) AS diff_avg,
CASE
 WHEN products_sales - ROUND(AVG(products_sales) OVER (PARTITION BY product_name), 2) > 0 THEN 'Above Avg'
 WHEN products_sales - ROUND(AVG(products_sales) OVER (PARTITION BY product_name), 2) < 0 THEN 'Below Avg'
ELSE 'Avg'
END AS avg_change,
LAG(products_sales) OVER (PARTITION BY product_name ORDER BY order_year) AS previous_sales,
products_sales - LAG(products_sales) OVER (PARTITION BY product_name ORDER BY order_year) AS diff_previous,
CASE
 WHEN products_sales - LAG(products_sales) OVER (PARTITION BY product_name ORDER BY order_year) > 0 THEN 'Increase'
 WHEN products_sales - LAG(products_sales) OVER (PARTITION BY product_name ORDER BY order_year) < 0 THEN 'Decrease'
ELSE 'No Change'
END AS previous_change
FROM product_sales
ORDER BY product_name, order_year;