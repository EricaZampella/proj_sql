/*Create a new table for the cleaning data*/
CREATE TABLE erp_cust_sylver
LIKE erp_cust;

INSERT INTO erp_cust_sylver
        (CID,
		 BDATE,
		 GEN
        )
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
    erp_cust;
    
/*After the quality check we can define the PK*/
ALTER TABLE erp_cust_sylver
ADD PRIMARY KEY (CID);