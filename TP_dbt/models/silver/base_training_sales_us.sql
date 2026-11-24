with source as (
    select * from {{ source('training', 'sales_us') }}
),
renamed as (
    select *
    from source
)

select *
from renamed