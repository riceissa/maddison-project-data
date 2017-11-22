#!/usr/bin/env python3

import sys

import util


if __name__ == "__main__":
    for line in sys.stdin:
        region = line.strip()
        print(region + "\t" + util.REGION_MAP.get(region.lower(), ""))
