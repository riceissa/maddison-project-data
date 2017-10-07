#!/usr/bin/env python3

import csv

from util import *


print("""insert into data(region, year, database_url,
         data_retrieval_method, metric, units, value, notes) values""")


with open("horizontal-file_02-2010-percapita-gdp.csv", newline='') as f:
    reader = csv.DictReader(f)
    first = True

    for row in reader:
        for year in sorted(row):
            if year != "Region" and year and row[year].strip():
                print("    " + ("" if first else ",") + "(" + ",".join([
                    mysql_quote(row["Region"]),  # region
                    mysql_number(year),  # year
                    mysql_quote("http://www.ggdc.net/maddison/Historical_Statistics/horizontal-file_02-2010.xls"),  # database_url
                    mysql_quote(""),  # data_retrieval_method
                    mysql_quote("GDP per capita"),  # metric
                    mysql_quote("1990 international Geary–Khamis dollars"),  # units
                    mysql_number(row[year]),  # value
                    mysql_quote(""),  # notes
                ]) + ")")
                first = False
    print(";")
