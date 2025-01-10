with stg_famous AS(
SELECT product_id, 
city, 
count(qty) AS no_of_times_purchased,
FROM `nidal-test`.store.int_query1
WHERE status2 != 'Returned'
GROUP BY product_id, city
ORDER BY product_id 
),
final AS(
SELECT product_id, 
city, 
no_of_times_purchased, 
ROW_NUMBER() OVER (PARTITION BY city ORDER BY no_of_times_purchased DESC, product_id ASC) AS rank
FROM stg_famous
)
SELECT *
FROM final
WHERE rank = 1 
ORDER BY city