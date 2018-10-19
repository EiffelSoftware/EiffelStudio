
CREATE TABLE oauth2_consumers(
   `cid` INTEGER PRIMARY KEY AUTO_INCREMENT NOT NULL,
   `name` VARCHAR(255) NOT NULL,
   `api_secret` TEXT  NOT NULL,
   `api_key` TEXT NOT NULL,
   `scope` VARCHAR (100) NOT NULL,
   `protected_resource_url` VARCHAR (255) NOT NULL,
   `callback_name` VARCHAR(255) NOT NULL,
   `extractor` VARCHAR(50) NOT NULL,
   `authorize_url` VARCHAR (255) NOT NULL,
   `endpoint`  VARCHAR (255) NOT NULL,
   CONSTRAINT `cid`
    UNIQUE(`cid`),
   CONSTRAINT `name`
    UNIQUE(`name`)
   );

