/*Create a new table for the cleaning data*/
CREATE TABLE crm_sales_sylver
LIKE crm_sales;

/*Modify the type for the data*/
ALTER TABLE crm_sales_sylver
MODIFY COLUMN sls_order_dt DATE,
MODIFY COLUMN sls_ship_dt DATE,
MODIFY COLUMN sls_due_dt DATE;

INSERT INTO crm_sales_sylver
        (sls_ord_num,
          sls_prd_key,
          sls_cust_id,
          sls_order_dt,
          sls_ship_dt,
          sls_due_dt,
          sls_sales,
          sls_quantity,
          sls_price
        )
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