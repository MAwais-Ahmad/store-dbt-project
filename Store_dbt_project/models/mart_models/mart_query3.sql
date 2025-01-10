WITH stg_special AS (
    SELECT store_id, order_id, total, status
    FROM {{ ref('int_query1')}}
)
SELECT 
    store_id, 
    COUNT(order_id) AS number_of_orders, 
    CAST(SUM(total) / COUNT(order_id) AS INT64) AS average_order_value,  
    SUM(total) AS total_sales
FROM stg_special
WHERE status != 'Returned'
GROUP BY store_id
ORDER BY total_sales DESC
