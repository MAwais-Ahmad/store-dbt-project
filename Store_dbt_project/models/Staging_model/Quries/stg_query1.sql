select 
    employee_id, 
    name, 
    store_id
from {{ source('abc','employees')}}