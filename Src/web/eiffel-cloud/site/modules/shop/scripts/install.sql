CREATE TABLE shop_carts(
  `cid` INTEGER PRIMARY KEY AUTO_INCREMENT NOT NULL,
  `uid` INTEGER,
  `name`	TEXT,
  `email` TEXT,
  `security` TEXT,
  `changed` DATETIME,
  `items`	TEXT NOT NULL,
  `data`	TEXT
);

CREATE TABLE shop_orders(
  `oid` INTEGER PRIMARY KEY AUTO_INCREMENT NOT NULL,
  `name` TEXT NOT NULL,
  `uid` INTEGER NOT NULL,
  `email` TEXT,
  `created` DATETIME NOT NULL,
  `data`	TEXT NOT NULL,
  `reference`	TEXT,
  `interval_type`	TEXT,
  `interval_count`	INTEGER
);

