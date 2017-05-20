
CREATE TABLE page_nodes(
	`nid` INTEGER NOT NULL,
	`revision` INTEGER NOT NULL,
	`parent` INTEGER,
	CONSTRAINT PK_nid_revision PRIMARY KEY (nid,revision)
);

