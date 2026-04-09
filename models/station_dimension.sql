{{ config(materialized='table') }}

with BIKE as (
    select
    distinct
    replace(START_STATION_ID, '"', '') as station_id,
    replace(start_station_name, '"', '') as station_name,
    round(start_lat, 6) as lat,
    round(start_lng, 6) as lng
    from
    {{ source('demo_source', 'BIKE_TABLE') }}
)
select * from BIKE
