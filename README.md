# maddison-project-data

Each `proc_*.py` script uses one CSV file to produce one SQL file.

|Dataset|Script|CSV|SQL|Original spreadsheet|
|-------|------|---|---|--------------------|
|Maddison Project 2013 GDP per capita|[`proc_2013.py`](proc_2013.py)|`mpd_2013-01.csv`||[`mpd_2013-01.xlsx`](http://www.ggdc.net/maddison/maddison-project/data/mpd_2013-01.xlsx)|
|Maddison 2010 GDP per capita|[`proc_2010_percapita_gdp.py`](proc_2010_percapita_gdp.py)|`horizontal-file_02-2010-percapita-gdp.csv`||[`horizontal-file_02-2010.xls`](http://www.ggdc.net/maddison/Historical_Statistics/horizontal-file_02-2010.xls)|
|Maddison 2010 GDP growth|[`proc_2010_gdp_growth.py`](proc_2010_gdp_growth.py)|`horizontal-file_02-2010-gdp-growth.csv`||[`horizontal-file_02-2010.xls`](http://www.ggdc.net/maddison/Historical_Statistics/horizontal-file_02-2010.xls)|
|Maddison 2010 GDP|[`proc_2010_gdp.py`](proc_2010_gdp.py)|`horizontal-file_02-2010-gdp.csv`||[`horizontal-file_02-2010.xls`](http://www.ggdc.net/maddison/Historical_Statistics/horizontal-file_02-2010.xls)|
|Maddison 2010 GDP per capita growth|[`proc_2010_percapita_gdp_growth.py`](proc_2010_percapita_gdp_growth.py)|`horizontal-file_02-2010-percapita-gdp-growth.csv`||[`horizontal-file_02-2010.xls`](http://www.ggdc.net/maddison/Historical_Statistics/horizontal-file_02-2010.xls)|
|Maddison 2010 population|[`proc_2010_population.py`](proc_2010_population.py)|`horizontal-file_02-2010-population.csv`||[`horizontal-file_02-2010.xls`](http://www.ggdc.net/maddison/Historical_Statistics/horizontal-file_02-2010.xls)|
|Maddison 2010 population growth|[`proc_2010_population_growth.py`](proc_2010_population_growth.py)|`horizontal-file_02-2010-population-growth.csv`||[`horizontal-file_02-2010.xls`](http://www.ggdc.net/maddison/Historical_Statistics/horizontal-file_02-2010.xls)|

## CSV files

The CSV files were produced by opening the Excel spreadsheets in LibreOffice
and "saving as" CSV, one CSV file per sheet.

After producing the initial CSV, the top few lines were removed as they are
mostly blank. The initial value of the resulting top row is missing so the
appropriate value ("Year" or "Region" was inserted).

## License

CC0.
Data subject to their own copyrights, or whatever.

## External links

- https://github.com/expersso/maddison
- https://github.com/cran/maddison
