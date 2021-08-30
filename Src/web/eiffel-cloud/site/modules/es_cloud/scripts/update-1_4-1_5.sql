/* Addition */

CREATE TABLE es_redeems(
  `name` 	TEXT NOT NULL,
  `plan` 	TEXT NOT NULL, /* plan.name */
  `version`	TEXT,
  `origin`	TEXT, /* seller ? */
  `license`	TEXT, /*license.key */
  `redeem_date`	DATETIME, 
  `notes`	TEXT,
	CONSTRAINT PK_name PRIMARY KEY(name)
);
