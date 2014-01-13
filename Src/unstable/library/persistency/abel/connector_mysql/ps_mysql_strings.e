note
	description: "The MySQL specific SQL statements for the generic layout mapping strategy."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

class
	PS_MYSQL_STRINGS

inherit

	PS_GENERIC_LAYOUT_SQL_STRINGS

	PS_RELATIONAL_SQL_STRINGS

feature {PS_METADATA_TABLES_MANAGER} -- Table creation

	Create_value_table: STRING
		do
			Result := "[
							CREATE TABLE ps_value (
							objectid INTEGER NOT NULL AUTO_INCREMENT, 
							attributeid INTEGER,
							runtimetype INTEGER,
							value LONGTEXT,
		
							PRIMARY KEY (objectid, attributeid),
							FOREIGN KEY (attributeid) REFERENCES ps_attribute (attributeid) ON DELETE CASCADE,
							FOREIGN KEY (runtimetype) REFERENCES ps_class (classid) ON DELETE CASCADE
							)
			]"
		end

	Create_class_table: STRING
		do
			Result := "[
				
								CREATE TABLE ps_class (
									classid INTEGER NOT NULL AUTO_INCREMENT	PRIMARY KEY, 
									classname VARCHAR (64)
								)
			]"
		end

	Create_attribute_table: STRING
		do
			Result := "[
								CREATE TABLE ps_attribute (
									attributeid INTEGER NOT NULL AUTO_INCREMENT	PRIMARY KEY,
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
					collectionid INTEGER NOT NULL AUTO_INCREMENT, 
					collectiontype INTEGER,
					position INTEGER,
					runtimetype INTEGER,
					value VARCHAR (128),

					PRIMARY KEY (collectionid, position),
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
					textid INTEGER NOT NULL AUTO_INCREMENT,
					textvalue LONGTEXT,
					PRIMARY KEY (textid)
				)
				]"
		end

feature {PS_METADATA_TABLES_MANAGER} -- Data querying - Key manager

	Show_tables: STRING
		do
			Result := "SHOW TABLES"
		end

feature {PS_METADATA_TABLES_MANAGER} -- Data modification - Key manager

	Insert_class_use_autoincrement (class_name: STRING): STRING
		do
			Result := "INSERT INTO ps_class (classname) VALUES ('" + class_name + "')"
		end

	Insert_attribute_use_autoincrement (attribute_name: STRING; class_key: INTEGER): STRING
		do
			Result := "INSERT INTO ps_attribute (name, class) VALUES ('" + attribute_name + "', " + class_key.out + ")"
		end

feature {PS_GENERIC_LAYOUT_SQL_BACKEND} -- Data modification - Backend

	Insert_value_use_autoincrement (attribute_id, runtimetype: INTEGER; value: STRING): STRING
		do
			Result := "INSERT INTO ps_value (attributeid, runtimetype, value) VALUES (" + attribute_id.out + ", " + runtimetype.out + ", '" + value + "')"
		end

	Insert_new_collection (none_key: INTEGER): STRING
		do
			Result := "INSERT INTO ps_collection (collectiontype, position, runtimetype, value) VALUES ("
				+ none_key.out + ", -1, " + none_key.out + ", '')"
		end

	Assemble_multi_replace (tuples: LIST [STRING]): STRING
		do
			across
				tuples as cursor
			from
				Result := "INSERT INTO ps_value VALUES"
			loop
				Result.append (" " + cursor.item + ",")
			end

				-- Remove last comma
			Result.remove_tail (1)
			Result.append (" on duplicate key update runtimetype = VALUES (runtimetype), value = VALUES (value);")
		end

	Assemble_multi_replace_collection (tuples: LIST [STRING]): STRING
		do
			across
				tuples as cursor
			from
				Result := "INSERT INTO ps_collection VALUES"
			loop
				Result.append (" " + cursor.item + ",")
			end

				-- Remove last comma
			Result.remove_tail (1)
			Result.append (" on duplicate key update collectiontype = VALUES (collectiontype), runtimetype = VALUES (runtimetype), value = VALUES (value)")

		end

	Assemble_multi_replace_collection_info (tuples: LIST [STRING]): STRING
		do
			across
				tuples as cursor
			from
				Result := "INSERT INTO ps_collection_info VALUES"
			loop
				Result.append (" " + cursor.item + ",")
			end

				-- Remove last comma
			Result.remove_tail (1)

			Result.append (" on duplicate key update info = VALUES (info)")
		end

	assemble_upsert (table: READABLE_STRING_8; columns: LIST [STRING]; values: LIST [STRING]): STRING
		local
			update_list: STRING
		do
			create Result.make (100)
			create update_list.make (100)
			Result.append ("INSERT INTO ")
			Result.append (table)
			Result.append (" (")

			update_list.append (" ON DUPLICATE KEY UPDATE ")

			across
				columns as cursor
			loop
				Result.append (cursor.item)
				update_list.append (cursor.item)
				update_list.append (" = VALUES (")
				update_list.append (cursor.item)
				update_list.append (")")

				if not cursor.is_last then
					Result.append (", ")
					update_list.append (", ")
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
					Result.append (")")
				end
			end

			Result.append (update_list)
		end

feature {PS_GENERIC_LAYOUT_SQL_READONLY_BACKEND} -- Data querying - Backend

	For_update_appendix: STRING = " FOR UPDATE "

	Query_last_object_autoincrement: STRING = "SELECT LAST_INSERT_ID ()"

	Query_last_collection_autoincrement: STRING = "SELECT LAST_INSERT_ID ()"

end
