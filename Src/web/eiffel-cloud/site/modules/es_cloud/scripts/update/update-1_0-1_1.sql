/* ALTER */
ALTER TABLE es_installations RENAME TO es_installations_old;
CREATE TABLE es_installations (
  `iid` VARCHAR(255) PRIMARY KEY NOT NULL ,
  `lid`	INTEGER NOT NULL,
  `name` TEXT,
  `info` TEXT NOT NULL,
  `status` INTEGER NOT NULL,
  `creation` DATETIME NOT NULL
);
/* DROP TABLE es_installations_old; */

/* Addition */

CREATE TABLE es_licenses(
  `lid` INTEGER PRIMARY KEY AUTO_INCREMENT NOT NULL,
  `pid`	INTEGER NOT NULL, /* es_plans.id */
  `license_key` TEXT NOT NULL,
  `platform` TEXT,
  `version` TEXT,
  `status` INTEGER,
  `creation` DATETIME NOT NULL,
  `expiration` DATETIME,
  `fallback` DATETIME
);

CREATE TABLE es_licenses_emails(
  `lid` INTEGER NOT NULL,
  `email`	TEXT NOT NULL
);

CREATE TABLE es_licenses_users(
  `lid` INTEGER NOT NULL,
  `uid`	INTEGER NOT NULL,
  CONSTRAINT PK_lid_uid_key PRIMARY KEY (lid,uid)
);

CREATE TABLE es_licenses_orgs(
  `lid` INTEGER NOT NULL,
  `oid`	INTEGER NOT NULL,
  CONSTRAINT PK_lid_oid_key PRIMARY KEY (lid,oid)
);

