note
	description: "The SQLite specific SQL statements for the generic layout mapping strategy."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

class
	PS_SQLITE_STRINGS

inherit

	PS_GENERIC_LAYOUT_SQL_STRINGS

feature {PS_METADATA_TABLES_MANAGER} -- Table creation

	Create_value_table: STRING
		do
			Result := "[
									CREATE TABLE ps_value (
									objectid INTEGER, 
									attributeid INTEGER,
									runtimetype INTEGER,
									value VARCHAR(128),
				
									PRIMARY KEY (objectid ASC, attributeid),
									FOREIGN KEY (attributeid) REFERENCES ps_attribute (attributeid) ON DELETE CASCADE,
									FOREIGN KEY (runtimetype) REFERENCES ps_class (classid) ON DELETE CASCADE
									)
			]"
		end

	Create_class_table: STRING
		do
			Result := "[
				
								CREATE TABLE ps_class (
									classid INTEGER PRIMARY KEY AUTOINCREMENT,
									classname VARCHAR(64)
								)
			]"
		end

	Create_attribute_table: STRING
		do
			Result := "[
								CREATE TABLE ps_attribute (
									attributeid INTEGER PRIMARY KEY AUTOINCREMENT,
									name VARCHAR(128),
									class INTEGER,
				
									FOREIGN KEY (class) REFERENCES ps_class (classid) ON DELETE CASCADE
								)
			]"
		end


feature {PS_METADATA_TABLES_MANAGER} -- Data querying - Key manager

	Show_tables: STRING = "SELECT name FROM sqlite_master WHERE type = 'table'"

feature {PS_METADATA_TABLES_MANAGER} -- Data modification - Key manager

	Insert_class_use_autoincrement (class_name: STRING): STRING
		do
			Result := "INSERT INTO ps_class ( classname) VALUES ( '" + class_name + "')"
		end

	Insert_attribute_use_autoincrement (attribute_name: STRING; class_key: INTEGER): STRING
		do
			Result := "INSERT INTO ps_attribute (attributeid, name, class) VALUES (NULL, '" + attribute_name + "', " + class_key.out + ")"
		end

feature {PS_GENERIC_LAYOUT_SQL_BACKEND} -- Data modification - Backend

	Insert_value_use_autoincrement (attribute_id, runtimetype: INTEGER; value: STRING): STRING
		do
			Result := "INSERT INTO ps_value (objectid, attributeid, runtimetype, value) VALUES ( (SELECT CASE WHEN MAX(objectid) IS NULL THEN 1 ELSE (MAX(objectid) + 1) END FROM ps_value) ," + attribute_id.out + ", " + runtimetype.out + ", '" + value + "')"
		end

	Assemble_multi_replace (tuples: LIST[STRING]): STRING
		do
			across
				tuples as cursor
			from
				create Result.make_empty
			loop
				Result.append ("REPLACE INTO ps_value VALUES " + cursor.item + ";")
			end
		end

feature {PS_GENERIC_LAYOUT_SQL_READONLY_BACKEND} -- Data querying - Backend

	For_update_appendix: STRING = ""

	Query_last_object_autoincrement: STRING = "SELECT objectid FROM ps_value WHERE rowid = last_insert_rowid()"

end
