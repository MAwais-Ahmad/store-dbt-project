WITH sales_data AS (
    
    SELECT 
        store_id, 
        product_id, 
        SUM(CASE WHEN CAST(date2 AS DATE) BETWEEN '2023-10-01' AND '2023-10-30' AND status2 != 'Returned' THEN qty ELSE 0 END) AS total_sold_previous_month,
        SUM(CASE WHEN CAST(date2 AS DATE) BETWEEN '2023-10-01' AND '2023-10-30' AND status2 = 'Returned' THEN qty ELSE 0 END) AS total_returns_previous_month,
        SUM(CASE WHEN CAST(date2 AS DATE) BETWEEN '2023-11-01' AND '2023-11-30' AND status2 != 'Returned' THEN qty ELSE 0 END) AS total_sold_last_month,
        SUM(CASE WHEN CAST(date2 AS DATE) BETWEEN '2023-11-01' AND '2023-11-30' AND status2 = 'Returned' THEN qty ELSE 0 END) AS total_returns_last_month
    FROM `nidal-test`.store.int_query1
    WHERE CAST(date2 AS DATE) BETWEEN '2023-10-01' AND '2023-11-30' 
    GROUP BY store_id, product_id
),
return_rates AS (
    SELECT 
        store_id,
        product_id,
        (total_returns_last_month / NULLIF(total_sold_last_month, 0)) AS return_rate_last_month,
        (total_returns_previous_month / NULLIF(total_sold_previous_month, 0)) AS return_rate_previous_month
    FROM sales_data 
),
ranked_products AS (
    SELECT 
        store_id,
        product_id,
        return_rate_last_month,
        return_rate_previous_month,
        ROW_NUMBER() OVER (PARTITION BY store_id ORDER BY return_rate_previous_month DESC, return_rate_last_month DESC, product_id ASC) AS rank
    FROM return_rates
    WHERE return_rate_last_month > return_rate_previous_month
)
SELECT 
    store_id,
    product_id,
    return_rate_last_month
FROM ranked_products
WHERE rank = 1 
    
ORDER BY store_id