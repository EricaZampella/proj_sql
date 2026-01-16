/*Average products cost by year*/
SELECT 
    prd_nm,
    YEAR(prd_start_dt) AS year_,
    FLOOR(AVG(prd_cost)) AS avg_cost
FROM
    crm_product_sylver
GROUP BY YEAR(prd_start_dt) , prd_nm
ORDER BY year_;
/*Average products cost by month*/
SELECT 
    prd_nm,
    MONTH(prd_start_dt) AS month_,
    FLOOR(AVG(prd_cost)) AS avg_cost
FROM
    crm_product_sylver
GROUP BY MONTH(prd_start_dt) , prd_nm
ORDER BY month_ ASC;
/*Average products line cost by year*/
SELECT 
    prd_line,
    YEAR(prd_start_dt) AS year_,
    FLOOR(AVG(prd_cost)) AS avg_cost
FROM
    crm_product_sylver
GROUP BY YEAR(prd_start_dt) , prd_line
ORDER BY year_;
/*Average category cost by year*/
SELECT 
    e.CAT,
    YEAR(p.prd_start_dt) AS year_,
    FLOOR(AVG(p.prd_cost)) AS avg_cost
FROM
    crm_product_sylver p
    LEFT JOIN erp_px_cat_sylver e ON p.cat_id= e.ID
GROUP BY YEAR(p.prd_start_dt) , e.CAT
ORDER BY year_;
/*Average subcategory line cost by year*/
SELECT 
    e.SUBCAT,
    YEAR(p.prd_start_dt) AS year_,
    FLOOR(AVG(p.prd_cost)) AS avg_cost
FROM
    crm_product_sylver p
    LEFT JOIN erp_px_cat_sylver e ON p.cat_id= e.ID
GROUP BY YEAR(p.prd_start_dt) , e.SUBCAT
ORDER BY year_;