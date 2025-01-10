 WITH stg_employees AS (
    SELECT *
    FROM {{ ref('stg_query1') }}
),
stg_company AS(
    SELECT company_id
    FROM {{ source('abc','companies')}}
),
stg_order AS (
    SELECT order_id, employee_id, customer_id, total, status, date 
    FROM {{ source('abc', 'orders') }}
),
stg_order_items AS (
    SELECT order_id, product_id, qty, unit_price, status AS status2, date2 
    FROM {{ source('abc', 'order_items') }}
),
stg_products AS (
    SELECT product_id, available_stock, company_id, name AS names
    FROM {{ source('abc', 'products') }}
),
stg_stores AS (
    SELECT store_id, city, postal_code
    FROM {{ source('abc', 'stores') }}
),
stg_customers AS (
    SELECT customer_id
    FROM {{ source('abc','customers')}}
),
int_final2 AS (
    SELECT 
        S.store_id, -- Added store_id here
        S.city,
        S.postal_code,
        E.employee_id, -- Added employee_id here
        E.name,
        P.product_id, -- Added product_id here
        P.names,
        P.available_stock,
        O.order_id,
        O.total,
        O.status,
        O.date,
        OI.qty,
        OI.unit_price,
        OI.status2,
        OI.date2,
        C.company_id,
        CU.customer_id
    FROM stg_stores S
    LEFT JOIN stg_employees E
        ON E.store_id = S.store_id
    LEFT JOIN stg_order O
        ON O.employee_id = E.employee_id
    LEFT JOIN stg_order_items OI
        ON OI.order_id = O.order_id
    LEFT JOIN stg_products P
        ON OI.product_id = P.product_id
    LEFT JOIN stg_company C
        ON P.company_id = C.company_id
    LEFT JOIN stg_customers CU
        ON O.customer_id = CU.customer_id
)
SELECT *
from int_final2