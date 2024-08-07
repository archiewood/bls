# State

```sql state
select *,
'/state/' || state_code as link
from bls.area
where areatype_code = 'S'
```

<DataTable data={state} link=link compact rows=60>
    <Column id=state_code />
    <Column id=area_name />
</DataTable>