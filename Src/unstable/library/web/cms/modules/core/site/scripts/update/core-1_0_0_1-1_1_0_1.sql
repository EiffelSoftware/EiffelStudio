CREATE TABLE `messages` (
  	`mid` TEXT,
  	`date` DATETIME NOT NULL,
	`msgtype`	TEXT NOT NULL,
	`status`	TEXT NOT NULL,
	`user_from`	INTEGER,
	`user_to`	INTEGER,
	`subject`	TEXT,
	`data`	TEXT
);
