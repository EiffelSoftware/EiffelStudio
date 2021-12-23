CREATE TABLE user_profiles(
  `uid` INTEGER NOT NULL CHECK("uid">=0),
  `key` VARCHAR(255) NOT NULL,
  `value` TEXT,
  CONSTRAINT PK_uid_key PRIMARY KEY (`uid`,`key`)
);
