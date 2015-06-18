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
