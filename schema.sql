create table data (
    estimate_id int(11) not null auto_increment primary key,
    region varchar(100),
    # This is the date the observation or calculation is *about*, not the date
    # on which the observation was made or the calculation was done, which
    # could be much later. The "o" stands for "object-level", as this is the
    # timeline on which calculation processes operate (imagine a single
    # object-level timeline with various points outside the timeline pointing
    # at specific points on the timeline and calling out what values are there;
    # of course, in reality the estimation processes take place in the same
    # timeline so could also be thought of as just pointing backwards in time).
    # This prevents the naming collision with MySQL's "date" type. The date is
    # stored as varchar in YYYYMMDD format, which allows for storing dates
    # before year 1000.
    odate varchar(8),
    database_url varchar(200),
    database_version varchar(200) DEFAULT NULL,
    # This gives information about how a value was calculated.
    data_retrieval_method varchar(1000),
    metric varchar(200),
    units varchar(200),
    value float(35,14),
    notes varchar(2000) DEFAULT NULL,
    unique key `params_combination` (`region`,`odate`,`metric`,`units`,`database_url`),
    index `region`(`region`)
) ENGINE=InnoDB AUTO_INCREMENT=15239276 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
