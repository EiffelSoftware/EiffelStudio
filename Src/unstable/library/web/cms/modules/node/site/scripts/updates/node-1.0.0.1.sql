ALTER TABLE nodes ADD editor INTEGER ;
UPDATE nodes SET editor = author;

ALTER TABLE node_revisions ADD editor INTEGER ;
UPDATE node_revisions SET editor = author;


