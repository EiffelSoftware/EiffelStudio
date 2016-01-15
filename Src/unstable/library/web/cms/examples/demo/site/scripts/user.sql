
CREATE TABLE `users`(
  `uid` INTEGER PRIMARY KEY AUTO_INCREMENT NOT NULL,
  `name` VARCHAR(100) NOT NULL,
  `password` VARCHAR(100) NOT NULL,
  `salt` VARCHAR(100) NOT NULL,
  `email` VARCHAR(250) NOT NULL,
  `status` INTEGER,
  `created` DATETIME NOT NULL,
  `signed` DATETIME,
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




