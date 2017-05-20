
CREATE TABLE openid_consumers(
   `cid` INTEGER PRIMARY KEY NOT NULL CHECK(`cid`>=0),
   `name` VARCHAR(255) NOT NULL,
   `endpoint`  VARCHAR (255) NOT NULL,
   CONSTRAINT `cid`
    UNIQUE(`cid`),
   CONSTRAINT `name`
    UNIQUE(`name`)
   );

