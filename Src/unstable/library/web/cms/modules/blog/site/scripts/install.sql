CREATE TABLE blog_post_nodes(
  `nid` INTEGER NOT NULL CHECK("nid">=0),
  `revision` INTEGER NOT NULL,
  `tags` VARCHAR(255),
  CONSTRAINT PK_nid_revision PRIMARY KEY (nid,revision)
);
