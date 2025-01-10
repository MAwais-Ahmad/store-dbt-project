select status , date
from {{ source('abc','orders')}}