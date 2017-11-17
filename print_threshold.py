#!/usr/bin/env python3

years = set()
metrics_urls = set()
data = {}

with open("out.tsv", "r") as f:
    for line in f:
        year, value, metric, url, shortname, boolean = line.split("\t")
        boolean = boolean.strip()
        years.add(year)
        metrics_urls.add((metric, url))
        data[(metric, url, year)] = boolean

print("metric\turl\t" + "\t".join(sorted(years)))
for t in sorted(metrics_urls):
    metric, url = t
    s = "\t".join([data.get((metric, url, year), "NA") for year in sorted(years)])
    print("{}\t{}\t{}".format(metric, url, s))
