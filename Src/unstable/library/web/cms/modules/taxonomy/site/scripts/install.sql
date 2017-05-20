
CREATE TABLE taxonomy_term (
  `tid`	INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT UNIQUE,
  `text` VARCHAR(255) NOT NULL,
  `weight` INTEGER,
  `description` TEXT,  
  `langcode` VARCHAR(12)
);

CREATE TABLE taxonomy_hierarchy (
  `tid`	INTEGER NOT NULL,
  `parent` INTEGER,
  CONSTRAINT PK_tid_parent PRIMARY KEY (tid,parent)
);

/* Associate tid with unique (type,entity)
 * for instance: "page" + "$nid" -> "tid"
 */
CREATE TABLE taxonomy_index (
  `tid`	INTEGER NOT NULL,
  `entity`	VARCHAR(255),
  `type` VARCHAR(255) NOT NULL,
  CONSTRAINT PK_tid_entity_type PRIMARY KEY (tid,entity,type)
);
