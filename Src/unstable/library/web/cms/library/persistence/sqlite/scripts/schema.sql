PRAGMA foreign_keys = OFF;

BEGIN;
CREATE TABLE "users"(
  "uid" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL CHECK("uid">=0),
  "name" VARCHAR(100) NOT NULL,
  "password" VARCHAR(100) NOT NULL,
  "salt" VARCHAR(100) NOT NULL,
  "email" VARCHAR(250) NOT NULL,
  "status" INTEGER,
  "created" DATETIME NOT NULL,
  "signed" DATETIME,
  CONSTRAINT "name"
    UNIQUE("name")
);

CREATE TABLE "users_roles"(
  "rid" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL CHECK("rid">=0),
  "role" VARCHAR(100) NOT NULL,
  CONSTRAINT "role"
    UNIQUE("role")
);

CREATE TABLE "nodes"(
  "nid" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL CHECK("nid">=0),
  "version" INTEGER,
  "type" INTEGER,
  "title" VARCHAR(255) NOT NULL,
  "summary" TEXT NOT NULL,
  "content" MEDIUMTEXT NOT NULL,
  "author" INTEGER,
  "publish" DATETIME,
  "created" DATETIME NOT NULL,
  "changed" DATETIME NOT NULL
);
COMMIT;
