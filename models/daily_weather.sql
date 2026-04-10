{{ config(materialized='table') }}

with daily_weather as (
    select 
    date(TIME) as daily_weather,
    WEATHER,
    CLOUDS,
    HUMIDITY,
    PRESSURE,
    TEMPERATURE
    from
    {{ source('demo_source', 'WEATHER')}}
),
daily_weather_agg as (
    select daily_weather,
    WEATHER,
    round(avg(CLOUDS), 2) as avg_cloud,
    round(avg(HUMIDITY), 2) as avg_humidity,
    round(avg(PRESSURE), 2) as avg_pressure,
    round(avg(TEMPERATURE), 2) as avg_temp
    from
    daily_weather
    group by daily_weather, WEATHER
    qualify row_number() over (partition by daily_weather order by count(WEATHER) desc) = 1
)

select * from daily_weather_agg