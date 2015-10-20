
CREATE TABLE wish_list_categories(
   `cid` INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT CHECK(`cid`>=0) ,
   `synopsis` VARCHAR(255) NOT NULL,
   `description` TEXT  NOT NULL,
   `is_active`  INTEGER,
   CONSTRAINT `cid`
    UNIQUE(`cid`),
   CONSTRAINT `synopsis`
    UNIQUE(`synopsis`)
   );


CREATE TABLE wish_list_status(
   `sid` INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT CHECK(`sid`>=0) ,
   `synopsis` VARCHAR(255) NOT NULL,
   `description` TEXT  NOT NULL,
   CONSTRAINT `sid`
    UNIQUE(`sid`),
   CONSTRAINT `synopsis`
    UNIQUE(`synopsis`)
   );


CREATE TABLE wish_list_votes(
   `wish` INTEGER, 
   `author` INTEGER,
  CONSTRAINT `votes`
  UNIQUE (`wish`, `author`)
);


CREATE TABLE wish_list(
   `wid` INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT CHECK(`wid`>=0),
   `author` INTEGER,
   `category` INTEGER,
   `status` INTEGER,
   `synopsis` VARCHAR(255) NOT NULL,
   `description` TEXT  NOT NULL,
   `created`  DATETIME NOT NULL,
   `changed`  DATETIME NOT NULL,
   `votes` INTEGER,
   CONSTRAINT `wid`
    UNIQUE(`wid`)
);

CREATE TABLE wish_list_attachments(
   `iid` INTEGER, 
   `wid` INTEGER  NOT NULL CHECK(`wid`>=0),
   `length` INTEGER,
   `content` TEXT,
   `fileName` VARCHAR(255) NOT NULL
);


CREATE TABLE wish_list_interactions(
   `iid` INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT CHECK(`iid`>=0),
   `wid` INTEGER,
   `author` INTEGER,
   `content` TEXT NOT NULL,
   `changed`  DATETIME NOT NULL,
   CONSTRAINT `iid`
    UNIQUE(`iid`)
);


