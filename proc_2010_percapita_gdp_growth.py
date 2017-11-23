#!/usr/bin/env python3

import csv

from devec_sql_common import *


print("""insert into data(region, odate, database_url,
         data_retrieval_method, metric, units, value, notes) values""")


with open("horizontal-file_02-2010-percapita-gdp-growth.csv", newline='') as f:
    reader = csv.DictReader(f)
    first = True

    for row in reader:
        for year in sorted(row):
            if year != "Region" and year and row[year].strip():
                print("    " + ("" if first else ",") + "(" + ",".join([
                    mysql_quote(region_normalized(row["Region"].strip())),  # region
                    mysql_string_date(year),  # odate
                    mysql_quote("http://www.ggdc.net/maddison/Historical_Statistics/horizontal-file_02-2010.xls"),  # database_url
                    mysql_quote(""),  # data_retrieval_method
                    mysql_quote("Per capita GDP growth"),  # metric
                    mysql_quote("Percent"),  # units
                    mysql_float(row[year]),  # value
                    mysql_quote(""),  # notes
                ]) + ")")
                first = False
    print(";")
