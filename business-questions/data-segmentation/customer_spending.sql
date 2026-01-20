/*Segment customers based on their spending behaviour*/
WITH customer_spending AS (
SELECT 
    sls_cust_id,
    SUM(sls_sales) AS total_spending,
    MIN(sls_order_dt) AS first_order,
    MAX(sls_order_dt) AS last_order,
    TIMESTAMPDIFF(MONTH,
        MIN(sls_order_dt),
        MAX(sls_order_dt)) AS life_span,
    CASE
        WHEN
            TIMESTAMPDIFF(MONTH,
                MIN(sls_order_dt),
                MAX(sls_order_dt)) >= 12
                AND SUM(sls_sales) > 5000
        THEN
            'VIP'
        WHEN
            TIMESTAMPDIFF(MONTH,
                MIN(sls_order_dt),
                MAX(sls_order_dt)) >= 12
                AND SUM(sls_sales) <= 5000
        THEN
            'Regular'
        ELSE 'New'
    END AS customers_behav
FROM
    crm_sales_sylver
GROUP BY sls_cust_id
)

SELECT 
    customers_behav, COUNT(sls_cust_id) AS howmany_customers
FROM
    customer_spending
GROUP BY customers_behav
ORDER BY customers_behav DESC;