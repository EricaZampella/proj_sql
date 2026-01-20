-- CUSTOMER REPORT
-- Key customer metrics and behaviours
/*Full name, ages*/ /*and transaction details*/
/*Segment customers based on their spending behaviour and age groups*/
/*Aggregates customer-level metrics:
                -total orders
                -total sales
                -total quantity purchased
                -total products
                -lifespan in months*/
/*Calculates valuable KPIs:
     - recency
     - average order values
     - average monthly spend*/
 WITH customer_info AS (
SELECT 
    c.cst_id AS customer_key,
    c.cst_key AS customer_number,
    c.cst_fullname AS full_name,
    TIMESTAMPDIFF(YEAR,
        MAX(e.BDATE),
        CURRENT_DATE()) AS age
FROM
    crm_customer_sylver c
        LEFT JOIN
    erp_cust_sylver e ON c.cst_key = e.CID
GROUP BY cst_id
),
 product_customer AS (
SELECT 
    c.cst_fullname AS full_name,
    COUNT(DISTINCT s.sls_ord_num) AS total_orders,
    SUM(s.sls_sales) AS total_sales,
    SUM(s.sls_quantity) AS total_quantity,
    COUNT(DISTINCT s.sls_prd_key) AS total_product,
    MAX(s.sls_order_dt) AS last_order_date,
    TIMESTAMPDIFF(MONTH,
        MIN(sls_order_dt),
        MAX(sls_order_dt)) AS life_span
FROM
    crm_customer_sylver c
        LEFT JOIN
    crm_sales_sylver s ON c.cst_id = s.sls_cust_id
WHERE
    s.sls_order_dt IS NOT NULL
GROUP BY c.cst_id , c.cst_fullname
 )
 
SELECT 
    customer_key,
    customer_number,
    customer_info.full_name,
    age,
    CASE
        WHEN age < 20 THEN 'Under 20'
        WHEN age BETWEEN 20 AND 29 THEN '20-29'
        WHEN age BETWEEN 30 AND 39 THEN '30-39'
        WHEN age BETWEEN 40 AND 59 THEN '40-59'
        ELSE '60 and above'
    END AS age_group,
    total_orders,
    total_sales,
    total_quantity,
    total_product,
    last_order_date,
    TIMESTAMPDIFF(MONTH,
        last_order_date,
        CURRENT_DATE()) AS recency,
    life_span,
    CASE
        WHEN life_span >= 12 AND total_sales > 5000 THEN 'VIP'
        WHEN life_span >= 12 AND total_sales <= 5000 THEN 'Regular'
        ELSE 'New'
    END AS customers_behav,
    ROUND(total_sales / total_orders, 2) AS avg_order_value,
    CASE
        WHEN life_span = 0 THEN total_sales
        ELSE ROUND(total_sales / life_span, 2)
    END AS avg_monthly_spend
FROM
    customer_info
        INNER JOIN
    product_customer ON customer_info.full_name = product_customer.full_name