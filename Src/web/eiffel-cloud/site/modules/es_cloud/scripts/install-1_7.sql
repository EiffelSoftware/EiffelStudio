CREATE TABLE es_orgs(
  `oid` INTEGER PRIMARY KEY AUTO_INCREMENT NOT NULL,
  `name` 	TEXT NOT NULL,
  `title` 	TEXT,
  `description`	TEXT,
  `data`	TEXT
);

CREATE TABLE es_members(
  `uid` INTEGER NOT NULL,
  `oid`	INTEGER NOT NULL,
  `role` INTEGER,
  CONSTRAINT PK_uid_oid_key PRIMARY KEY (uid,oid)
);

CREATE TABLE es_plans(
  `pid` INTEGER PRIMARY KEY AUTO_INCREMENT NOT NULL,
  `name` 	TEXT NOT NULL,
  `title` 	TEXT NOT NULL,
  `description`	TEXT,
  `data`	TEXT,
  `limitations`	TEXT
);

CREATE TABLE es_plan_subscriptions(
  `pid` INTEGER NOT NULL,
  `uid`	INTEGER NOT NULL,
  `creation` DATETIME NOT NULL,
  `expiration` DATETIME,
  `notes` TEXT,
  CONSTRAINT PK_pid_uid_key PRIMARY KEY (pid,uid)
);

CREATE TABLE es_plan_org_sub(
  `pid` INTEGER NOT NULL,
  `oid`	INTEGER NOT NULL,
  `creation` DATETIME NOT NULL,
  `expiration` DATETIME,
  `notes` TEXT,
  CONSTRAINT PK_pid_oid_key PRIMARY KEY (pid,oid)
);

CREATE TABLE es_installations(
  `iid` VARCHAR(255) NOT NULL ,
  `lid`	INTEGER NOT NULL,
  `name` TEXT,
  `info` TEXT NOT NULL,
  `status` INTEGER NOT NULL,
  `creation` DATETIME NOT NULL,
  CONSTRAINT PK_iid_lid_key PRIMARY KEY (iid,lid)
);

CREATE TABLE es_sessions(
  `sid` VARCHAR(255) PRIMARY KEY NOT NULL ,
  `iid` VARCHAR(255) NOT NULL ,
  `uid`	INTEGER NOT NULL,
  `state` INTEGER NOT NULL,
  `first` DATETIME NOT NULL,
  `last` DATETIME NOT NULL,
  `title` TEXT,
  `data` TEXT
);

CREATE TABLE es_sessions_archive(
  `sid` VARCHAR(255) PRIMARY KEY NOT NULL ,
  `iid` VARCHAR(255) NOT NULL ,
  `uid`	INTEGER NOT NULL,
  `state` INTEGER NOT NULL,
  `first` DATETIME NOT NULL,
  `last` DATETIME NOT NULL,
  `title` TEXT,
  `data` TEXT
);

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

CREATE TABLE es_license_subscriptions (
	`license_key`	TEXT NOT NULL,
	`interval_type`	TEXT NOT NULL,
	`ref`	TEXT,
	`cancel_date`	DATETIME,
	CONSTRAINT PK_license_key PRIMARY KEY(license_key)
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

CREATE TABLE es_redeems(
  `name` 	VARCHAR(256) NOT NULL,
  `plan` 	TEXT NOT NULL, /* plan.name */
  `version`	TEXT,
  `origin`	TEXT, /* seller ? */
  `license`	TEXT, /*license.key */
  `redeem_date`	DATETIME, 
  `notes`	TEXT,
	CONSTRAINT PK_name PRIMARY KEY(name)
);
