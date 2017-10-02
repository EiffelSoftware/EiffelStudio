
CREATE TABLE nodes (
	`nid`	INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT UNIQUE,
	`revision`	INTEGER,
	`type`	TEXT NOT NULL,
	`title`	VARCHAR(255) NOT NULL,
	`summary`	TEXT,
	`content`	TEXT,
	`format`	VARCHAR(128),
	`author`	INTEGER,
	`editor`	INTEGER,
	`publish`	DATETIME,
	`created`	DATETIME NOT NULL,
	`changed`	DATETIME NOT NULL,
	`status`	INTEGER,
	CONSTRAINT Unique_nid_revision UNIQUE (nid,revision)
);

CREATE TABLE node_revisions (
	`nid`	INTEGER NOT NULL,
	`revision`	INTEGER NOT NULL,
	`title`	VARCHAR(255) NOT NULL,
	`summary`	TEXT,
	`content`	TEXT,
	`format`	VARCHAR(128),
	`author`	INTEGER,
	`editor`	INTEGER,
	`changed`	DATETIME NOT NULL,
	`status`	INTEGER,
	CONSTRAINT Unique_nid_revision PRIMARY KEY (nid,revision)
);

