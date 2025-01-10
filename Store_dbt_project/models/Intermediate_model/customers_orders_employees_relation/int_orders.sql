with stg_order as (
    select * 
    from {{ source('abc', 'orders') }}
),
stg_customer as (
    select * 
    from {{ source('abc', 'customers') }}
),
int_employees as (
    select * 
    from {{ ref('stg_employees__details') }}
),
int_stores as (
    select * 
    from {{ ref('stg_stores__details') }}
),
int_coe_relation as (
    select 
        C.customer_id,     -- Example columns
        O.order_id,
        E.employee_id,
        S.store_id
    from int_stores S 
    inner join int_employees E
        on E.store_id = S.store_id
    inner join stg_order O 
        on O.employee_id = E.store_id
    inner join stg_customer C 
        on O.customer_id = C.customer_id
)
select * from int_coe_relation
