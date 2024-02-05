CREATE TABLE jwt_auth_challenges(
  `challenge` VARCHAR(255) NOT NULL,
  `expiration` DATETIME,
  `apps` 	TEXT,
  CONSTRAINT PK_challenge_apps_key PRIMARY KEY (challenge,apps)
);
