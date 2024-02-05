CREATE TABLE jwt_auth(
  `uid` INTEGER NOT NULL,
  `token` VARCHAR(255) NOT NULL,
  `secret` 	TEXT NOT NULL,
  `apps` 	TEXT,
  `refresh`	TEXT NOT NULL,
  CONSTRAINT PK_uid_token_key PRIMARY KEY (uid,token)
);

CREATE TABLE jwt_auth_challenges(
  `challenge` VARCHAR(255) NOT NULL,
  `client` VARCHAR(255) NOT NULL,
  `info` 	TEXT,
  `expiration` DATETIME,
  `apps` 	TEXT,
  `status`  INTEGER,
  `uid`	INTEGER,
  CONSTRAINT PK_challenge_apps_key PRIMARY KEY (challenge,apps,client)
);
