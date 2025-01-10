WITH int_employee_sale AS (
SELECT employee_id, name, date, status, total
FROM {{ ref('int_query1')}}
)
SELECT employee_id, name, MAX(total) AS MAX_VALUE
FROM int_employee_sale
WHERE  CAST(date as DATE) BETWEEN '2023-09-01' AND '2023-12-31' 
AND status != 'Returned'
GROUP BY employee_id, name
ORDER BY employee_id