/*Insert file cvs in the table*/

/*File cust_info*/
TRUNCATE TABLE crm_customer;
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/cust_info.csv'
INTO TABLE warehouse.crm_customer
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES
(@cst_id, @cst_key, @cst_firstname, @cst_lastname, @cst_marital_status, @cst_gndr, @cst_create_date)
SET 
    cst_id = NULLIF(@cst_id, ''),
    cst_key = NULLIF(@cst_key, ''),
    cst_firstname = NULLIF(@cst_firstname, ''),
    cst_lastname = NULLIF(@cst_lastname, ''),
    cst_marital_status = NULLIF(@cst_marital_status, ''),
    cst_gndr = NULLIF(@cst_gndr, ''),
    cst_create_date = NULLIF(@cst_create_date, '');

/*File prd_info*/
TRUNCATE TABLE crm_product;
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/prd_info.csv'
INTO TABLE warehouse.crm_product
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES
(@prd_id, @prd_key, @prd_nm, @prd_cost, @prd_line, @prd_start_dt, @prd_end_dt)
SET 
	prd_id = NULLIF(@prd_id, ''),
    prd_key = NULLIF(@prd_key, ''),
    prd_nm = NULLIF(@prd_nm, ''),
    prd_cost = NULLIF(@prd_cost, ''),
    prd_line = NULLIF(@prd_line, ''),
    prd_start_dt = NULLIF(@prd_start_dt, ''),
    prd_end_dt = NULLIF(@prd_end_dt, '');
    
/*File sales_details*/
TRUNCATE TABLE crm_sales;
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/sales_details.csv'
INTO TABLE warehouse.crm_sales
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES
(@sls_ord_num, @sls_prd_key, @sls_cust_id, @sls_order_dt, @sls_ship_dt, @sls_due_dt, @sls_sales, @sls_quantity, @ls_price)
SET 
	sls_ord_num = NULLIF(@sls_ord_num, ''),
    sls_prd_key = NULLIF(@sls_prd_key ,''),
    sls_cust_id = NULLIF(@sls_cust_id ,''),
    sls_order_dt = NULLIF(@sls_order_dt ,''),
    sls_ship_dt = NULLIF(@sls_ship_dt ,''),
    sls_due_dt = NULLIF(@sls_due_dt ,''),
    sls_sales = NULLIF(@sls_sales ,''),
    sls_quantity = NULLIF(@sls_quantity ,''),
    ls_price = NULLIF(@ls_price ,'');
    
/*File CUST_AZ12*/
TRUNCATE TABLE erp_cust;
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/CUST_AZ12.csv'
INTO TABLE warehouse.erp_cust
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES
(@CID, @BDATE, @GEN)
SET 
	CID = NULLIF(@CID ,''),
    BDATE = NULLIF(@BDATE ,''),
    GEN = NULLIF(@GEN ,'');
    
/*File LOC_A101*/
TRUNCATE TABLE erp_loc;
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/LOC_A101.csv'
INTO TABLE warehouse.erp_loc
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES
(@CID, @CNTRY)
SET 
	CID = NULLIF(@CID ,''),
    CNTRY = NULLIF(@CNTRY ,'');
    
/*File PX_CAT_G1V2*/
TRUNCATE TABLE erp_px_cat;
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/PX_CAT_G1V2.csv'
INTO TABLE warehouse.erp_px_cat
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES
(@ID,@CAT,@SUBCAT,@MAINTENANCE)
SET 
	ID = NULLIF(@ID ,''),
    CAT = NULLIF(@CAT ,''),
    SUBCAT = NULLIF(@SUBCAT ,''),
    MAINTENANCE = NULLIF(@MAINTENANCE ,'');