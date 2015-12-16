
CREATE TABLE session_auth (
   `uid` INTEGER PRIMARY KEY NOT NULL CHECK(`uid`>=0),
   `access_token` TEXT  NOT NULL,
   `created` DATETIME NOT NULL,
   CONSTRAINT `uid`
    UNIQUE(`uid`),
   CONSTRAINT `access_token`
    UNIQUE(`access_token`) 
   );

