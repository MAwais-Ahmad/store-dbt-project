SELECT 
    product_id, 
    company_id, 
    SUM(available_stock) AS stock,  
    city 
FROM `nidal-test`.store.int_query1 
GROUP BY product_id, company_id, city
HAVING SUM(available_stock) < 100
ORDER BY company_id DESC
