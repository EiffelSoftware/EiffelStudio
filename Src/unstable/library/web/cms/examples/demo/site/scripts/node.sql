
CREATE TABLE nodes (
	`nid`	INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT UNIQUE,
	`revision`	INTEGER,
	`type`	TEXT NOT NULL,
	`title`	VARCHAR(255) NOT NULL,
	`summary`	TEXT,
	`content`	TEXT,
	`format`	VARCHAR(128),
	`author`	INTEGER,
	`publish`	DATETIME,
	`created`	DATETIME NOT NULL,
	`changed`	DATETIME NOT NULL,
	`status`	INTEGER
);

CREATE TABLE page_nodes(
  `nid` INTEGER PRIMARY KEY AUTO_INCREMENT NOT NULL,
  `revision` INTEGER,
  `parent` INTEGER
);

