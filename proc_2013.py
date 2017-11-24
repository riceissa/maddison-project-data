#!/usr/bin/env python3

import csv

from devec_sql_common import *


print("""insert into data(region, odate, database_url,
         data_retrieval_method, metric, units, value, notes) values""")


with open("mpd_2013-01.csv", newline='') as f:
    reader = csv.DictReader(f)
    first = True

    for row in reader:
        for region in sorted(row):
            r = region.strip()
            if r != "Year" and r and row[region]:
                if r == "Virgin Islands":
                    r = "United States Virgin Islands"
                else:
                    r = region_normalized(r)
                print("    " + ("" if first else ",") + "(" + ",".join([
                    mysql_quote(r),  # region
                    mysql_string_date(row["Year"]),  # odate
                    mysql_quote("http://www.ggdc.net/maddison/maddison-project/data/mpd_2013-01.xlsx"),  # database_url
                    mysql_quote(""),  # data_retrieval_method
                    mysql_quote("GDP per capita"),  # metric
                    mysql_quote("1990 international dollar"),  # units
                    mysql_float(row[region]),  # value
                    mysql_quote(""),  # notes
                ]) + ")")
                first = False
    print(";")
