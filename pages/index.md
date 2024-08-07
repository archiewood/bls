---
title: BLS Salary Explorer
---

This app explores the Bureau of Labor Statistics (BLS) data on salaries from the [Occupational Employment and Wage Statistics (OEWS) survey](https://www.bls.gov/oes/). 

The data is available at the national, state, and metropolitan area levels.

```sql area
select * from bls.area
```

```sql occupation
select *, '/occupation/' || occupation_code as link from bls.occupation
```

## Occupation Explorer

<DataTable data={occupation} search link=link compact>
    <Column id=occupation_code />
    <Column id=occupation_name />
</DataTable>

## State Explorer

```sql state
select *, '/state/' || state_code as link 
from bls.area
where areatype_code = 'S'
```

<DataTable data={state} search link=link compact>
    <Column id=state_code />
    <Column id=area_name />
</DataTable>

## Metro Area Explorer

```sql metro
select *, '/metro/' || area_code as link
from bls.area
where areatype_code = 'M'
```

<DataTable data={metro} search link=link compact>
    <Column id=area_code />
    <Column id=area_name />
</DataTable>