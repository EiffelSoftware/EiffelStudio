BEGIN;

CREATE TABLE `users` (
  `uid` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `password` varchar(100) NOT NULL,
  `salt` varchar(100) NOT NULL,
  `email` varchar(250) NOT NULL,
  `status` int(11)  DEFAULT NULL,
  `created` datetime NOT NULL,
  `signed` datetime DEFAULT NULL,
  CHECK (`uid` >= 0),
  PRIMARY KEY (`uid`),
  UNIQUE KEY `name` (`name`)
);

CREATE TABLE `roles` (
  `rid` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  CHECK (`rid` >= 0),
  PRIMARY KEY (`rid`),
  UNIQUE KEY `name` (`name`)
);


CREATE TABLE `users_roles` (
  `uid` int(11) NOT NULL,
  `rid` int(11) NOT NULL,
  CHECK (`uid` >= 0),
  CHECK (`rid` >= 0)
); 

CREATE TABLE `role_permissions` (
  `rid` int(11) NOT NULL,
  `permission` varchar(255) NOT NULL,
  `module` varchar(255) DEFAULT NULL,
   CHECK (`rid` >= 0)
);


CREATE TABLE `users_activations` (
  `aid` int(11) NOT NULL AUTO_INCREMENT,
  `token` varchar(255) NOT NULL,
  `uid` int(11) NOT NULL,
  `created` datetime NOT NULL,
   CHECK (`aid` >= 0),
   CHECK (`uid` >= 0),
   PRIMARY KEY (`aid`),
   UNIQUE KEY `token` (`token`)
);


CREATE TABLE `users_password_recovery` (
  `aid` int(11) NOT NULL AUTO_INCREMENT,
  `token` varchar(255) NOT NULL,
  `uid` int(11) NOT NULL,
  `created` datetime NOT NULL,
   CHECK (`aid` >= 0),
   CHECK (`uid` >= 0),
   PRIMARY KEY (`aid`),
   UNIQUE KEY `token` (`token`)
);



COMMIT;