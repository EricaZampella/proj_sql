SELECT 
    sls_ord_num
FROM
    crm_sales
WHERE
    sls_ord_num != TRIM(sls_ord_num);
/*We don't have unwanted spaces in the sales order number*/

SELECT 
    *
FROM
    crm_sales
WHERE
    sls_prd_key NOT IN (SELECT 
            prd_key
        FROM
            crm_product_sylver);

SELECT 
    *
FROM
    crm_sales
WHERE
    sls_cust_id NOT IN (SELECT 
            cst_id
        FROM
            crm_customer_sylver);
/*sls_prd_key and prd_key are the same, and also, sls_cust_id and cst_id are the same*/
/*There are no issue in the connection between table*/

/*sls_order_dt, sls_ship_dt and sls_due_dt are Date*/
SELECT 
    sls_order_dt,
    sls_ship_dt,
    sls_due_dt,
    CHAR_LENGTH(sls_order_dt) as ch_len_order,
    CHAR_LENGTH(sls_ship_dt) as ch_len_ship,
    CHAR_LENGTH(sls_due_dt) as ch_len_due
FROM
    crm_sales
WHERE
    CHAR_LENGTH(sls_order_dt) != 8
        OR CHAR_LENGTH(sls_ship_dt) != 8
        OR CHAR_LENGTH(sls_due_dt) != 8;
/*In sls_order_dt we have 0 and strings that are not date*/

SELECT 
    sls_order_dt,
    sls_ship_dt,
    sls_due_dt
FROM
    crm_sales
WHERE sls_order_dt > sls_ship_dt
OR sls_order_dt > sls_due_dt;
/*There are no issue with the order of the date*/

SELECT 
    sls_sales, sls_price
FROM
    crm_sales
WHERE
    sls_sales <= 0 OR sls_sales IS NULL
        OR sls_price <= 0
        OR sls_price IS NULL;
/*There are negative number, null and 0 in sales*/
/*There are negative number and null in price*/

SELECT sls_sales, sls_quantity, sls_price
FROM warehouse.crm_sales
WHERE sls_sales != sls_quantity* ABS(sls_price);
/*There are some values that not fulfil the business rule sales= quantity * price*/


 /*Replace '0' and less character then 8 with null in the sls_order_dt*/
 /*Transform sls_order_dt, sls_ship_dt and sls_due_dt from integer to date*/
 /*Calculate the sales when there is negative, zero and null using the business rule*/
 /*Calculate the price when there is negative, zero and null using the business rule*/
SELECT 
    sls_ord_num,
    sls_prd_key,
    sls_cust_id,
    CASE
        WHEN
            sls_order_dt = 0
                OR CHAR_LENGTH(sls_order_dt) != 8
        THEN
            NULL
        ELSE CAST(sls_order_dt AS DATE)
    END AS sls_order_dt,
    CAST(sls_ship_dt AS DATE) AS sls_ship_dt,
    CAST(sls_due_dt AS DATE) AS sls_due_dt,
    CASE
        WHEN
            sls_sales IS NULL OR sls_sales <= 0
                OR sls_sales != sls_quantity * ABS(sls_price)
        THEN
            sls_quantity * ABS(sls_price)
        ELSE sls_sales
    END AS sls_sales,
    sls_quantity,
    CASE
        WHEN sls_price IS NULL THEN CONVERT( sls_sales / sls_quantity , UNSIGNED)
        ELSE ABS(sls_price)
    END AS sls_price
FROM
    crm_sales;