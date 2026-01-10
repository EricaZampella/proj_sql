/*Create a new table for the cleaning data*/
CREATE TABLE erp_loc_sylver
LIKE erp_loc;

INSERT INTO erp_loc_sylver
        (CID,
          CNTRY
        )
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

/*After the quality check we can define the PK*/
ALTER TABLE erp_loc_sylver
ADD PRIMARY KEY (CID);