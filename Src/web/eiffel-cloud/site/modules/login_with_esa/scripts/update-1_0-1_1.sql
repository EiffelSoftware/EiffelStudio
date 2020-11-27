CREATE TABLE login_with_esa(
	`uid` INTEGER NOT NULL,
	`name` VARCHAR(255) NOT NULL,
	`email` VARCHAR(255),
	CONSTRAINT PK_uid_name_key PRIMARY KEY (uid, name)
);
