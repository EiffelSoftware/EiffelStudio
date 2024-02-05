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
