/*Create a new table for the cleaning data*/
CREATE TABLE crm_product_sylver
LIKE crm_product;

ALTER TABLE crm_product_sylver 
ADD cat_id VARCHAR(50)
AFTER prd_key;

INSERT INTO crm_product_sylver
        (prd_id, 
         prd_key, 
         cat_id, 
         prd_nm,
         prd_cost,
         prd_line,
         prd_start_dt,
         prd_end_dt
        )
SELECT
    prd_id,
    SUBSTRING(prd_key, 7, LENGTH(prd_key)) AS prd_key,
    REPLACE(SUBSTRING(prd_key, 1, 5),'-','_') AS cat_id,
prd_nm,
    IFNULL(prd_cost, 0) AS prd_cost,
    CASE
       WHEN TRIM( UPPER(prd_line))= "M" THEN "Mountain"
       WHEN TRIM( UPPER(prd_line))= "R" THEN "Road"
       WHEN TRIM( UPPER(prd_line))= "S" THEN "Other Sales"
       WHEN TRIM( UPPER(prd_line))= "T" THEN "Touring"
       ELSE "N/A"
    END prd_line,
    prd_start_dt,
    DATE_SUB(LEAD (prd_start_dt) OVER (PARTITION BY prd_key ORDER BY prd_start_dt), INTERVAL 1 DAY)
FROM crm_product;

             
/*After the quality check we can define the PK*/
ALTER TABLE crm_product_sylver
ADD PRIMARY KEY (prd_id);