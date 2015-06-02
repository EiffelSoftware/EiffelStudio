BEGIN;

CREATE TABLE "nodes" (
	"nid"	INTEGER NOT NULL CHECK("nid" > 0) PRIMARY KEY AUTOINCREMENT UNIQUE,
	"revision"	INTEGER,
	"type"	TEXT NOT NULL,
	"title"	VARCHAR(255) NOT NULL,
	"summary"	TEXT,
	"content"	TEXT,
	"format"	VARCHAR(128),
	"author"	INTEGER,
	"publish"	DATETIME,
	"created"	DATETIME NOT NULL,
	"changed"	DATETIME NOT NULL,
	"status"	INTEGER
);

CREATE TABLE page_nodes(
  "nid" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL CHECK("nid">=0),
  "revision" INTEGER,
  "parent" INTEGER
);

COMMIT;
