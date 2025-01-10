SELECT company_id, customer_id, count(product_id) AS frequency
FROM `nidal-test`.store.int_query1
GROUP BY company_id, customer_id 
HAVING COUNT(product_id) > 90
ORDER BY company_id 