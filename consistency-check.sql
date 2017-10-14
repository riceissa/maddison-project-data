drop temporary table if exists ct1;

drop temporary table if exists ct2;

create temporary table ct1 as select
  region, year,
  coalesce(sum(case when database_url = 'http://www.ggdc.net/maddison/Historical_Statistics/horizontal-file_02-2010.xls' and metric = 'GDP per capita' then `value` else 0 end), 0) as gdppc_2010,
  coalesce(sum(case when database_url = 'http://www.ggdc.net/maddison/maddison-project/data/mpd_2013-01.xlsx' and metric = 'GDP per capita' then `value` else 0 end), 0) as gdppc_2013
from data group by region, year;

select region from ct1 where year = 2008 and gdppc_2013 = 0 and gdppc_2010 > 0;

select region from ct1 where year = 2008 and gdppc_2010 = 0 and gdppc_2013 > 0;

create temporary table ct2 as select *, gdppc_2013 - gdppc_2010 as gdppc_diff from ct1 where gdppc_2010 > 0 and gdppc_2013 > 0;
