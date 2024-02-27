CREATE TABLE es_license_subscriptions (
	`license_key`	TEXT NOT NULL,
	`interval_type`	TEXT NOT NULL,
	`ref`	TEXT,
	`cancel_date`	DATETIME,
	CONSTRAINT PK_license_key PRIMARY KEY(license_key)
);
