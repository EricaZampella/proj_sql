/*Moving average of price*/
SELECT order_date,
average_price,
ROUND( AVG(average_price) OVER (ORDER BY order_date), 3) AS moving_average_price
FROM 
(
SELECT 
    DATE_FORMAT(sls_order_dt, '%Y-%m') AS order_date,
    AVG(sls_price) AS average_price
FROM
    crm_sales_sylver
WHERE
    DATE_FORMAT(sls_order_dt, '%Y-%m') IS NOT NULL
GROUP BY order_date
)t;
/*Moving average of price per year*/
SELECT
    YEAR(order_month) AS year_,
    MONTH(order_month) AS month_,
    average_price,
    ROUND(AVG(average_price) OVER (PARTITION BY YEAR(order_month) ORDER BY order_month ), 3) AS moving_average_price
FROM (
    SELECT
        DATE_FORMAT(sls_order_dt, '%Y-%m-01') AS order_month,
        ROUND( AVG(sls_sales), 3) AS average_price
    FROM crm_sales_sylver
    where DATE_FORMAT(sls_order_dt, '%Y-%m-01') IS NOT NULL
    GROUP BY DATE_FORMAT(sls_order_dt, '%Y-%m-01')
) t;