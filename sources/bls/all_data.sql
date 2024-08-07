select 
    trim(series_id) as series_id, 
    try_cast(value as float) as value 
from alldata