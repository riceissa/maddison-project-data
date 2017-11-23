# maddison-project-data

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

## External links

- https://github.com/expersso/maddison
- https://github.com/cran/maddison
