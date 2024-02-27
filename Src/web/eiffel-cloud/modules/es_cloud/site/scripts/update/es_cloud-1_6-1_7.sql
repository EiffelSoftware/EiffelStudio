CREATE TABLE es_sessions_archive (
  `sid` VARCHAR(255) PRIMARY KEY NOT NULL ,
  `iid` VARCHAR(255) NOT NULL ,
  `uid`	INTEGER NOT NULL,
  `state` INTEGER NOT NULL,
  `first` DATETIME NOT NULL,
  `last` DATETIME NOT NULL,
  `title` TEXT,
  `data` TEXT
);
