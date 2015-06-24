BEGIN;

CREATE TABLE `logs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `category` VARCHAR(255) NOT NULL,
  `level` int(11) NOT NULL,
  `uid` int(11) DEFAULT NULL,
  `message` text NOT NULL,
  `info` text,
  `link` text,
  `date` datetime NOT NULL,
  PRIMARY KEY (`id`)
);

CREATE TABLE   `custom_values`  (
    `type`   VARCHAR(255) NOT NULL,
    `name`   VARCHAR(255) NOT NULL,
    `value`   VARCHAR(255) NOT NULL
);

CREATE TABLE `path_aliases` (
  `pid` int(11) NOT NULL AUTO_INCREMENT,
  `source` varchar(255) NOT NULL,
  `alias` varchar(255) NOT NULL,
  `lang` varchar(12) DEFAULT NULL,
  PRIMARY KEY (`pid`)
);

COMMIT;

