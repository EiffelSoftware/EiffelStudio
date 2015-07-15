
CREATE TABLE $table_name (
   `uid` INTEGER PRIMARY KEY NOT NULL CHECK(`uid`>=0),
   `access_token` TEXT  NOT NULL,
   `created` DATETIME NOT NULL,
   `details` TEXT NOT NULL,
   `email` TEXT NOT NULL,
   CONSTRAINT `uid`
    UNIQUE(`uid`),
   CONSTRAINT `email`
    UNIQUE(`email`) 
   );

