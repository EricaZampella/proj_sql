/*Performance of customers per year*/
WITH customer_order AS (
SELECT 
    YEAR(s.sls_order_dt) AS order_year,
    c.cst_fullname AS customer_name,
    COUNT(DISTINCT s.sls_ord_num) AS customer_order
FROM
    crm_sales_sylver s
        LEFT JOIN
    crm_customer_sylver c ON s.sls_cust_id = c.cst_id
WHERE
    c.cst_fullname IS NOT NULL
GROUP BY c.cst_fullname , YEAR(s.sls_order_dt)
)
SELECT order_year,
customer_name,
customer_order,
MAX(customer_order) OVER (PARTITION BY customer_name) AS max_order,
MIN(customer_order) OVER (PARTITION BY customer_name) AS min_order,
FLOOR(AVG(customer_order) OVER (PARTITION BY customer_name)) AS average_order,
customer_order - FLOOR(AVG(customer_order) OVER (PARTITION BY customer_name)) AS diff_avg,
LAG(customer_order) OVER (PARTITION BY customer_name ORDER BY order_year) AS previous_order,
customer_order - LAG(customer_order) OVER (PARTITION BY customer_name ORDER BY order_year) AS diff_previous,
CASE
 WHEN customer_order - LAG(customer_order) OVER (PARTITION BY customer_name ORDER BY order_year) > 0 THEN 'Increase'
 WHEN customer_order - LAG(customer_order) OVER (PARTITION BY customer_name ORDER BY order_year) < 0 THEN 'Decrease'
ELSE 'No Change'
END AS previous_change
FROM customer_order
ORDER BY customer_name, order_year;