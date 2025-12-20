SELECT 
    cst_id, COUNT(cst_id)
FROM
    warehouse.crm_customer
GROUP BY cst_id
HAVING COUNT(cst_id) > 1;
/*There are duplicate in the table.*/

SELECT 
    cst_firstname, cst_lastname
FROM
    crm_customer
WHERE
        cst_firstname LIKE '% '
        OR cst_firstname LIKE ' %'
        OR cst_lastname LIKE '% '
        OR cst_lastname LIKE ' %';
/*There are unwanted spaces in the first name and in the last name.*/

SELECT DISTINCT
    cst_gndr
FROM
    crm_customer;
/*We have M, F and null in gender.*/
SELECT 
    cst_gndr
FROM
    crm_customer
WHERE
    cst_gndr LIKE '% '
    or cst_gndr LIKE ' %';
/*We don't have unwanted spaces.*/

SELECT DISTINCT
    cst_marital_status
FROM
    crm_customer;
/*We have M, S and null in gender.*/
SELECT 
    cst_marital_status
FROM
    crm_customer
WHERE
    cst_marital_status LIKE '% '
    or cst_marital_status LIKE ' %';
/*We don't have unwanted spaces.*/

select*
from crm_customer
where cst_id is null;
/*We have some cst_id null.*/
/*Manage of the duplicate trough the last creation date.*/
/*Manage the unwanted spaces in the fist and last name.*/
/*Join the fist and last name.*/
/*Change F in FEMALE, M in MALE and null in N/A.*/
/*Change S in SINGLE, M in MARRIED and null in N/A.*/
/*Prevent the case in the future when someone insert a value with lower case and unwanted spaces.*/
/*We don't want cst_id null.*/


SELECT *,
    TRIM(cst_firstname) as cst_firstname_new,
    TRIM(cst_lastname) as cst_lastname_new,
	CONCAT(TRIM(cst_firstname), " ", TRIM(cst_lastname)) as cst_fullname,
    CASE
   WHEN UPPER(TRIM(cst_gndr))= 'F' THEN 'FEMALE'
   WHEN UPPER(TRIM(cst_gndr))= 'M' THEN 'MALE'
   ELSE 'N/A'
END cst_gender,
CASE
   WHEN UPPER(TRIM(cst_marital_status))= 'S' THEN 'SINGLE'
   WHEN UPPER(TRIM(cst_marital_status))= 'M' THEN 'MARRIED'
   ELSE 'N/A'
END cst_maritalstatus
FROM ( 
        SELECT *,
             DENSE_RANK() OVER (PARTITION BY cst_id ORDER BY cst_create_date) AS flag 
		FROM crm_customer
        WHERE cst_id IS NOT NULL)t
WHERE flag =1