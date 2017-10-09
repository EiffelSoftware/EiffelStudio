
CREATE TABLE openid_items (
   `uid` INTEGER PRIMARY KEY NOT NULL CHECK(`uid`>=0),
   `identity` TEXT  NOT NULL,
   `created` DATETIME NOT NULL,
   CONSTRAINT `uid`
    UNIQUE(`uid`),
    CONSTRAINT `identity`
    UNIQUE(`identity`)
   );

