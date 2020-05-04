CREATE TABLE login_with_esa(
  `uid` INTEGER NOT NULL,
  `esa_name` VARCHAR(255) NOT NULL,
  CONSTRAINT PK_uid_esa_name_key PRIMARY KEY (uid,esa_name)
);
