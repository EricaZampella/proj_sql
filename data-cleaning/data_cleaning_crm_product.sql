SELECT 
    prd_id
FROM
    warehouse.crm_product
WHERE
    prd_id IS NULL;
/*There are no null in the prd_id.*/

SELECT 
    prd_id, COUNT(prd_id)
FROM
    crm_product
GROUP BY prd_id
HAVING COUNT(prd_id) > 1;
/*There are no duplicate in the prd_id*/
 
SELECT 
    prd_key, prd_nm
FROM
    crm_product
WHERE
    prd_key IS NULL OR prd_nm IS NULL;
/*There are no null in the prd_key and in the product name.*/

SELECT 
    prd_cost
FROM
    crm_product
WHERE
    prd_cost IS NULL OR prd_cost LIKE '-%';
/*There are null in the prd_cost and no negative.*/

SELECT DISTINCT
    prd_line
FROM
    crm_product;
/*we have 4 distinct line of production and null.*/

SELECT 
    prd_line
FROM
    crm_product
WHERE
	prd_line LIKE ' %'
    or prd_line like '% ';
/*we have unwanted space in prd_line.*/

SELECT
prd_start_dt
FROM crm_product
WHERE prd_start_dt IS NULL;
/*No null in the product start date*/

SELECT
prd_start_dt, prd_end_dt
FROM crm_product
WHERE prd_end_dt < prd_start_dt;
/*The end date is earlier then the start date*/


/*The prd_key is the combination of the cat_id and prd_key.*/
/*Manage the null whith the 0*/
/*In product line remove the unwanted spaces*/
/*Prevent the case in the future when someone insert a value with lower case and unwanted spaces.*/
/*Modify M in Mountain, R in Road, S in Other Sales, T in Touring and null in N/A*/
/*We can gain the end date from the start date -1*/
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
    DATE_SUB(LEAD (prd_start_dt) OVER (PARTITION BY prd_key ORDER BY prd_start_dt), INTERVAL 1 DAY) AS new_end_date
FROM crm_product;