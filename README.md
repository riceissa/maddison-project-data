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

Some resources:

- <https://dev.mysql.com/doc/refman/5.7/en/optimizing-innodb-bulk-data-loading.html>
- <https://stackoverflow.com/questions/22164070/mysql-insert-20k-rows-in-single-insert>
- <https://www.google.com/search?q=mysql%20disable%20consistency%20checking>

To address specific points:

- Bunching together many values in a single `insert` statement. We already do this.
  We currently insert 5000 values per `insert` statement. Doing more than this
  might be possible, but could run into problems because MySQL has a
  [`max_allowed_packet`](https://stackoverflow.com/questions/3536103/mysql-how-many-rows-can-i-insert-in-one-single-insert-statement)
  size (not sure if increasing that could lead to problems).
- Number of connections. Not sure about this. I think we currently have a single
  connection per dataset we are importing. My intuition is that decreasing this
  wouldn't help much, since it is already pretty small. I don't think loading
  up all the datasets in one `mysql` command by `cat`ing all the SQL files will
  suddenly speed everything up.
- Delaying index updates. Not sure about this.
- Delaying consistency checks. Not sure about this.

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
