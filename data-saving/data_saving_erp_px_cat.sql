/*erp_px_cat is clean no issue*/
/*Create a new table for the cleaning data*/
CREATE TABLE erp_px_cat_sylver LIKE erp_px_cat;


INSERT INTO erp_px_cat_sylver
(ID,
  CAT,
  SUBCAT,
  MAINTENANCE
)
SELECT ID,
       CAT,
       SUBCAT,
	   MAINTENANCE
FROM erp_px_cat;

/*After the quality check we can define the PK*/
ALTER TABLE erp_px_cat_sylver
ADD PRIMARY KEY (ID);