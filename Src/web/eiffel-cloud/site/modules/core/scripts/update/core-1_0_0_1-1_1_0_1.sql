CREATE TABLE `messages` (
  	`mid` TEXT UNIQUE,
  	`date` DATETIME NOT NULL,
	`type`	TEXT NOT NULL,
	`status`	TEXT NOT NULL,
	`user_from`	INTEGER,
	`user_to`	INTEGER,
	`subject`	TEXT,
	`data`	TEXT
);
