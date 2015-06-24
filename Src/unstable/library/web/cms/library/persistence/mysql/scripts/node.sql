BEGIN;

CREATE TABLE  nodes (
   nid  INTEGER PRIMARY KEY  AUTO_INCREMENT NOT NULL CHECK( nid >=0),
   revision  INTEGER,
   type  TEXT NOT NULL,
   title  VARCHAR(255) NOT NULL,
   summary  TEXT,
   content  MEDIUMTEXT NOT NULL,
   format  VARCHAR(255),
   author  INTEGER,
   publish  DATETIME,
   created  DATETIME NOT NULL,
   changed  DATETIME NOT NULL,
   status   INTEGER
);

CREATE TABLE page_nodes(
   nid  INTEGER PRIMARY KEY  AUTO_INCREMENT NOT NULL CHECK( nid >=0),
   revision  INTEGER,
   parent  INTEGER
);

COMMIT;
