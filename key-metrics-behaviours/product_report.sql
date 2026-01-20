-- PRODUCT REPORT
-- Key product metrics and behaviours
/*Product name, category, subcategory and cost*/
/*Segment products by revenue to identify high-performers, mid-range or low-performers*/
/*Aggregates product-level metrics:
                -total orders
                -total sales
                -total quantity sold
                -total customers
                -lifespan in months*/
/*Calculates valuable KPIs:
     - recency
     - average order revenue
     - average monthly revenue*/
WITH product_line AS (
SELECT 
    p.prd_key AS prd_key,
    p.prd_nm AS product_name,
    e.CAT AS category,
    e.SUBCAT AS subcategory,
    p.prd_cost AS cost,
    ABS(TIMESTAMPDIFF(MONTH,
                IFNULL(MAX(p.prd_end_dt), CURRENT_DATE()),
                MIN(p.prd_start_dt))) AS life_span_prd_line
FROM
    crm_product_sylver p
        LEFT JOIN
    erp_px_cat_sylver e ON p.cat_id = e.ID
GROUP BY p.prd_key , p.prd_nm , e.CAT , e.SUBCAT , p.prd_cost
),
product_info AS (
SELECT 
    p.prd_key AS product_key,
    SUM(s.sls_price) AS total_sales,
    SUM(s.sls_quantity) AS total_quantity,
    COUNT(DISTINCT s.sls_cust_id) AS total_customers,
    COUNT(DISTINCT s.sls_ord_num) AS total_orders,
    ROUND(AVG(s.sls_price / NULLIF(s.sls_quantity, 0)),
            1) AS avg_selling_price,
    MAX(s.sls_order_dt) AS last_sales_date,
        TIMESTAMPDIFF(MONTH,
        MIN(s.sls_order_dt),
        MAX(s.sls_order_dt)) AS life_span_order
FROM
    crm_product_sylver p
        LEFT JOIN
    crm_sales_sylver s ON p.prd_key = s.sls_prd_key
WHERE
    s.sls_order_dt IS NOT NULL
GROUP BY p.prd_key
)
SELECT 
    prd_key,
    product_name,
    category,
    subcategory,
    cost,
    life_span_prd_line,
    last_sales_date,
    TIMESTAMPDIFF(MONTH,
        last_sales_date,
        CURRENT_DATE()) AS recency_month,
    CASE
        WHEN total_sales > 50000 THEN 'High-Performer'
        WHEN total_sales >= 10000 THEN 'Mid-Range'
        ELSE 'Low-Performer'
    END AS product_performance,
    total_orders,
    total_sales,
    total_quantity,
    total_customers,
    avg_selling_price,
    CASE
        WHEN total_orders = 0 THEN 0
        ELSE ROUND(total_sales/ total_orders, 1)
    END AS avg_order_revenue,
	CASE
        WHEN life_span_order = 0 THEN total_sales
        ELSE ROUND(total_sales/ life_span_order, 1)
    END AS avg_monthly_revenue
FROM
    product_line
        INNER JOIN
    product_info ON product_line.prd_key = product_info.product_key;