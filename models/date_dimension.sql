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
        month(STARTED_AT) as month_started_at
    from clean_dates
),

seasons as (
    select
        *,
        {{ season('month_started_at') }} as season_started_at,
        {{ weekend('day_started_at')}} as weekend
    from dates
)

select * from seasons