/*Create a new table for the cleaning data*/
CREATE TABLE crm_customer_sylver
LIKE crm_customer;

ALTER TABLE crm_customer_sylver 
ADD cst_fullname VARCHAR(50)
AFTER cst_lastname;

INSERT INTO crm_customer_sylver
        (cst_id, 
         cst_key, 
         cst_firstname, 
         cst_lastname,
         cst_fullname,
         cst_marital_status, 
         cst_gndr, 
         cst_create_date
        )
        SELECT cst_id, 
               cst_key,
               TRIM(cst_firstname) as cst_firstname,
               TRIM(cst_lastname) as cst_lastname,
	           CONCAT(TRIM(cst_firstname), " ", TRIM(cst_lastname)) as cst_fullname,
              CASE
                WHEN UPPER(TRIM(cst_marital_status))= 'S' THEN 'SINGLE'
                WHEN UPPER(TRIM(cst_marital_status))= 'M' THEN 'MARRIED'
                ELSE 'N/A'
              END cst_marital_status, 
              CASE
                WHEN UPPER(TRIM(cst_gndr))= 'F' THEN 'FEMALE'
                WHEN UPPER(TRIM(cst_gndr))= 'M' THEN 'MALE'
                ELSE 'N/A'
			  END cst_gndr,
             cst_create_date
        FROM ( 
               SELECT *,
                   DENSE_RANK() OVER (PARTITION BY cst_id ORDER BY cst_create_date) AS flag 
		       FROM crm_customer
               WHERE cst_id IS NOT NULL
               )t
WHERE flag =1;

             
/*After the quality check we can define the PK*/
ALTER TABLE crm_customer_sylver
ADD PRIMARY KEY (cst_id);