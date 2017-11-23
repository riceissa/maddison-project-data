#!/usr/bin/env python3

import sys

import devec_sql_common


if __name__ == "__main__":
    for line in sys.stdin:
        region = line.strip()
        print(region + "\t" + devec_sql_common.REGION_MAP.get(region.lower(), ""))
