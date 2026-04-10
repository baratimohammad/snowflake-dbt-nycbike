{% macro season(x) %}

case 
    when {{ x }} in (12,1,2) then 'Winter'
    when {{ x }} in (3,4,5) then 'Spring'
    when {{ x }} in (6,7,8) then 'Summer'
    else 'Autumn' 
end

{% endmacro %}
,
{% macro weekend(x)%}
case 
    when {{ x }} in ('Sat', 'Fri') then 'Weekend'
    else 'Weekday' 
end

{%endmacro%}