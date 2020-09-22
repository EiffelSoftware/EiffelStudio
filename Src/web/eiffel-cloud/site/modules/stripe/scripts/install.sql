CREATE TABLE stripe_customers (
	`customer`	TEXT NOT NULL,
	`uid`	INTEGER NOT NULL,
	`email`	TEXT NOT NULL
);

CREATE TABLE stripe_payments (
  	`id` INTEGER PRIMARY KEY AUTO_INCREMENT NOT NULL,
	`pi`	TEXT NOT NULL,
	`sub`	TEXT,
	`status`	TEXT NOT NULL,
	`event_date`	DATETIME NOT NULL,
	`data`	TEXT
);
