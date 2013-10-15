note
	description: "Summary description for {PS_GENERIC_LAYOUT_SQL_READWRITE_BACKEND}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PS_GENERIC_LAYOUT_SQL_READWRITE_BACKEND

inherit

	PS_GENERIC_LAYOUT_SQL_READONLY_BACKEND

	PS_READ_WRITE_BACKEND

create
	make

feature {PS_EIFFELSTORE_EXPORT} -- Primary key generation

	generate_all_object_primaries (order: HASH_TABLE[INTEGER, PS_TYPE_METADATA]; transaction: PS_TRANSACTION): HASH_TABLE [LIST[PS_RETRIEVED_OBJECT], PS_TYPE_METADATA]
			-- For each type `type_key' in `order', generate `order[type_key]' new objects in the database.
		local
			connection: PS_SQL_CONNECTION
			new_primary_key: INTEGER
			none_class_key: INTEGER
			existence_attribute_key: INTEGER
			current_list: LINKED_LIST[PS_RETRIEVED_OBJECT]
		do
			across
				order as cursor
			from
				create Result.make (order.count)
				connection := get_connection (transaction)
				-- Retrieve some required information
				none_class_key := db_metadata_manager.create_get_primary_key_of_class (SQL_Strings.None_class)
				existence_attribute_key := db_metadata_manager.create_get_primary_key_of_attribute (SQL_Strings.Existence_attribute, db_metadata_manager.create_get_primary_key_of_class (SQL_Strings.none_class))
			loop
				across
					1 |..| cursor.item as current_count
				from
					create current_list.make
					Result.extend (current_list, cursor.key)
				loop
					max_primary := max_primary + 1
					-- Generate a new primary key in the database by inserting the "existence" attribute with the objects object_identifier as a temporary value
					connection.execute_sql (SQL_Strings.Insert_value_use_autoincrement (existence_attribute_key, none_class_key, "''"))
					connection.execute_sql ("SELECT last_insert_id()")
					new_primary_key := connection.last_result.item.item (1).to_integer
--					print (new_primary_key.out + "%N")
					check unique_: across current_list as c all c.item.primary_key /= new_primary_key end end
					current_list.extend (create {PS_RETRIEVED_OBJECT}.make_fresh (new_primary_key, cursor.key))
				end
			end
		rescue
			rollback (transaction)
		end

	max_primary: INTEGER

	generate_collection_primaries (order: HASH_TABLE[INTEGER, PS_TYPE_METADATA]; transaction: PS_TRANSACTION): HASH_TABLE [LIST[PS_RETRIEVED_OBJECT_COLLECTION], PS_TYPE_METADATA]
			-- For each type `type_key' in the hash table `order', generate `order[type_key]' new collections in the database.
		do
			check not_implemented: False end
			create Result.make (10)
		end


feature {PS_EIFFELSTORE_EXPORT} -- Write operations


	delete (objects: LIST[PS_BACKEND_ENTITY]; transaction: PS_TRANSACTION)
		local
			connection: PS_SQL_CONNECTION
			stmt: STRING
		do
			across
				objects as cursor
			from
				connection := get_connection (transaction)
				stmt := "DELETE FROM ps_value WHERE objectid IN ("
			loop
				stmt.append (cursor.item.primary_key.out + ",")

			end
			-- also removes the last comma...
			stmt.put (')', stmt.count)

			connection.execute_sql (stmt)
		rescue
			rollback (transaction)
		end


	write_collections (collections: LIST[PS_RETRIEVED_OBJECT_COLLECTION]; transaction: PS_TRANSACTION)
		do
			check not_implemented: False end
		end

	delete_collections (collections: LIST[PS_BACKEND_ENTITY]; transaction: PS_TRANSACTION)
		do
			check not_implemented: False end
		end

	wipe_out
			-- Wipe out everything and initialize new.
		do
			from
				active_connections.start
			until
				active_connections.after
			loop
				active_connections.item.first.commit
				database.release_connection (active_connections.item.first)
				active_connections.remove
				print ("found active transaction")
			end
			management_connection.execute_sql (SQL_Strings.Drop_value_table)
			management_connection.execute_sql (SQL_Strings.Drop_attribute_table)
			management_connection.execute_sql (SQL_Strings.Drop_class_table)
			database.release_connection (management_connection)
				--			database.close_connections
			make (database, SQL_Strings)
		end

feature {PS_READ_WRITE_BACKEND} -- Implementation

	internal_write (objects: LIST[PS_RETRIEVED_OBJECT]; transaction: PS_TRANSACTION)
			-- Write all `objects' to the database.
			-- Only write the attributes present in {PS_RETRIEVED_OBJECT}.attributes.
		local
			stmt: STRING
			connection: PS_SQL_CONNECTION
		do
			across
				objects as cursor
			from
				stmt := "insert into ps_value values"
				connection := get_connection (transaction)
			loop
				across
					cursor.item.attributes as attribute_cursor
				from
					-- Insert a default empty attribute to acknowledge the existence of the object.
					stmt := stmt + to_string (
						-- Primary key
						cursor.item.primary_key,
						-- Attribute key of default attribute ps_existence
						db_metadata_manager.create_get_primary_key_of_attribute (SQL_Strings.Existence_attribute, db_metadata_manager.create_get_primary_key_of_class (cursor.item.metadata.base_class.name)),
						-- Runtime type of ps_existence (NONE)
						db_metadata_manager.create_get_primary_key_of_class (SQL_Strings.None_class),
						-- A value
						"")

					stmt := stmt + ","
				loop
					stmt := stmt + " " + to_string (
						-- Primary key
						cursor.item.primary_key,
						-- Attribute key
						db_metadata_manager.create_get_primary_key_of_attribute (attribute_cursor.item, db_metadata_manager.create_get_primary_key_of_class (cursor.item.metadata.base_class.name)),
						-- Runtime type
						db_metadata_manager.create_get_primary_key_of_class (cursor.item.attribute_value(attribute_cursor.item).attribute_class_name),
						-- Value
						cursor.item.attribute_value(attribute_cursor.item).value
						)
					stmt := stmt + ","
				end
			end

			-- Remove the last comma.
			stmt.remove_tail (1)

			stmt := stmt + " on duplicate key update runtimetype = VALUES(runtimetype), value = VALUES(value);"

--			print (stmt + "%N")
			connection.execute_sql (stmt)
		rescue
			rollback (transaction)
		end

feature

	to_string (object_id, attribute_id, runtime_type_id: INTEGER; value:STRING): STRING
		do
			Result := "(" + object_id.out + ", " + attribute_id.out + ", " + runtime_type_id.out + ", '" + value + "')"
		end


--feature {NONE} -- Initialization

--	make (a_database: PS_SQL_DATABASE; strings: PS_GENERIC_LAYOUT_SQL_STRINGS)
--			-- Initialization for `Current'.
--		local
--			initialization_connection: PS_SQL_CONNECTION
--		do
--			precursor (a_database, strings)
--		end

end
