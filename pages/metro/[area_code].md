---
breadcrumb: "select area_name as breadcrumb from bls.area where area_code = '${params.area_code}' and areatype_code = 'M'"
---

```sql metro
select * from bls.area
where area_code = '${params.area_code}'
and areatype_code = 'M'
```

# <Value data={metro} column=area_name/>

## Top Occupations

```sql top_occupations
select
    value,
    occupation_name,
    datatype_name,
from bls.all_data
left join bls.series using (series_id)
left join bls.datatype using (datatype_code)
left join bls.area using (area_code)
left join bls.occupation using (occupation_code)
where area.area_code = '${params.area_code}'
    and series.areatype_code = 'M'
    and industry_code = '000000'
    and datatype_code = '01'
    and display_level = 3
order by value desc
limit 10
```

<BarChart
    data={top_occupations}
    x=occupation_name
    y=value
    swapXY
    yFmt=num0
/>

## Best Paying Occupations

```sql best_paying_occupations
select
    value,
    occupation_name,
    datatype_name,
from bls.all_data
left join bls.series using (series_id)
left join bls.datatype using (datatype_code)
left join bls.area using (area_code)
left join bls.occupation using (occupation_code)
where area.area_code = '${params.area_code}'
    and series.areatype_code = 'M'
    and industry_code = '000000'
    and datatype_code = '04'
    and display_level = 3
order by value desc
limit 10
```

<BarChart
    data={best_paying_occupations}
    x=occupation_name
    y=value
    swapXY
    yFmt=usd0k
/>






