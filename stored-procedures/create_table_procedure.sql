/*Save the create table in stored procedures*/
DELIMITER //
DROP PROCEDURE IF EXISTS create_table //
CREATE PROCEDURE create_table()
BEGIN 
	DECLARE table_exists INT DEFAULT 0;
		SELECT COUNT(*) INTO table_exists 
		FROM
			information_schema.tables
		WHERE table_name = 'crm_customer'
           and
               table_schema = database();
		 IF table_exists = 0 THEN 
			CREATE TABLE crm_customer (
				cst_id INT,
				cst_key VARCHAR(50),
				cst_firstname VARCHAR(50),
				cst_lastname VARCHAR(50),
				cst_marital_status VARCHAR(50),
				cst_gndr VARCHAR(50),
				cst_create_date DATE,
                PRIMARY KEY (cst_id)
			);
		  SELECT TRUE AS table_created;
		ELSE 
		  SELECT FALSE AS table_created;
		END IF ;
END //
DELIMITER ;
CALL create_table();