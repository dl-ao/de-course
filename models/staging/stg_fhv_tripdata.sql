{{ config(materialized='view') }}

select
    dispatching_base_num,
    cast(pickup_datetime as timestamp) as pickup_datetime,
    cast(dropoff_datetime as timestamp) as dropoff_datetime,
    cast(PULocationID as integer) as pickup_locationid,
    cast(DOLocationID as integer) as dropoff_locationid,
    cast(SR_Flag as integer) as SR_Flag
from {{ source('staging','fhv_tripdata') }}
-- where rn = 1
{% if var('is_test_run', default=false) %}
    -- dbt build --m <model.sql> --var 'is_test_run: false'
    limit 100

{% endif %}