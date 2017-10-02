CREATE TABLE jwt_auth(
  `uid` INTEGER NOT NULL,
  `token` 	TEXT NOT NULL,
  `secret` 	TEXT NOT NULL,
  `apps` 	TEXT,
  `refresh`	TEXT NOT NULL,
  CONSTRAINT PK_uid_key PRIMARY KEY (uid,token)
);
