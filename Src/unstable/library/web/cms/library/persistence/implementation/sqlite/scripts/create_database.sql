-- Creator:       MySQL Workbench 6.1.7/ExportSQLite plugin 2009.12.02
-- Author:        javier
-- Caption:       New Model
-- Project:       Name of the project
-- Changed:       2014-09-16 23:12
-- Created:       2014-09-16 23:12
PRAGMA foreign_keys = OFF;

-- Schema: cms_dev
BEGIN;
CREATE TABLE "nodes"(
  "id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL CHECK("id">=0),
  "publication_date" DATE NOT NULL,
  "creation_date" DATE NOT NULL,
  "modification_date" DATE NOT NULL,
  "title" VARCHAR(255) NOT NULL,
  "summary" TEXT NOT NULL,
  "content" MEDIUMTEXT NOT NULL
);
CREATE TABLE "roles"(
  "id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL CHECK("id">=0),
  "role" VARCHAR(100) NOT NULL,
  CONSTRAINT "role"
    UNIQUE("role")
);
CREATE TABLE "users"(
  "id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL CHECK("id">=0),
  "username" VARCHAR(100) NOT NULL,
  "password" VARCHAR(100) NOT NULL,
  "salt" VARCHAR(100) NOT NULL,
  "email" VARCHAR(250) NOT NULL,
  CONSTRAINT "username"
    UNIQUE("username")
);
CREATE TABLE "users_nodes"(
  "users_id" INTEGER NOT NULL CHECK("users_id">=0),
  "nodes_id" INTEGER NOT NULL CHECK("nodes_id">=0),
  PRIMARY KEY("users_id","nodes_id"),
  CONSTRAINT "fk_users_has_nodes_nodes1"
    FOREIGN KEY("nodes_id")
    REFERENCES "nodes"("id"),
  CONSTRAINT "fk_users_has_nodes_users"
    FOREIGN KEY("users_id")
    REFERENCES "users"("id")
);
CREATE INDEX "users_nodes.fk_users_has_nodes_nodes1_idx" ON "users_nodes"("nodes_id");
CREATE INDEX "users_nodes.fk_users_has_nodes_users_idx" ON "users_nodes"("users_id");
CREATE TABLE "users_roles"(
  "users_id" INTEGER NOT NULL CHECK("users_id">=0),
  "roles_id" INTEGER NOT NULL CHECK("roles_id">=0),
  PRIMARY KEY("users_id","roles_id"),
  CONSTRAINT "fk_users_has_roles_roles1"
    FOREIGN KEY("roles_id")
    REFERENCES "roles"("id"),
  CONSTRAINT "fk_users_has_roles_users1"
    FOREIGN KEY("users_id")
    REFERENCES "users"("id")
);
CREATE INDEX "users_roles.fk_users_has_roles_roles1_idx" ON "users_roles"("roles_id");
CREATE INDEX "users_roles.fk_users_has_roles_users1_idx" ON "users_roles"("users_id");
COMMIT;
