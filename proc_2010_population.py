#!/usr/bin/env python3

import csv

from devec_sql_common import *


print("""insert into data(region, odate, database_url,
         data_retrieval_method, metric, units, value, notes) values""")


with open("horizontal-file_02-2010-population.csv", newline='') as f:
    reader = csv.DictReader(f)
    first = True

    for row in reader:
        for year in sorted(row):
            if year != "Region" and year and (row[year].strip() not in ["", "n.a."]):
                region = row["Region"].strip()
                if region == "Virgin Islands":
                    region = "United States Virgin Islands"
                else:
                    region = region_normalized(region)
                print("    " + ("" if first else ",") + "(" + ",".join([
                    mysql_quote(region),  # region
                    mysql_string_date(year),  # odate
                    mysql_quote("http://www.ggdc.net/maddison/Historical_Statistics/horizontal-file_02-2010.xls"),  # database_url
                    mysql_quote(""),  # data_retrieval_method
                    mysql_quote("Population"),  # metric
                    mysql_quote("People"),  # units
                    mysql_int(row[year], factor=1000),  # value
                    mysql_quote(""),  # notes
                ]) + ")")
                first = False
    print(";")
