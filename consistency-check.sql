drop temporary table if exists ct1;

drop temporary table if exists ct2;

create temporary table ct1 as select
  region, odate,
  cast(coalesce(sum(case when database_url = 'http://www.ggdc.net/maddison/Historical_Statistics/horizontal-file_02-2010.xls' and metric = 'GDP per capita' then `value` else 0 end), 0) as unsigned) as maddison_2010,
  cast(coalesce(sum(case when database_url = 'http://www.ggdc.net/maddison/maddison-project/data/mpd_2013-01.xlsx' and metric = 'GDP per capita' then `value` else 0 end), 0)  as unsigned) as maddison_2013,
  cast(cast(coalesce(max(case when metric = 'Real GDP at constant 2005 national prices' and database_url = 'http://www.rug.nl/ggdc/docs/pwt80.xlsx' then value else 0 end),0) as unsigned)/greatest(1,cast(coalesce(max(case when metric = 'Population' and database_url = 'http://www.rug.nl/ggdc/docs/pwt80.xlsx' then value else 0 end),0) as unsigned)) as unsigned) as pwt_2005id_80,
  cast(cast(coalesce(max(case when metric = 'Real GDP at constant 2005 national prices' and database_url = 'http://www.rug.nl/ggdc/docs/pwt81.xlsx' then value else 0 end),0) as unsigned)/greatest(1,cast(coalesce(max(case when metric = 'Population' and database_url = 'http://www.rug.nl/ggdc/docs/pwt81.xlsx' then value else 0 end),1) as unsigned)) as unsigned) as pwt_2005id_81,
  cast(cast(coalesce(max(case when metric = 'Real GDP at constant 2011 national prices' and database_url = 'http://www.rug.nl/ggdc/docs/pwt90.xlsx' then value else 0 end),0) as unsigned)/greatest(1,cast(coalesce(max(case when metric = 'Population' and database_url = 'http://www.rug.nl/ggdc/docs/pwt90.xlsx' then value else 0 end),1) as unsigned)) as unsigned) as pwt_2011id_90,
  cast(cast(coalesce(max(case when metric = 'Output-side real GDP at chained PPPs' and database_url = 'http://www.rug.nl/ggdc/docs/pwt80.xlsx' then value else 0 end),0) as unsigned)/greatest(1,cast(coalesce(max(case when metric = 'Population' and database_url = 'http://www.rug.nl/ggdc/docs/pwt80.xlsx' then value else 0 end),1) as unsigned)) as unsigned) as pwt_2005id_80c,
  cast(cast(coalesce(max(case when metric = 'Output-side real GDP at chained PPPs' and database_url = 'http://www.rug.nl/ggdc/docs/pwt81.xlsx' then value else 0 end),0) as unsigned)/greatest(1,cast(coalesce(max(case when metric = 'Population' and database_url = 'http://www.rug.nl/ggdc/docs/pwt81.xlsx' then value else 0 end),1) as unsigned)) as unsigned) as pwt_2005id_81c,
  cast(cast(coalesce(max(case when metric = 'Output-side real GDP at chained PPPs' and database_url = 'http://www.rug.nl/ggdc/docs/pwt90.xlsx' then value else 0 end),0) as unsigned)/greatest(1,cast(coalesce(max(case when metric = 'Population' and database_url = 'http://www.rug.nl/ggdc/docs/pwt90.xlsx' then value else 0 end),1) as unsigned)) as unsigned) as pwt_2011id_90c,
  cast(coalesce(max(case when metric = 'GDP per capita, PPP' and units = 'constant 2011 international dollar' and database_url = 'https://data.worldbank.org/data-catalog/world-development-indicators' then value else 0 end), 0) as unsigned) as wdi_const11,
  cast(coalesce(max(case when metric = 'GDP per capita, PPP' and units = 'current international dollar' and database_url = 'https://data.worldbank.org/data-catalog/world-development-indicators' then value else 0 end), 0) as unsigned) as wdi_curr,
  cast(coalesce(max(case when metric = 'GDP-capita-GK' and units is null and database_url = 'https://www.conference-board.org/retrievefile.cfm?filename=TED---Output-Labor-and-Labor-Productivity-1950-2016.xlsx&type=subsite' then value else 0 end),0) as unsigned) as ted_2016_gk,
  cast(coalesce(max(case when metric = 'GDP-capita-EKS' and units is null and database_url = 'https://www.conference-board.org/retrievefile.cfm?filename=TED---Output-Labor-and-Labor-Productivity-1950-2016.xlsx&type=subsite' then value else 0 end),0) as unsigned) as ted_2016_eks,
  cast(coalesce(max(case when metric = 'GDP-capita-GK' and units is null and database_url = 'https://www.conference-board.org/retrievefile.cfm?filename=TED---Output-Labor-and-Labor-Productivity-1950-2015.xlsx&type=subsite' then value else 0 end),0) as unsigned) as ted_2015_gk,
  cast(coalesce(max(case when metric = 'GDP-capita-EKS' and units is null and database_url = 'https://www.conference-board.org/retrievefile.cfm?filename=TED---Output-Labor-and-Labor-Productivity-1950-2015.xlsx&type=subsite' then value else 0 end),0) as unsigned) as ted_2015_eks,
  cast(coalesce(max(case when metric = 'GDP-capita-GK' and units is null and database_url = 'https://www.conference-board.org/retrievefile.cfm?filename=Output-Labor-and-Labor-Productivity-1950-2013.xls&type=subsite' then value else 0 end),0) as unsigned) as ted_2013_gk,
  cast(coalesce(max(case when metric = 'GDP-capita-EKS' and units is null and database_url = 'https://www.conference-board.org/retrievefile.cfm?filename=Output-Labor-and-Labor-Productivity-1950-2013.xls&type=subsite' then value else 0 end),0) as unsigned) as ted_2013_eks,
  cast(coalesce(max(case when metric = 'GDP-capita-GK' and units is null and database_url = 'https://www.conference-board.org/retrievefile.cfm?filename=Output-Labor-and-Labor-Productivity-1950-2012.xls&type=subsite' then value else 0 end),0) as unsigned) as ted_2012_gk,
  cast(coalesce(max(case when metric = 'GDP-capita-EKS' and units is null and database_url = 'https://www.conference-board.org/retrievefile.cfm?filename=Output-Labor-and-Labor-Productivity-1950-2012.xls&type=subsite' then value else 0 end),0) as unsigned) as ted_2012_eks,
  cast(coalesce(max(case when metric = 'GDP-capita-GK' and units is null and database_url = 'https://www.conference-board.org/retrievefile.cfm?filename=Output-Labor-and-Labor-Productivity-1950-2011.xls&type=subsite' then value else 0 end),0) as unsigned) as ted_2011_gk,
  cast(coalesce(max(case when metric = 'GDP-capita-EKS' and units is null and database_url = 'https://www.conference-board.org/retrievefile.cfm?filename=Output-Labor-and-Labor-Productivity-1950-2011.xls&type=subsite' then value else 0 end),0) as unsigned) as ted_2011_eks,
  cast(coalesce(max(case when metric = 'GDP-capita-GK' and units is null and database_url = 'https://www.conference-board.org/retrievefile.cfm?filename=Output-Labor-and-Labor-Productivity-1950-2010.xls&type=subsite' then value else 0 end),0) as unsigned) as ted_2010_gk,
  cast(coalesce(max(case when metric = 'GDP-capita-EKS' and units is null and database_url = 'https://www.conference-board.org/retrievefile.cfm?filename=Output-Labor-and-Labor-Productivity-1950-2010.xls&type=subsite' then value else 0 end),0) as unsigned) as ted_2010_eks
from data
  where metric in ('GDP per capita','Real GDP at constant 2005 national prices' ,'Real GDP at constant 2011 national prices','Output-side real GDP at chained PPPs','GDP per capita, PPP','Population','GDP-capita-GK','GDP-capita-EKS') and (units in ('1990 international dollar', '2005 international dollar','2011 international dollar','constant 2011 international dollar','current international dollar','People') OR units is null)
group by region, odate;
