# Metro

```sql metro
select *, 
'/metro/' || area_code as link
from bls.area
where areatype_code = 'M'
```

<DataTable data={metro} search link=link compact rows=100>
    <Column id=area_code />
    <Column id=area_name />
</DataTable>

