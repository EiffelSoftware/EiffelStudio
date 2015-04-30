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

CREATE TABLE "roles"(
  "rid" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL CHECK("rid">=0),
  "name" VARCHAR(100) NOT NULL,
  CONSTRAINT "name"
    UNIQUE("name")
);

CREATE TABLE "users_roles"(
  "uid" INTEGER NOT NULL CHECK("uid">=0),
  "rid" INTEGER NOT NULL CHECK("rid">=0)
);

CREATE TABLE "role_permissions"(
  "rid" INTEGER NOT NULL CHECK("rid">=0),
  "permission" VARCHAR(255) NOT NULL,
  "module" VARCHAR(255)
);

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

COMMIT;
