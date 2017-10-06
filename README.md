# maddison-project-data

Each `proc_*.py` script uses one CSV file to produce one SQL file.

|Dataset|Script|CSV|SQL|
|-------|------|---|---|
|Maddison Project 2013 GDP per capita|`proc_2013.py`|`mpd_2013-01.csv`||

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
