/*Sales for year*/
/*Total number of customers over year*/
/*Total units sold per year*/
SELECT 
    YEAR(s.sls_order_dt) AS year_,
    SUM(sls_sales) AS sales_year,
    COUNT(DISTINCT c.cst_id) AS customer_year,
    SUM(sls_quantity) AS unit_year
FROM
    crm_sales_sylver s
        LEFT JOIN
    crm_customer_sylver c ON s.sls_cust_id = c.cst_id
WHERE
    YEAR(sls_order_dt) IS NOT NULL
GROUP BY YEAR(s.sls_order_dt)
ORDER BY year_ ASC;