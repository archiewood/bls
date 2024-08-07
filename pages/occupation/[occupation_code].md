---
breadcrumb: "select occupation_name as breadcrumb from bls.occupation where occupation_code = '${params.occupation_code}'"
---



# <Value data={occupation} value=occupation_name />
_Occupation Code: {params.occupation_code}_

```sql occupation
select * from bls.occupation
where occupation_code = '${params.occupation_code}'
```

```sql datatype
select * from bls.datatype
```

## National Statistics

```sql national_stats
select
    'All US' as area_name,
    datatype_name,
    value,
from bls.series
left join bls.datatype using (datatype_code)
where occupation_code = '${params.occupation_code}'
    and areatype_code = 'N'
    and industry_code = '000000'
order by datatype_code
```



- <Value data={national_stats} value=datatype_name row=3 />: <b><Value data={national_stats} value=value row=3 fmt=usd /></b>
- <Value data={national_stats} value=datatype_name row=12 />: <b><Value data={national_stats} value=value row=12 fmt=usd /></b>
- <Value data={national_stats} value=datatype_name row=0 />: <b><Value data={national_stats} value=value row=0 fmt=num0 /></b>

## State Statistics

<ButtonGroup name=metric>
    <ButtonGroupItem valueLabel="Annual mean wage" value="Annual mean wage" default />
    <ButtonGroupItem valueLabel="Employment" value="Employment" />
    <ButtonGroupItem valueLabel="25th percentile" value="Annual 25th percentile wage" />
    <ButtonGroupItem valueLabel="Median wage" value="Annual median wage" />
    <ButtonGroupItem valueLabel="75th percentile" value="Annual 75th percentile wage" />
</ButtonGroup>

```sql state_stats
select
    area_name,
    'US' || area.state_code as code,
    datatype_name,
    value,
from bls.series
left join bls.datatype using (datatype_code)
left join bls.area using (area_code)
where occupation_code = '${params.occupation_code}'
    and (datatype_name = '${inputs.metric}')
    and area.areatype_code = 'S'
    and industry_code = '000000'
    and area_name != 'Alaska'
    and area_name != 'Hawaii'
```


```sql state_stats_top5
select * from ${state_stats} 
order by value desc 
limit 5
```

<AreaMap
    data={state_stats}
    geoJsonUrl='/admin1.geojson'
    geoId=code_local
    areaCol=code
    value=value
    colorPalette={['#ffffff', '#08306b']}
    title='{inputs.metric} by State, {occupation[0].occupation_name}'
    tooltip={[
        {id: 'area_name', title: 'State'},
        {id: 'value', title: `${inputs.metric}`, fmt: inputs.metric == 'Employment' ? 'num0' : 'usd'}
    ]}
/>

### Top 5 States by {inputs.metric}

<ul class=markdown>
{#each state_stats_top5 as row}
<li class=markdown>
<Value data={row} column=area_name />: <b><Value data={row} column=value fmt={inputs.metric == 'Employment' ? 'num0' : 'usd'} /></b>
</li>
{/each}
</ul>


## Metro Statistics

```sql metro_stats
select
    area_name,
    substring(area_code,3,5) as code,
    datatype_name,
    value,
    row_number() over (partition by datatype_name order by value desc) as rank
from bls.series
left join bls.datatype using (datatype_code)
left join bls.area using (area_code)
where occupation_code = '${params.occupation_code}'
    and area.areatype_code = 'M'
    and industry_code = '000000'
    and (area_name not ilike '%AK' and area_name not ilike '%HI' and area_name not ilike '%PR')
order by datatype_name, value desc
```

```sql metro_stats_top5
select * from ${metro_stats} 
where rank <= 5
```

```sql metros
select *
from bls.area
where areatype_code = 'M'
```





<Tabs>
    {#each [{title: 'Annual mean wage', metric: 'Annual mean wage'}, {title: 'Employment', metric: 'Employment'}, {title: '25th percentile', metric: 'Annual 25th percentile wage'}, {title: 'Median wage', metric: 'Annual median wage'}, {title: '75th percentile', metric: 'Annual 75th percentile wage'}] as {title, metric}}
    <Tab label={title}>
        <AreaMap
            data={metro_stats.where(`datatype_name = '${metric}'`)}
            geoJsonUrl="/cbsa.geojson"
            geoId=GEOID
            areaCol=code
            value=value
            colorPalette={['#ffffff', '#08306b']}
            title='{metric} by Metro Area'
            tooltip={[
                {id: 'area_name', title: 'Metro Area'},
                {id: 'value', title: `${metric}`, fmt: 'num0'}
            ]}
        />

        <ul class=markdown>
            {#each metro_stats_top5 as row}
                    {#if row.datatype_name == metric}
                    <li class=markdown>
                        <Value data={row} column=area_name />: <b><Value data={row} column=value fmt={metric == 'Employment' ? 'num0' : 'usd'} /></b>
                    </li>
                    {/if}
            {/each}
        </ul>

    </Tab>
    {/each}
</Tabs>



