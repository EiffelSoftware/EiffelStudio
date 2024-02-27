CREATE TABLE es_licenses_archive(
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
