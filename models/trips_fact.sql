{{ config(materialized='table') }}

with trips as (
    select
    replace(ID, '"', '') as ID,
    -- replace(type, '"', '') as TYPE,
    date(to_timestamp(replace(STARTED_AT, '"', ''))) as date,
    replace(START_STATION_ID, '"', '') as START_STATION_ID,
    replace(END_STATION_ID, '"', '') as END_STATION_ID,
    replace(MEMBERSHIP, '"', '') as MEMBERSHIP,
    timestampdiff(second, to_timestamp(replace(STARTED_AT, '"', '')), to_timestamp(replace(ENDED_AT, '"', ''))) as trip_duration


    from
    {{ source('demo_source', 'BIKE_TABLE') }}
    limit 10
)
select * from trips