select *
from {{ source('demo_source', 'BIKE_TABLE') }}
limit 10