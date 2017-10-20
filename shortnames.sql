drop table if exists datasets;

create table datasets (
    shortname_id int(11) not null auto_increment primary key,
    name varchar(200),
    url varchar(200),
    data_processing_url varchar(300),
    version varchar(100),
    release_date date,
    release_date_precision enum('day','month','year','multi-year'),
    attribution varchar(1000),
    shortname varchar(100) unique
) ENGINE=InnoDB AUTO_INCREMENT=15239276 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

insert into datasets(name, url, data_processing_url, version, release_date, release_date_precision, attribution, shortname) values
    ('Maddison Project','http://www.ggdc.net/maddison/maddison-project/data/mpd_2013-01.xlsx','https://github.com/riceissa/maddison-project-data','2013','2013-01-01','month','The Maddison-Project, http://www.ggdc.net/maddison/maddison-project/home.htm, 2013 version.','maddison2013')
    ,('Angus Maddison','http://www.ggdc.net/maddison/Historical_Statistics/horizontal-file_02-2010.xls','https://github.com/riceissa/maddison-project-data','2010','2010-02-01','month','Statistics on World Population, GDP and Per Capita GDP, 1-2008 AD (Horizontal file, copyright Angus Maddison, university of Groningen)','maddison2010')
    ,('Penn World Table','http://www.rug.nl/ggdc/docs/pwt90.xlsx','https://github.com/riceissa/penn-world-table-data','9.0','2016-06-09','day','Feenstra, Robert C., Robert Inklaar and Marcel P. Timmer (2015), "The Next Generation of the Penn World Table" American Economic Review, 105(10), 3150-3182, available for download at www.ggdc.net/pwt','pwt90')
    ,('Penn World Table','http://www.rug.nl/ggdc/docs/pwt81.xlsx','https://github.com/riceissa/penn-world-table-data','8.1','2015-04-13','day','Feenstra, Robert C., Robert Inklaar and Marcel P. Timmer (2015), "The Next Generation of the Penn World Table" American Economic Review, 105(10), 3150-3182, available for download at www.ggdc.net/pwt','pwt81')
    ,('Penn World Table','http://www.rug.nl/ggdc/docs/pwt80.xlsx','https://github.com/riceissa/penn-world-table-data','8.0','2013-07-02','day','Feenstra, Robert C., Robert Inklaar and Marcel P. Timmer (2015), "The Next Generation of the Penn World Table" American Economic Review, 105(10), 3150-3182, available for download at www.ggdc.net/pwt','pwt80')
    ,('Penn World Table','http://www.rug.nl/ggdc/docs/pwt71_11302012version.zip','https://github.com/riceissa/penn-world-table-data','7.1','2012-11-03','day','Alan Heston, Robert Summers and Bettina Aten, Penn World Table Version 7.1 Center for International Comparisons of Production, Income and Prices at the University of Pennsylvania, November 2012.','pwt71')
    ,('Penn World Table','http://www.rug.nl/ggdc/docs/pwt70_06032011version.zip','https://github.com/riceissa/penn-world-table-data','7.0',NULL,NULL,'Alan Heston, Robert Summers and Bettina Aten, Penn World Table Version 7.0, Center for International Comparisons of Production, Income and Prices at the University of Pennsylvania, June 2011.','pwt70')
    ,('Penn World Table','http://www.rug.nl/ggdc/docs/pwt63_nov182009version.zip','https://github.com/riceissa/penn-world-table-data','6.3','2009-11-18','day','Alan Heston, Robert Summers and Bettina Aten, Penn World Table Version 6.3, Center for International Comparisons of Production, Income and Prices at the University of Pennsylvania, August 2009.','pwt63')
    ,('Penn World Table','http://www.rug.nl/ggdc/docs/pwt62_data.xlsx','https://github.com/riceissa/penn-world-table-data','6.2','2006-09-01','month','Alan Heston, Robert Summers and Bettina Aten, Penn World Table Version 6.2, Center for International Comparisons of Production, Income and Prices at the University of Pennsylvania, September 2006.','pwt62')
    ,('Penn World Table','http://www.rug.nl/ggdc/docs/pwt61_data.xlsx','https://github.com/riceissa/penn-world-table-data','6.1','2002-10-01','month','Alan Heston, Robert Summers and Bettina Aten, Penn World Table Version 6.1, Center for International Comparisons of Production, Income and Prices at the University of Pennsylvania, October 2002.','pwt61')
    ,('Penn World Table','http://www.rug.nl/ggdc/docs/pwt56_forweb.xls','https://github.com/riceissa/penn-world-table-data','5.6',NULL,NULL,'Alan Heston, Robert Summers and Bettina Aten, Penn World Table, Center for International Comparisons of Production, Income and Prices at the University of Pennsylvania.','pwt56')
    ,('World Development Indicators','https://web.archive.org/web/20171012171000/http://databank.worldbank.org/data/download/WDI_csv.zip','https://github.com/riceissa/world-development-indicators','2017-09-15','2017-09-15','day','World Development Indicators, The World Bank','wdi201709')
    ,('Total Economy Database','https://www.conference-board.org/retrievefile.cfm?filename=TED_1_MAY20171.xlsx&type=subsite','https://github.com/riceissa/total-economy-database','May 2017','2017-05-01','month','The Conference Board Total Economy Database™, May 2017','ted201705ollp')
    ,('Total Economy Database','https://www.conference-board.org/retrievefile.cfm?filename=TED_2_MAY20171.xlsx&type=subsite','https://github.com/riceissa/total-economy-database','May 2017','2017-05-01','month','The Conference Board Total Economy Database™, May 2017','ted201705gatfp')
    ,('Total Economy Database','https://www.conference-board.org/retrievefile.cfm?filename=TED_REGIONS_MAY20171.xlsx&type=subsite','https://github.com/riceissa/total-economy-database','May 2017','2017-05-01','month','The Conference Board Total Economy Database™, May 2017','ted201705ra')
    ,('Total Economy Database','https://www.conference-board.org/retrievefile.cfm?filename=TED_1_NOV20161.xlsx&type=subsite','https://github.com/riceissa/total-economy-database','November 2016','2016-11-01','month','The Conference Board. 2016. The Conference Board Total Economy Database™, November 2016, http://www.conference-board.org/data/economydatabase/','ted201611ollp')
    ,('Total Economy Database','https://www.conference-board.org/retrievefile.cfm?filename=TED_2_NOV20161.xlsx&type=subsite','https://github.com/riceissa/total-economy-database','November 2016','2016-11-01','month','The Conference Board. 2016. The Conference Board Total Economy Database™, November 2016, http://www.conference-board.org/data/economydatabase/','ted201611gatfp')
    ,('Total Economy Database','https://www.conference-board.org/retrievefile.cfm?filename=TED_REGIONS_NOV20161.xlsx&type=subsite','https://github.com/riceissa/total-economy-database','November 2016','2016-11-01','month','The Conference Board. 2016. The Conference Board Total Economy Database™, November 2016, http://www.conference-board.org/data/economydatabase/','ted201611ra')
    ,('Total Economy Database','https://www.conference-board.org/retrievefile.cfm?filename=TED---Output-Labor-and-Labor-Productivity-1950-2016.xlsx&type=subsite','https://github.com/riceissa/total-economy-database','May 2016','2016-05-01','month','The Conference Board. 2016. The Conference Board Total Economy Database™, May 2016, http://www.conference-board.org/data/economydatabase/','ted201605ollp')
    ,('Total Economy Database','https://www.conference-board.org/retrievefile.cfm?filename=TED---Regional-Aggregates-1990-2016.xlsx&type=subsite','https://github.com/riceissa/total-economy-database','May 2016','2016-05-01','month','The Conference Board. 2016. The Conference Board Total Economy Database™, May 2016, http://www.conference-board.org/data/economydatabase/','ted201605ra')
    ,('Total Economy Database','https://www.conference-board.org/retrievefile.cfm?filename=TED_OutputLaborLabor-Productivity1950-2015.xlsx&type=subsite','https://github.com/riceissa/total-economy-database','September 2015','2015-09-01','month','The Conference Board. 2015. The Conference Board Total Economy Database™, September 2015, http://www.conference-board.org/data/economydatabase/','ted201509ollp')
    ,('Total Economy Database','https://www.conference-board.org/retrievefile.cfm?filename=TED_GrowthAccountingTotalFactorProductivity1990-2014.xlsx&type=subsite','https://github.com/riceissa/total-economy-database','September 2015','2015-09-01','month','The Conference Board. 2015. The Conference Board Total Economy Database™, September 2015, http://www.conference-board.org/data/economydatabase/','ted201509gatfp')
    ,('Total Economy Database','https://www.conference-board.org/retrievefile.cfm?filename=TED---Output-Labor-and-Labor-Productivity-1950-2015.xlsx&type=subsite','https://github.com/riceissa/total-economy-database','May 2015','2015-05-01','month','The Conference Board. 2015. The Conference Board Total Economy Database™, May 2015, http://www.conference-board.org/data/economydatabase/','ted201505ollp')
    ,('Total Economy Database','https://www.conference-board.org/retrievefile.cfm?filename=TED---Growth-Accounting-and-Total-Factor-Productivity-1990-2014.xlsx&type=subsite','https://github.com/riceissa/total-economy-database','May 2015','2015-05-01','month','The Conference Board. 2015. The Conference Board Total Economy Database™, May 2015, http://www.conference-board.org/data/economydatabase/','ted201505gatfp')
    ,('Total Economy Database','https://www.conference-board.org/retrievefile.cfm?filename=TED---Regional-Aggregates-1990-2015.xlsx&type=subsite','https://github.com/riceissa/total-economy-database','May 2015','2015-05-01','month','The Conference Board. 2015. The Conference Board Total Economy Database™, May 2015, http://www.conference-board.org/data/economydatabase/','ted201505ra')
    ,('Total Economy Database','https://www.conference-board.org/retrievefile.cfm?filename=Output-Labor-and-Labor-Productivity-1950-2013.xls&type=subsite','https://github.com/riceissa/total-economy-database','January 2014','2014-01-01','month','The Conference Board Total Economy Database™,January 2014, http://www.conference-board.org/data/economydatabase/','ted201401ollp')
    ,('Total Economy Database','https://www.conference-board.org/retrievefile.cfm?filename=Growth-Accounting-and-Total-Factor-Productivity-1990-2013.xls&type=subsite','https://github.com/riceissa/total-economy-database','January 2014','2014-01-01','month','The Conference Board Total Economy Database™,January 2014, http://www.conference-board.org/data/economydatabase/','ted201401gatfp')
    ,('Total Economy Database','https://www.conference-board.org/retrievefile.cfm?filename=Regional-Aggregates-1990-2014.xls&type=subsite','https://github.com/riceissa/total-economy-database','January 2014','2014-01-01','month','The Conference Board Total Economy Database™,January 2014, http://www.conference-board.org/data/economydatabase/','ted201401ra')
    ,('Total Economy Database','https://www.conference-board.org/retrievefile.cfm?filename=Output-Labor-and-Labor-Productivity-1950-2012.xls&type=subsite','https://github.com/riceissa/total-economy-database','January 2013','2013-01-01','month','The Conference Board Total Economy Database™, January 2013, http://www.conference-board.org/data/economydatabase/','ted201301ollp')
    ,('Total Economy Database','https://www.conference-board.org/retrievefile.cfm?filename=Growth-Accounting-and-Total-Factor-Productivity-1990-20121.xls&type=subsite','https://github.com/riceissa/total-economy-database','January 2013','2013-01-01','month','The Conference Board Total Economy Database™, January 2013, http://www.conference-board.org/data/economydatabase/','ted201301gatfp')
    ,('Total Economy Database','https://www.conference-board.org/retrievefile.cfm?filename=Regional-Aggregates-1990-2013.xlsx&type=subsite','https://github.com/riceissa/total-economy-database','January 2013','2013-01-01','month','The Conference Board Total Economy Database™, January 2013, http://www.conference-board.org/data/economydatabase/','ted201301ra')
    ,('Total Economy Database','https://www.conference-board.org/retrievefile.cfm?filename=Output-Labor-and-Labor-Productivity-1950-20111.xls&type=subsite','https://github.com/riceissa/total-economy-database','January 2012','2012-01-01','month','The Conference Board Total Economy Database™, January 2012, http://www.conference-board.org/data/economydatabase/','ted201201ollp')
    ,('Total Economy Database','https://www.conference-board.org/retrievefile.cfm?filename=Growth-Accounting-and-Total-Factor-Productivity-1990-20111.xls&type=subsite','https://github.com/riceissa/total-economy-database','January 2012','2012-01-01','month','The Conference Board Total Economy Database™, January 2012, http://www.conference-board.org/data/economydatabase/','ted201201gatfp')
    ,('Total Economy Database','https://www.conference-board.org/retrievefile.cfm?filename=Regional-Aggregates-1990-2012.xlsx&type=subsite','https://github.com/riceissa/total-economy-database','January 2012','2012-01-01','month','The Conference Board Total Economy Database™, January 2012, http://www.conference-board.org/data/economydatabase/','ted201201ra')

    ,('Total Economy Database','','https://github.com/riceissa/total-economy-database','','','','','ted')
;
