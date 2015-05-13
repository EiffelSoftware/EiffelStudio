BEGIN;


CREATE TABLE "logs"(
  "id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL CHECK("id">=0),
  "category" VARCHAR(255) NOT NULL,
  "level" INTEGER NOT NULL CHECK("level">=1),
  "uid" INTEGER,
  "message" TEXT NOT NULL,
  "info" TEXT,
  "link" TEXT,
  "date" DATETIME NOT NULL
);

CREATE TABLE "custom_values"(
  "type" VARCHAR(255) NOT NULL,
  "name" VARCHAR(255) NOT NULL,
  "value" VARCHAR(255) NOT NULL
);

CREATE TABLE "path_aliases"(
  "pid" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL CHECK("pid">=0),
  "source" VARCHAR(255) NOT NULL,
  "alias" VARCHAR(255) NOT NULL,
  "lang" VARCHAR(12)
);

COMMIT;
