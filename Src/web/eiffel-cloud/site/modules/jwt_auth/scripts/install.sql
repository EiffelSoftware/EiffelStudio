CREATE TABLE jwt_auth(
  `uid` INTEGER NOT NULL,
  `token` VARCHAR(255) NOT NULL,
  `secret` 	TEXT NOT NULL,
  `apps` 	TEXT,
  `refresh`	TEXT NOT NULL,
  CONSTRAINT PK_uid_token_key PRIMARY KEY (uid,token)
);
