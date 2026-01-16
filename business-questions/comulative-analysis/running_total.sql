/*Total sales per month*/
/*Running total of sales overtime*/
SELECT order_date,
total_sales,
SUM(total_sales) OVER (ORDER BY order_date) AS running_total_sales
FROM 
(
SELECT 
    DATE_FORMAT(sls_order_dt, '%Y-%m') AS order_date,
    SUM(sls_sales) AS total_sales
FROM
    crm_sales_sylver
WHERE
    DATE_FORMAT(sls_order_dt, '%Y-%m') IS NOT NULL
GROUP BY order_date
)t;
/*Running total of sales overtime per year*/
SELECT
    YEAR(order_month) AS year_,
    MONTH(order_month) AS month_,
    total_sales,
    SUM(total_sales) OVER (PARTITION BY YEAR(order_month) ORDER BY order_month ) AS running_total_sales
FROM (
    SELECT
        DATE_FORMAT(sls_order_dt, '%Y-%m-01') AS order_month,
        SUM(sls_sales) AS total_sales
    FROM crm_sales_sylver
    where DATE_FORMAT(sls_order_dt, '%Y-%m-01') IS NOT NULL
    GROUP BY DATE_FORMAT(sls_order_dt, '%Y-%m-01')
) t;