SELECT 
    *
FROM
    erp_loc
WHERE
    CID != TRIM(CID) OR CID IS NULL;
/*There are no issue with the CID*/

SELECT DISTINCT
    CNTRY
FROM
    erp_loc;
/*There are full name of some country and the abbrevation of the same one, also null and blank spaces*/

SELECT 
    REPLACE(CID, '-', '') AS CID,
    CASE
        WHEN CNTRY = 'US' OR CNTRY = 'USA' THEN 'United States'
        WHEN CNTRY = 'DE' THEN 'Germany'
        WHEN
            CNTRY IS NULL OR CNTRY != TRIM(CNTRY)
                OR CNTRY = ''
        THEN
            'N/A'
        ELSE CNTRY
    END AS CNTRY
FROM
    erp_loc;