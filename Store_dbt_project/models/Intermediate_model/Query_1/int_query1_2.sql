WITH int_store_sale AS (
SELECT store_id, city, date, status as ST, total 
FROM {{ ref('int_query1')}}
)
SELECT store_id, city, MAX(total) AS MAX_VALUE
FROM int_store_sale
WHERE  CAST(date as DATE) BETWEEN '2023-09-01' AND '2023-12-31' 
AND ST != 'Returned'
GROUP BY city, store_id
ORDER BY store_id