CREATE TABLE comments(
  `cid`	INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT UNIQUE,
  `content` TEXT,
  `format` 	VARCHAR(128),
  `author`	INTEGER,
  `author_name`	VARCHAR(255),
  `created`	DATETIME NOT NULL,
  `changed`	DATETIME NOT NULL,
  `status`	INTEGER,
  `parent` INTEGER,
  `entity` 	VARCHAR(255),		/* Associated entity */
  `entity_type`	VARCHAR(255) 	/* Type of associated entity */
);
