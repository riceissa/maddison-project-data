# Create table for India at reference year
create temporary table t1 as
select
    odate,
    value,
    metric,
    database_url
from data
where
    region='India' and odate='20050000';

# Create a boolean table for the United States depending on whether a metric
# crossed the threshold Indian value
create temporary table t2 as
select
    odate,
    value,
    metric,
    (case when value > (select value from t1
            where t1.metric=data.metric and t1.database_url=data.database_url
            limit 1)  # FIXME there shouldn't be more than one result but there is unless we limit 1 here
        then true
        else false end) as boolean
from data
where
    region='United States' or region='USA' or region='US';

# Get the first year the US crossed the threshold
select min(odate),metric from t2 where boolean=true group by metric;
