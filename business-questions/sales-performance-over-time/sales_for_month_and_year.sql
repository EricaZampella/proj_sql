/*Sales for month and year*/
/*Total number of customers over month and year*/
/*Total units sold per month and year*/
SELECT 
    DATE_FORMAT(s.sls_order_dt, '%Y-%m') AS year_month_,
    COUNT(DISTINCT c.cst_id) AS customer_month,
    SUM(sls_sales) AS sales_month,
    SUM(sls_quantity) AS unit_month
FROM
    crm_sales_sylver s
        LEFT JOIN
    crm_customer_sylver c ON s.sls_cust_id = c.cst_id
WHERE
    s.sls_order_dt IS NOT NULL
GROUP BY DATE_FORMAT(s.sls_order_dt, '%Y-%m')
ORDER BY year_month_;