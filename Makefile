.PHONY: all
all: maddison-2010-gdp.sql maddison-2010-gdp-growth.sql maddison-2010-percapita-gdp.sql maddison-2010-percapita-gdp-growth.sql maddison-2010-population.sql maddison-2010-population-growth.sql maddison-2013.sql

.PHONY: test
test:
	./proc_2013.py > out.sql
	mysql devecondata -e "drop table if exists maddison"
	mysql devecondata < schema.sql
	mysql devecondata < out.sql

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
