
CREATE TABLE `logs`(
  `id` INTEGER PRIMARY KEY AUTO_INCREMENT NOT NULL,
  `category` VARCHAR(255) NOT NULL,
  `level` INTEGER NOT NULL,
  `uid` INTEGER,
  `message` TEXT NOT NULL,
  `info` TEXT,
  `link` TEXT,
  `date` DATETIME NOT NULL
);

CREATE TABLE `custom_values`(
  `type` VARCHAR(255) NOT NULL,
  `name` VARCHAR(255) NOT NULL,
  `value` TEXT
);

CREATE TABLE `path_aliases`(
  `pid` INTEGER PRIMARY KEY AUTO_INCREMENT NOT NULL,
  `source` VARCHAR(255) NOT NULL,
  `alias` VARCHAR(255) NOT NULL,
  `lang` VARCHAR(12)
);


CREATE TABLE `users`(
  `uid` INTEGER PRIMARY KEY AUTO_INCREMENT NOT NULL,
  `name` VARCHAR(100) NOT NULL,
  `password` VARCHAR(100) NOT NULL,
  `salt` VARCHAR(100) NOT NULL,
  `email` VARCHAR(250) NOT NULL,
  `status` INTEGER,
  `created` DATETIME NOT NULL,
  `signed` DATETIME,
  `profile_name` VARCHAR(250) NULL,
  CONSTRAINT `name`
    UNIQUE(`name`)
);

CREATE TABLE `roles`(
  `rid` INTEGER PRIMARY KEY AUTO_INCREMENT NOT NULL,
  `name` VARCHAR(100) NOT NULL,
  CONSTRAINT `name`
    UNIQUE(`name`)
);

CREATE TABLE `users_roles`(
  `uid` INTEGER NOT NULL CHECK(`uid`>=0),
  `rid` INTEGER NOT NULL CHECK(`rid`>=0)
);

CREATE TABLE `role_permissions`(
  `rid` INTEGER NOT NULL,
  `permission` VARCHAR(255) NOT NULL,
  `module` VARCHAR(255)
);

CREATE TABLE `users_activations` (
  `aid` INTEGER  PRIMARY KEY AUTO_INCREMENT NOT NULL CHECK (`aid` >= 0),
  `token` VARCHAR(255) NOT NULL,
  `uid` INTEGER NOT NULL CHECK (`uid` >= 0),
  `created` DATETIME NOT NULL,
  CONSTRAINT `token` UNIQUE  (`token`)
);

CREATE TABLE `users_password_recovery` (
  `aid` INTEGER  PRIMARY KEY AUTO_INCREMENT NOT NULL CHECK (`aid` >= 0),
  `token` VARCHAR(255) NOT NULL,
  `uid` INTEGER NOT NULL CHECK (`uid` >= 0),
  `created` DATETIME NOT NULL,
  CONSTRAINT `token` UNIQUE  (`token`)
);


CREATE TABLE `auth_temp_users` (
  `uid` INTEGER PRIMARY KEY AUTO_INCREMENT NOT NULL,
  `name` VARCHAR(100) NOT NULL,
  `password` VARCHAR(100) NOT NULL,
  `salt` VARCHAR(100) NOT NULL,
  `email` VARCHAR(250) NOT NULL,
  `application` TEXT NOT NULL, 
  CONSTRAINT `name`
    UNIQUE(`name`)
);

CREATE TABLE `messages` (
  	`mid` TEXT UNIQUE,
  	`date` DATETIME NOT NULL,
	`type`	TEXT NOT NULL,
	`status`	TEXT NOT NULL,
	`user_from`	INTEGER,
	`user_to`	INTEGER,
	`subject`	TEXT,
	`data`	TEXT
);
