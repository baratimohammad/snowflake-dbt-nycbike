with cte as (
    select
    t.*,
    w.*
    from
    {{ ref('trips_fact') }} t
    left join {{ ref('daily_weather') }} w 
    on t.DATE = w.daily_weather
    
)
select * from cte