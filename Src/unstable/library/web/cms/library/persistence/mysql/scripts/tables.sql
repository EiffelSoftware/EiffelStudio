DROP TABLE IF EXISTS nodes;

CREATE TABLE nodes
(
	id smallint unsigned NOT NULL auto_increment,
	publication_date date NOT NULL,  #When the article was published
	creation_date  date  NOT NULL, #When the article was created
	modification_date  date  NOT NULL, #When the article was updated
	title varchar(255) NOT NULL, #Full title of the article
	summary text NOT NULL, #A short summary of the articule
	content mediumtext NOT NULL,  #The HTML content of the article

	PRIMARY KEY (ID)
);