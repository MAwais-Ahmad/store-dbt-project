with first1 as (
    select * 
    from {{ ref('stg_stores__details') }}
),
second1 as (
    select *
    from {{ ref('stg_employees__details') }}
),
final as (
    select
        S.City, S.State, E.name, E.phone, E.employee_id
    from first1 S
    left join second1 E
    on  E.store_id= S.store_id  
)

select * from final
