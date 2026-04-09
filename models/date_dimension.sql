{{ config(materialized='table') }}

with clean_dates as (
    select  
    to_timestamp(replace(STARTED_AT, '"', '')) as STARTED_AT 
    from {{ source('demo_source', 'BIKE_TABLE') }}
),
dates as (
    select  
        STARTED_AT,
        date(STARTED_AT) as date_started_at,
        hour(STARTED_AT) as hour_started_at,
        dayname(STARTED_AT) as day_started_at,
        case when dayname(STARTED_AT) in ('Sat', 'Sun') then 'Weekend' else 'Weekday' end as weekday_started_at,
        month(started_at) as month_started_at,
        case when month(started_at) in (12,1,2) then 'Winter'
            when month(started_at) in (3,4,5) then 'Spring'
            when month(started_at) in (6,7,8) then 'Summer'
            else 'Autumn' end as season_started_at
    from clean_dates
)
select * from dates
