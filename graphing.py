#!/usr/bin/env python3

import mysql.connector
import pandas as pd
import matplotlib.pyplot as plt
import matplotlib
matplotlib.style.use('ggplot')


cnx = mysql.connector.connect(user='issa', database='devecondata')

df = pd.read_sql("select * from data where database_url = 'http://www.ggdc.net/maddison/maddison-project/data/mpd_2013-01.xlsx' or database_url = 'http://www.ggdc.net/maddison/Historical_Statistics/horizontal-file_02-2010.xls'", con=cnx)

gdppc = df[df.metric == 'GDP per capita']
gdppc.pivot(index='year', columns='region', values='value')
gdppc_2010 = gdppc[gdppc.database_url == 'http://www.ggdc.net/maddison/Historical_Statistics/horizontal-file_02-2010.xls'].pivot(index='year', columns='region', values='value')
gdppc_2013 = gdppc[gdppc.database_url == 'http://www.ggdc.net/maddison/maddison-project/data/mpd_2013-01.xlsx'].pivot(index='year', columns='region', values='value')

# Example plot, each line plot is a country/region
gdppc_2013.plot(legend=False, title='Maddison 2013, GDP per capita'); plt.show()

# plot some select countries
np.log(gdppc_2013[['Japan','France','Spain','USA','India','Poland']]).plot(title='Maddison 2013, GDP per capita, log plot')

# compare maddison 2013 and maddison 2010 gdp per capita for Japan post-1990
(gdppc_2013['Japan'] - gdppc_2010['Japan '])[(gdppc_2013['Japan'] - gdppc_2010['Japan ']).index > 1990].plot()
