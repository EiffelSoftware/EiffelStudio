CREATE TABLE es_plans(
  `pid` INTEGER PRIMARY KEY AUTO_INCREMENT NOT NULL,
  `name` 	TEXT NOT NULL,
  `title` 	TEXT NOT NULL,
  `description`	TEXT,
  `data`	TEXT
);
CREATE TABLE es_plan_subscriptions(
  `pid` INTEGER AUTO_INCREMENT NOT NULL,
  `uid`	INTEGER NOT NULL,
  `creation` DATETIME NOT NULL,
  `expiration` DATETIME,
  `notes` TEXT,
  CONSTRAINT PK_pid_uid_key PRIMARY KEY (pid,uid)
);

CREATE TABLE es_installations(
  `iid` VARCHAR(255) PRIMARY KEY NOT NULL ,
  `uid`	INTEGER NOT NULL,
  `info` TEXT NOT NULL,
  `status` INTEGER NOT NULL,
  `creation` DATETIME NOT NULL,
  `session_begin` DATETIME,
  `session_end` DATETIME,
  `session_state` INTEGER NOT NULL,
  `access` DATETIME
);

CREATE TABLE es_sessions(
  `sid` VARCHAR(255) PRIMARY KEY NOT NULL ,
  `iid` VARCHAR(255) NOT NULL ,
  `uid`	INTEGER NOT NULL,
  `state` INTEGER NOT NULL,
  `first` DATETIME NOT NULL,
  `last` DATETIME NOT NULL,
  `title` TEXT
);
