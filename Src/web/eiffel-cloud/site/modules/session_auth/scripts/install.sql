
CREATE TABLE auth_session (
   `uid` INTEGER PRIMARY KEY NOT NULL CHECK(`uid`>=0),
   `access_token` VARCHAR(64)  NOT NULL,
   `created` DATETIME NOT NULL,
   CONSTRAINT `uid` UNIQUE(`uid`),
   CONSTRAINT `access_token` UNIQUE(`access_token`) 
);

