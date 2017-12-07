# maddison-project-data

This repository contains the Maddison Project data, processing scripts, and output files (SQL files that can be imported into a MySQL databse).

As the first repository created for the Devec/Demography data portal project,
this repository additionally contains information relevant for all datasets:
the schema file used for all datasets and information on sanity checks and bulk
importing.

## To generate

To generate the SQL files, the scripts in this repository require the
[`devec_sql_common`](https://github.com/riceissa/devec_sql_common)
Python package.  To install, run:

```bash
git clone https://github.com/riceissa/devec_sql_common
cd devec_sql_common
pip3 install -e .
```

Now it is possible to run:

```bash
make
```

However, note that all the generated SQL files are already part of this
repository, so re-generating them is not necessary to use them.

## Crude check

The following will loop through each SQL file and country to see if the country
appears in the SQL file.  If the country does not appear, a message is printed.
This is intended as a crude check to see that region name normalization is
working.  In other words, if all the "bigger" countries are in the file, we can
be pretty sure that they were successfully normalized.  In the outer for-loop,
change `for f in maddison-*.sql` to use a different glob when working with
other datasets (e.g. Penn World Table).

```bash
# List from https://en.wikipedia.org/wiki/List_of_countries_by_GDP_(nominal)
declare -a arr=("'United States'" "'China'" "'Japan'" "'Germany'"
"'United Kingdom'" "'France'" "'India'" "'Italy'" "'Brazil'" "'Canada'"
"'South Korea'" "'Russia'" "'Australia'" "'Spain'" "'Mexico'" "'Indonesia'"
"'Turkey'" "'Netherlands'" "'Switzerland'" "'Saudi Arabia'" "'Argentina'"
"'Taiwan'" "'Sweden'" "'Poland'" "'Belgium'" "'Thailand'" "'Nigeria'" "'Austria'"
"'Iran'" "'United Arab Emirates'" "'Norway'" "'Egypt'" "'Hong Kong'" "'Israel'"
"'Denmark'" "'Philippines'" "'Singapore'" "'Malaysia'" "'South Africa'"
"'Ireland'" "'Colombia'" "'Pakistan'" "'Chile'" "'Finland'" "'Venezuela'"
"'Bangladesh'" "'Portugal'" "'Vietnam'" "'Peru'" "'Greece'" "'Czech Republic'"
"'Romania'" "'New Zealand'" "'Iraq'" "'Algeria'" "'Qatar'" "'Kazakhstan'"
"'Hungary'" "'Kuwait'" "'Morocco'" "'Puerto Rico'" "'Ecuador'" "'Angola'"
"'Sudan'" "'Ukraine'" "'Slovakia'" "'Sri Lanka'" "'Syria'" "'Ethiopia'"
"'Dominican Republic'" "'Kenya'" "'Guatemala'" "'Uzbekistan'" "'Myanmar'"
"'Oman'" "'Luxembourg'" "'Costa Rica'" "'Panama'" "'Uruguay'" "'Bulgaria'"
"'Lebanon'" "'Croatia'" "'Belarus'" "'Tanzania'" "'Macau'" "'Lithuania'"
"'Democratic Republic of the Congo'" "'Jordan'" "'Serbia'" "'Azerbaijan'"
"'Turkmenistan'" "'Ivory Coast'" "'Bolivia'" "'Libya'" "'Bahrain'"
"'Cameroon'" "'Latvia'")
for f in maddison-*.sql
do
    for i in "${arr[@]}"
    do
        grep -q "$i" $f || echo "$f: $i not found"
    done
done
```

## Tips for inserting a large amount of data

The Devec datasets import a large amount of data into MySQL. This process
can take a lot of time especially if changes need to be made to the data
(as when region name or metric name normalization is being done). It would
be nice to speed this up.

There are a couple of MyISAM-only options for speeding up large insertions, but
since we are using InnoDB, we can ignore these.

Some resources:

- <https://dev.mysql.com/doc/refman/5.7/en/optimizing-innodb-bulk-data-loading.html>
- <https://stackoverflow.com/questions/22164070/mysql-insert-20k-rows-in-single-insert>
- <https://www.google.com/search?q=mysql%20disable%20consistency%20checking>
- <https://dev.mysql.com/doc/refman/5.7/en/insert-optimization.html>
- <https://dev.mysql.com/doc/refman/5.6/en/optimizing-innodb-diskio.html>
- <http://derwiki.tumblr.com/post/24490758395/loading-half-a-billion-rows-into-mysql>
  (uses load data infile for a bulk import)
- <https://dbahire.com/testing-the-fastest-way-to-import-a-table-into-mysql-and-some-interesting-5-7-performance-results/>
- <https://stackoverflow.com/questions/2463602/mysql-load-data-infile-acceleration/2504211#2504211>
  With the following options:

      set unique_checks = 0;
      set foreign_key_checks = 0;
      set sql_log_bin = 0;

  importing TED took 2m18.889s the first time and 1m48.951s the second time.
  Without these options, the import times were 2m1.650s the first time and
  1m53.965s the second time. So I don't think these options really matter much.
  (Note that at this time, uniqueness was checked in Python already so the
  schema did not include a `unique` clause.)

  With:

  ```mysql
  set autocommit = 0;
  # insert lines here
  commit;
  ```

  importing TED took 1m52.774s the first time and 1m38.765s the second time, so
  this seems to be an actual improvement.

  With:

  ```mysql
  set unique_checks = 0;
  set foreign_key_checks = 0;
  set sql_log_bin = 0;
  set autocommit = 0;

  start transaction;

  # insert statements here

  commit;
  set autocommit = 1;
  ```

  importing took 1m46.811s the first time and 1m46.764s the second time.
  (The `start transaction` was suggested in [this answer](https://stackoverflow.com/a/2950764/3422337).)

- From ["Insert"](http://use-the-index-luke.com/sql/dml/insert):

  > Considering `insert` statements only, it would be best to avoid indexes
  > entirely—this yields by far the best `insert` performance. However tables
  > without indexes are rather unrealistic in real world applications. You
  > usually want to retrieve the stored data again so that you need indexes to
  > improve query speed. Even write-only log tables often have a primary key
  > and a respective index.
  >
  > Nevertheless, the performance without indexes is so good that it can make
  > sense to temporarily drop all indexes while loading large amounts of
  > data—provided the indexes are not needed by any other SQL statements in the
  > meantime. This can unleash a dramatic speed-up which is visible in the
  > chart and is, in fact, a common practice in data warehouses.

  But doesn't adding in the index later with `alter table` cost a lot of time
  as well?  Yes, but it's faster anyway. With:

  ```mysql
  truncate `data`;
  set autocommit = 0;
  # insert statements here
  alter table `data` add index `region`(`region`);
  ```

  The first time was 1m12.989s and the second time was 1m13.651s.

To address specific points:

- Bunching together many values in a single `insert` statement. We already do this.
  We currently insert 5000 values per `insert` statement. Doing more than this
  might be possible, but could run into problems because MySQL has a
  [`max_allowed_packet`](https://stackoverflow.com/questions/3536103/mysql-how-many-rows-can-i-insert-in-one-single-insert-statement)
  size (not sure if increasing that could lead to problems).
  According to [this answer](https://stackoverflow.com/questions/1793169/which-is-faster-multiple-single-inserts-or-one-multiple-row-insert/10276827#10276827),
  increasing this beyond 50 rows at a time might not help that much, so I think
  we are good here.
- Number of connections. Not sure about this. I think we currently have a single
  connection per dataset we are importing. My intuition is that decreasing this
  wouldn't help much, since it is already pretty small. I don't think loading
  up all the datasets in one `mysql` command by `cat`ing all the SQL files will
  suddenly speed everything up.
- Delaying index updates. Not sure about this. I think this might mean the
  strategy of making a table initially without indexes, then adding in the
  index after loading all the data.
- Delaying consistency checks. Not sure about this. We don't use any foreign keys
  so checking for that is unnecessary.
- `innodb_buffer_pool_size` ("Specifies the size of the buffer pool. If the buffer pool is small and you have sufficient memory, making the buffer pool larger can improve performance by reducing the amount of disk I/O needed as queries access InnoDB tables." [source](https://dev.mysql.com/doc/refman/5.7/en/innodb-buffer-pool.html "“14.6.3.1 The InnoDB Buffer Pool § InnoDB Buffer Pool Configuration Options”.") so probably not useful for reading in data),
  `innodb_log_file_size` (from
  [this page](https://www.percona.com/blog/2007/05/24/predicting-how-long-data-load-would-take/)), `innodb_change_buffering` (from [this answer](https://dba.stackexchange.com/questions/20862/mysql-load-from-infile-stuck-waiting-on-hard-drive/20864#20864)),
  `innodb_io_capacity` (from [this answer](https://dba.stackexchange.com/a/21680)).
  Even more variables for InnoDB are listed in [this post](https://nbsoftsolutions.com/blog/optimizing-innodb-bulk-insert).
- `LOAD DATA INFILE`. Not totally sure about this. Due to the `secure_file_priv`
  option, I think doing this would require moving all generated TSV files to
  `/var/lib/mysql-files/` (run `select @@secure_file_pri;` to see where the
  directory is on each system).  And since that directory is owned by the mysql
  user, we also have to deal with the file system permissions.

Listing out all the insert options? From [this answer](https://stackoverflow.com/questions/11389449/performance-of-mysql-insert-statements-in-java-batch-mode-prepared-statements-v/11390363#11390363):

- Single inserts (prepare the insert statement during each iteration)
- Batched inserts (prepare the insert statement once, but add each row separately to the batch; uses parametrized insertion of the client language)
- Manual bulk inserts (make a long string with values, then insert at once; I think this is what we do now with the large SQL files)
- Prepared bulk inserts (?? not sure how this one differs from manual bulk inserts)
- Load data `LOAD DATA INFILE` (load data from a CSV/TSV file; this involves less parsing compared to bulk inserts, so is faster?)

I'm not sure how "batched" and "bulk" are different.

[This post](http://brian.pontarelli.com/2011/06/21/jdbc-batch-vs-multi-row-inserts/)
tests batch vs single multi-row insert and finds the latter to be faster.

The general idea I'm getting is that time taken is: single inserts > batch inserts >
bulk inserts > load data infile.

## Explanation of files

Each `proc_*.py` script uses one CSV file to produce one SQL file.

|Dataset|Script|CSV|SQL|Original spreadsheet|
|-------|------|---|---|--------------------|
|Maddison Project 2013 GDP per capita|[`proc_2013.py`](proc_2013.py)|[`mpd_2013-01.csv`](mpd_2013-01.csv)|[`maddison-2013.sql`](maddison-2013.sql)|[`mpd_2013-01.xlsx`](http://www.ggdc.net/maddison/maddison-project/data/mpd_2013-01.xlsx)|
|Maddison 2010 GDP per capita|[`proc_2010_percapita_gdp.py`](proc_2010_percapita_gdp.py)|[`horizontal-file_02-2010-percapita-gdp.csv`](horizontal-file_02-2010-percapita-gdp.csv)|[`maddison-2010-percapita-gdp.sql`](maddison-2010-percapita-gdp.sql)|[`horizontal-file_02-2010.xls`](http://www.ggdc.net/maddison/Historical_Statistics/horizontal-file_02-2010.xls)|
|Maddison 2010 GDP growth|[`proc_2010_gdp_growth.py`](proc_2010_gdp_growth.py)|[`horizontal-file_02-2010-gdp-growth.csv`](horizontal-file_02-2010-gdp-growth.csv)|[`maddison-2010-gdp-growth.sql`](maddison-2010-gdp-growth.sql)|[`horizontal-file_02-2010.xls`](http://www.ggdc.net/maddison/Historical_Statistics/horizontal-file_02-2010.xls)|
|Maddison 2010 GDP|[`proc_2010_gdp.py`](proc_2010_gdp.py)|[`horizontal-file_02-2010-gdp.csv`](horizontal-file_02-2010-gdp.csv)|[`maddison-2010-gdp.sql`](maddison-2010-gdp.sql)|[`horizontal-file_02-2010.xls`](http://www.ggdc.net/maddison/Historical_Statistics/horizontal-file_02-2010.xls)|
|Maddison 2010 GDP per capita growth|[`proc_2010_percapita_gdp_growth.py`](proc_2010_percapita_gdp_growth.py)|[`horizontal-file_02-2010-percapita-gdp-growth.csv`](horizontal-file_02-2010-percapita-gdp-growth.csv)|[`maddison-2010-percapita-gdp-growth.sql`](maddison-2010-percapita-gdp-growth.sql)|[`horizontal-file_02-2010.xls`](http://www.ggdc.net/maddison/Historical_Statistics/horizontal-file_02-2010.xls)|
|Maddison 2010 population|[`proc_2010_population.py`](proc_2010_population.py)|[`horizontal-file_02-2010-population.csv`](horizontal-file_02-2010-population.csv)|[`maddison-2010-population.sql`](maddison-2010-population.sql)|[`horizontal-file_02-2010.xls`](http://www.ggdc.net/maddison/Historical_Statistics/horizontal-file_02-2010.xls)|
|Maddison 2010 population growth|[`proc_2010_population_growth.py`](proc_2010_population_growth.py)|[`horizontal-file_02-2010-population-growth.csv`](horizontal-file_02-2010-population-growth.csv)|[`maddison-2010-population-growth.sql`](maddison-2010-population-growth.sql)|[`horizontal-file_02-2010.xls`](http://www.ggdc.net/maddison/Historical_Statistics/horizontal-file_02-2010.xls)|

## CSV files

The CSV files were produced by opening the Excel spreadsheets in LibreOffice
and "saving as" CSV, one CSV file per sheet.

After producing the initial CSV, the top few lines were removed as they are
mostly blank. The initial value of the resulting top row is missing so the
appropriate value ("Year" or "Region" was inserted).

## License

CC0.
Data subject to their own copyrights, or whatever.

## See also

This repository is part of a series of repositories that deal with development
datasets.  The others are:

- [penn-world-table-data](https://github.com/riceissa/penn-world-table-data), a
  similar project for the Penn World Table that uses the same database schema
- [world development indicators](https://github.com/riceissa/world-development-indicators)
- [total-economy-database](https://github.com/riceissa/total-economy-database)
- [fred-processing](https://github.com/riceissa/fred-processing)
- [devec\_sql\_common](https://github.com/riceissa/devec_sql_common) contains
  common functions for use when working with all datasets

## External links

- https://github.com/expersso/maddison
- https://github.com/cran/maddison
