note
	description: "The SQLite specific SQL statements for the generic layout mapping strategy."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

class
	PS_SQLITE_STRINGS

inherit

	PS_GENERIC_LAYOUT_SQL_STRINGS

	PS_RELATIONAL_SQL_STRINGS

feature {PS_METADATA_TABLES_MANAGER} -- Table creation

	Create_value_table: STRING
		do
			Result := "[
									CREATE TABLE ps_value (
									objectid INTEGER, 
									attributeid INTEGER,
									runtimetype INTEGER,
									value TEXT,
				
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
									classname VARCHAR (64)
								)
			]"
		end

	Create_attribute_table: STRING
		do
			Result := "[
								CREATE TABLE ps_attribute (
									attributeid INTEGER PRIMARY KEY AUTOINCREMENT,
									name VARCHAR (128),
									class INTEGER,
				
									FOREIGN KEY (class) REFERENCES ps_class (classid) ON DELETE CASCADE
								)
			]"
		end

	Create_collections_table: STRING
		do
			Result := "[
					CREATE TABLE ps_collection (
					collectionid INTEGER NOT NULL, 
					collectiontype INTEGER,
					position INTEGER,
					runtimetype INTEGER,
					value VARCHAR (128),

					PRIMARY KEY (collectionid ASC, position),
					FOREIGN KEY (collectiontype) REFERENCES ps_class (classid) ON DELETE CASCADE,
					FOREIGN KEY (runtimetype) REFERENCES ps_class (classid) ON DELETE CASCADE
					)
				]"
		end

	Create_collection_info_table: STRING
		do
			Result := "[
					CREATE TABLE ps_collection_info (
					collectionid INTEGER NOT NULL,
					info_key VARCHAR (128) NOT NULL,
					info VARCHAR (128),

					PRIMARY KEY (collectionid, info_key),
					FOREIGN KEY (collectionid) REFERENCES ps_collection (collectionid) ON DELETE CASCADE
					)
				]"
		end

	Create_longtext_table: STRING
		do
			Result := "[
				CREATE TABLE ps_longtext (
					textid INTEGER NOT NULL AUTOINCREMENT,
					textvalue LONGTEXT,
					PRIMARY KEY (textid)
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
			Result := "INSERT INTO ps_value (objectid, attributeid, runtimetype, value) VALUES ( (SELECT CASE WHEN MAX (objectid) IS NULL THEN 1 ELSE (MAX (objectid) + 1) END FROM ps_value) ," + attribute_id.out + ", " + runtimetype.out + ", '" + value + "')"
		end

	Insert_new_collection (none_key: INTEGER): STRING
		do
			Result := "INSERT INTO ps_collection (collectionid, collectiontype, position, runtimetype, value) VALUES ( (SELECT CASE WHEN MAX (collectionid) IS NULL THEN 1 ELSE (MAX (collectionid) + 1) END FROM ps_collection),"
				+ none_key.out + ", -1, " + none_key.out + ", '')"
		end

	Assemble_multi_replace (tuples: LIST [STRING]): STRING
		do
			across
				tuples as cursor
			from
				create Result.make_empty
			loop
				Result.append ("REPLACE INTO ps_value VALUES " + cursor.item + ";")
			end
		end

	Assemble_multi_replace_collection (tuples: LIST [STRING]): STRING
		do
			across
				tuples as cursor
			from
				create Result.make_empty
			loop
				Result.append ("REPLACE INTO ps_collection VALUES" + cursor.item + ";")
			end
		end

	Assemble_multi_replace_collection_info (tuples: LIST [STRING]): STRING
		do
			across
				tuples as cursor
			from
				create Result.make_empty
			loop
				Result.append ("REPLACE INTO ps_collection_info VALUES" + cursor.item + ";")
			end
		end

	assemble_upsert (table: READABLE_STRING_8; columns: LIST [STRING]; values: LIST [STRING]): STRING
		do
			create Result.make (100)
			Result.append ("REPLACE INTO ")
			Result.append (table)
			Result.append (" (")

			across
				columns as cursor
			loop
				Result.append (cursor.item)
				if not cursor.is_last then
					Result.append (", ")
				else
					Result.append (") VALUES (")
				end
			end

			across
				values as cursor
			loop
				Result.append (cursor.item)
				if not cursor.is_last then
					Result.append (", ")
				else
					Result.append (");")
				end
			end

		end


feature {PS_GENERIC_LAYOUT_SQL_READONLY_BACKEND} -- Data querying - Backend

	For_update_appendix: STRING = ""

	Query_last_object_autoincrement: STRING = "SELECT objectid FROM ps_value WHERE rowid = last_insert_rowid ()"

	Query_last_collection_autoincrement: STRING = "SELECT collectionid FROM ps_collection WHERE rowid = last_insert_rowid ()"

end
