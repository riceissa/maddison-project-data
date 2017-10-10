.PHONY: all
all: maddison-2010-gdp.sql maddison-2010-gdp-growth.sql maddison-2010-percapita-gdp.sql maddison-2010-percapita-gdp-growth.sql maddison-2010-population.sql maddison-2010-population-growth.sql maddison-2013.sql

.PHONY: read
read:
	mysql devecondata < maddison-2010-gdp.sql
	mysql devecondata < maddison-2010-gdp-growth.sql
	mysql devecondata < maddison-2010-percapita-gdp.sql
	mysql devecondata < maddison-2010-percapita-gdp-growth.sql
	mysql devecondata < maddison-2010-population.sql
	mysql devecondata < maddison-2010-population-growth.sql
	mysql devecondata < maddison-2013.sql

maddison-2010-gdp.sql:
	./proc_2010_gdp.py > maddison-2010-gdp.sql

maddison-2010-gdp-growth.sql:
	./proc_2010_gdp_growth.py > maddison-2010-gdp-growth.sql

maddison-2010-percapita-gdp.sql:
	./proc_2010_percapita_gdp.py > maddison-2010-percapita-gdp.sql

maddison-2010-percapita-gdp-growth.sql:
	./proc_2010_percapita_gdp_growth.py > maddison-2010-percapita-gdp-growth.sql

maddison-2010-population.sql:
	./proc_2010_population.py > maddison-2010-population.sql

maddison-2010-population-growth.sql:
	./proc_2010_population_growth.py > maddison-2010-population-growth.sql

maddison-2013.sql:
	./proc_2013.py > maddison-2013.sql

.PHONY: clean
clean:
	rm -f maddison-2010-gdp.sql maddison-2010-gdp-growth.sql maddison-2010-percapita-gdp.sql maddison-2010-percapita-gdp-growth.sql maddison-2010-population.sql maddison-2010-population-growth.sql maddison-2013.sql
