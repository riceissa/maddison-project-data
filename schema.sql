create table data (
    estimate_id int(11) not null auto_increment primary key,
    region varchar(100),
    year int(10),
    database_url varchar(200),
    data_retrieval_method varchar(1000),
    metric varchar(200),
    units varchar(100),
    value float(35,14),
    notes varchar(2000) DEFAULT NULL,
    index `region`(`region`)
) ENGINE=InnoDB AUTO_INCREMENT=15239276 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
