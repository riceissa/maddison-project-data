create temporary table dt1 as select region, year, coalesce(sum(case when metric = 'GDP' then value else 0 end), 0) as gdp, coalesce(sum(case when metric = 'GDP per capita' then value else 0 end), 0) as gdppc, coalesce(sum(case when metric = 'Population' then value else 0 end), 0) as pop from data where database_url = 'http://www.ggdc.net/maddison/Historical_Statistics/horizontal-file_02-2010.xls' group by region, year;

create temporary table dt2 as select *, gdp / (1000 * pop * gdppc) as  fudge from dt1 where pop > 0 and gdppc > 0;

select count(*) from dt2;

select count(*) from dt2 where fudge < 0.98 or fudge > 1.02;

select * from dt2 where fudge < 0.98 or fudge > 1.02 order by fudge;
