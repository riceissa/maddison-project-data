#!/usr/bin/env python3

import csv

from util import *


print("""insert into maddison(region, year, database_url,
         data_retrieval_method, metric, units, value, notes) values""")


with open("mpd_2013-01.csv", newline='') as f:
    reader = csv.DictReader(f)
    first = True

    for row in reader:
        for region in sorted(row):
            r = region.strip()
            if r != "Year" and r and row[region]:
                print("    " + ("" if first else ",") + "(" + ",".join([
                    mysql_quote(r),  # region
                    mysql_number(row["Year"]),  # year
                    mysql_quote("http://www.ggdc.net/maddison/maddison-project/data/mpd_2013-01.xlsx"),  # database_url
                    mysql_quote(""),  # data_retrieval_method
                    mysql_quote("GDP per capita"),  # metric
                    mysql_quote("1990 international Geary–Khamis dollars"),  # units
                    mysql_number(row[region]),  # value
                    mysql_quote(""),  # notes
                ]) + ")")
                first = False
    print(";")
