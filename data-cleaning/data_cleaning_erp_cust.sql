SELECT 
    CID, COUNT(CID)
FROM
    erp_cust
GROUP BY CID
HAVING COUNT(CID) > 1;
/*No duplicates in CID and no other issue*/

SELECT 
    CID
FROM
    erp_cust
WHERE
    CID NOT LIKE 'NAS%';
/*'NAS' before some CID*/

SELECT BDATE
FROM erp_cust
WHERE BDATE > CURRENT_DATE();
/*There are later dates then the current date*/

SELECT DISTINCT GEN
FROM erp_cust;
/*We have 6 type of GEN: Male, Female, null, M, F and blank space*/



/*Eliminate 'NAS' from the CID*/
/*CID is equal to cst_key in crm_customer_sylver*/
/*Use null if the BDATE are later then the current date*/
/*Manage the type in GEN*/
SELECT 
    CASE
        WHEN CID LIKE 'NAS%' THEN SUBSTRING(CID, 4, LENGTH(CID))
        ELSE CID
    END AS CID,
    CASE
        WHEN BDATE > CURRENT_DATE() THEN NULL
        ELSE BDATE
    END AS BDATE,
	CASE
        WHEN GEN = 'F' THEN 'Female'
        WHEN GEN = 'M' THEN 'Male'
        WHEN GEN IS NULL OR GEN = ' ' THEN 'N/A'
        ELSE GEN
    END AS GEN
FROM
    erp_cust