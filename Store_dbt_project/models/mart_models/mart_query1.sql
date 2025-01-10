WITH stg_emp as (
SELECT *
FROM {{ ref('int_query1_3')}}
),
int_final2 as(
SELECT * 
FROM {{ ref('int_query1_2')}}
),
mart_final AS (
SELECT E.employee_id , E.name, P.store_id, P.city, P.MAX_VALUE
FROM stg_emp E
INNER JOIN int_final2 P
ON E.MAX_VALUE = P.MAX_VALUE
)
SELECT employee_id, 
name, 
store_id, 
city, 
MAX_VALUE
FROM mart_final
ORDER BY MAX_VALUE DESC
