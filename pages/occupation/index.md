# Occupations

```sql occupations
select 
    *,
    '/occupation/' || occupation_code as link
from bls.occupation
```

Select an occupation for detailed statistics.

<DataTable data={occupations} search link=link compact rows=all>
    <Column id=occupation_code />
    <Column id=occupation_name />
</DataTable>

