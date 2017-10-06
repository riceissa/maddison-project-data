create table maddison (
    estimate_id int(11) not null auto_increment primary key,
    region varchar(100),
    year int(10),
    database_url varchar(200),
    data_retrieval_method varchar(100),
    metric varchar(100),
    units varchar(100),
    value float(14,2),
    notes varchar(2000) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=15239276 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
