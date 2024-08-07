select 
    trim(s.series_id) as series_id,
    --seasonal,
    areatype_code,
    industry_code,
    occupation_code,
    datatype_code,
    state_code,
    area_code,
    sector_code,
    series_title,
    try_cast(value as double) as value,
    --footnote_codes,
    --begin_year,
    --begin_period,
    --end_year,
    --end_period
from series s
left join alldata a 
on trim(s.series_id) = trim(a.series_id)
${qa_filter}
