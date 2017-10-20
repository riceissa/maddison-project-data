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
    shortname varchar(100)
) ENGINE=InnoDB AUTO_INCREMENT=15239276 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

insert into datasets(name, url, data_processing_url, version, release_date, release_date_precision, attribution, shortname) values
    ('Maddison Project','http://www.ggdc.net/maddison/maddison-project/data/mpd_2013-01.xlsx','https://github.com/riceissa/maddison-project-data','2013','2013-01-01','month','The Maddison-Project, http://www.ggdc.net/maddison/maddison-project/home.htm, 2013 version.','maddison2013')
    ,('Angus Maddison','http://www.ggdc.net/maddison/Historical_Statistics/horizontal-file_02-2010.xls','https://github.com/riceissa/maddison-project-data','2010','2010-02-01','month','Statistics on World Population, GDP and Per Capita GDP, 1-2008 AD (Horizontal file, copyright Angus Maddison, university of Groningen)','maddison2010')
    ,('Penn World Table','http://www.rug.nl/ggdc/docs/pwt90.xlsx','https://github.com/riceissa/penn-world-table-data','9.0','2016-06-09','day','Feenstra, Robert C., Robert Inklaar and Marcel P. Timmer (2015), "The Next Generation of the Penn World Table" American Economic Review, 105(10), 3150-3182, available for download at www.ggdc.net/pwt','pwt90')
    ,('Penn World Table','http://www.rug.nl/ggdc/docs/pwt81.xlsx','https://github.com/riceissa/penn-world-table-data','8.1','2015-04-13','day','Feenstra, Robert C., Robert Inklaar and Marcel P. Timmer (2015), "The Next Generation of the Penn World Table" American Economic Review, 105(10), 3150-3182, available for download at www.ggdc.net/pwt','pwt81')
    ,('Penn World Table','http://www.rug.nl/ggdc/docs/pwt80.xlsx','https://github.com/riceissa/penn-world-table-data','8.1','2013-07-02','day','Feenstra, Robert C., Robert Inklaar and Marcel P. Timmer (2015), "The Next Generation of the Penn World Table" American Economic Review, 105(10), 3150-3182, available for download at www.ggdc.net/pwt','pwt81')
    ,('Penn World Table','http://www.rug.nl/ggdc/docs/pwt71_11302012version.zip','https://github.com/riceissa/penn-world-table-data','7.1','2012-11-03','day','Alan Heston, Robert Summers and Bettina Aten, Penn World Table Version 7.1 Center for International Comparisons of Production, Income and Prices at the University of Pennsylvania, November 2012.','pwt71')
    ,('Penn World Table','http://www.rug.nl/ggdc/docs/pwt70_06032011version.zip','https://github.com/riceissa/penn-world-table-data','7.0',NULL,NULL,'Alan Heston, Robert Summers and Bettina Aten, Penn World Table Version 7.0, Center for International Comparisons of Production, Income and Prices at the University of Pennsylvania, June 2011.','pwt70')
    ,('Penn World Table','','https://github.com/riceissa/penn-world-table-data','','','','','pwt')
    ,('Penn World Table','','https://github.com/riceissa/penn-world-table-data','','','','','pwt')
    ,('Penn World Table','','https://github.com/riceissa/penn-world-table-data','','','','','pwt')
;
