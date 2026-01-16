/*Sales for month regardless of the year*/
/*Total number of customers over month regardless of the year*/
/*Total units sold per month regardless of the year*/
SELECT 
    MONTH(s.sls_order_dt) AS month_num,
    MONTHNAME(s.sls_order_dt) AS month_,
    COUNT(DISTINCT c.cst_id) AS customer_month,
    SUM(sls_sales) AS sales_month,
    SUM(sls_quantity) AS unit_month
FROM
    crm_sales_sylver s
        LEFT JOIN
    crm_customer_sylver c ON s.sls_cust_id = c.cst_id
WHERE
    s.sls_order_dt IS NOT NULL
GROUP BY MONTH(s.sls_order_dt) , MONTHNAME(s.sls_order_dt)
ORDER BY month_num;