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

	generate_all_object_primaries (order: HASH_TABLE[INTEGER, PS_TYPE_METADATA]; transaction: PS_TRANSACTION): HASH_TABLE [LIST[PS_BACKEND_OBJECT], PS_TYPE_METADATA]
			-- For each type `type_key' in `order', generate `order[type_key]' new objects in the database.
		local
			connection: PS_SQL_CONNECTION
			new_primary_key: INTEGER
			none_class_key: INTEGER
			existence_attribute_key: INTEGER
			current_list: LINKED_LIST[PS_BACKEND_OBJECT]
		do
			connection := get_connection (transaction)

			across
				order as cursor
			from
				create Result.make (order.count)
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
					-- Generate a new primary key in the database by inserting the "existence" attribute with the objects object_identifier as a temporary value
					connection.execute_sql (SQL_Strings.Insert_value_use_autoincrement (existence_attribute_key, none_class_key, "''"))
					connection.execute_sql (SQL_Strings.Query_last_object_autoincrement)
					new_primary_key := connection.last_result.item.item (1).to_integer

					check unique_identifier: across current_list as c all c.item.primary_key /= new_primary_key end end

					current_list.extend (create {PS_BACKEND_OBJECT}.make_fresh (new_primary_key, cursor.key))
				end
			end

			-- Cleanup
			connection.execute_sql ("DELETE FROM ps_value WHERE attributeid = " + existence_attribute_key.out)

		rescue
			rollback (transaction)
		end

	generate_collection_primaries (order: HASH_TABLE[INTEGER, PS_TYPE_METADATA]; transaction: PS_TRANSACTION): HASH_TABLE [LIST[PS_BACKEND_COLLECTION], PS_TYPE_METADATA]
			-- For each type `type_key' in the hash table `order', generate `order[type_key]' new collections in the database.
		local
			connection: PS_SQL_CONNECTION
			new_primary_key: INTEGER
			none_class_key: INTEGER
			current_list: LINKED_LIST[PS_BACKEND_COLLECTION]
		do
			connection := get_connection (transaction)

			across
				order as cursor
			from
				create Result.make (order.count)
				-- Retrieve some required information
				none_class_key := db_metadata_manager.create_get_primary_key_of_class (SQL_Strings.None_class)
			loop
				across
					1 |..| cursor.item as current_count
				from
					create current_list.make
					Result.extend (current_list, cursor.key)
				loop
					-- Generate a new primary key in the database by inserting the "existence" attribute with the objects object_identifier as a temporary value
					connection.execute_sql (SQL_Strings.insert_new_collection (none_class_key))

					connection.execute_sql (SQL_Strings.query_last_collection_autoincrement)
					new_primary_key := connection.last_result.item.item (1).to_integer

					current_list.extend (create {PS_BACKEND_COLLECTION}.make_fresh (new_primary_key, cursor.key))
				end
			end

		rescue
			rollback (transaction)
		end


feature {PS_EIFFELSTORE_EXPORT} -- Write operations


	delete (objects: LIST[PS_BACKEND_ENTITY]; transaction: PS_TRANSACTION)
			-- Delete every item in `objects' from the database
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
			-- conveniently this also removes the last comma
			stmt.put (')', stmt.count)

			connection.execute_sql (stmt)
		rescue
			rollback (transaction)
		end


	write_collections (collections: LIST[PS_BACKEND_COLLECTION]; transaction: PS_TRANSACTION)
			-- Write every item in `collections' to the database
		local
			commands: LINKED_LIST[STRING]
			info_commands: LINKED_LIST[STRING]
			collection_type_key: INTEGER

			connection: PS_SQL_CONNECTION
			stmt: STRING
		do
			across
				collections as cursor
			from
				create commands.make
				create info_commands.make
			loop
				-- Insert all items
				across
					cursor.item.collection_items as collection_item
				from
					collection_type_key := db_metadata_manager.create_get_primary_key_of_class (cursor.item.metadata.base_class.name)

					-- Insert a default item at position -1 to acknowledge the existence of the collection.
					commands.extend (SQL_Strings.to_list_with_braces ([
						-- Primary key
						cursor.item.primary_key,
						-- Type of the collection
						collection_type_key,
						-- Position of the item
						-1,
						-- Runtime type of the default item (NONE)
						db_metadata_manager.create_get_primary_key_of_class (SQL_Strings.None_class),
						-- Some dummy value
						""]))

				loop
					commands.extend (SQL_Strings.to_list_with_braces ([
						-- Primary key
						cursor.item.primary_key,
						-- Type of the collection
						collection_type_key,
						-- Position of the item
						collection_item.target_index,
						-- Runtime type
						db_metadata_manager.create_get_primary_key_of_class (collection_item.item.second),
						-- Value
						collection_item.item.first
						]))
				end

				across
					cursor.item.information_descriptions as info_cursor
				loop
					info_commands.extend (SQL_Strings.to_list_with_braces ([
						-- Primary key
						cursor.item.primary_key,
						-- Information key
						info_cursor.item,
						-- Actual info
						cursor.item.get_information (info_cursor.item)
					]))
				end

			end

			stmt := SQL_Strings.assemble_multi_replace_collection(commands)

			if not info_commands.is_empty then
				stmt.append (";" + SQL_Strings.assemble_multi_replace_collection_info (info_commands))
			end

			connection := get_connection (transaction)
			connection.execute_sql (stmt)
--			if not info_commands.is_empty then
--				connection.execute_sql (SQL_Strings.assemble_multi_replace_collection_info (info_commands))
--			end
		rescue
			rollback (transaction)
		end

	delete_collections (collections: LIST[PS_BACKEND_ENTITY]; transaction: PS_TRANSACTION)
			-- Delete every item in `collections' from the database
		local
			connection: PS_SQL_CONNECTION
			stmt: STRING
		do

			-- Delete all items in the collection.
			-- The additional information gets deleted automatically via an integrity constraint.
			across
				collections as cursor
			from
				connection := get_connection (transaction)
				stmt := "DELETE FROM ps_collection WHERE collectionid IN ("
			loop
				stmt.append (cursor.item.primary_key.out + ",")
			end
			-- conveniently this also removes the last comma
			stmt.put (')', stmt.count)

			connection := get_connection (transaction)
			connection.execute_sql (stmt)
		rescue
			rollback (transaction)
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
			management_connection.execute_sql (SQL_Strings.Drop_collection_info_table)
			management_connection.execute_sql (SQL_Strings.Drop_collection_table)
			management_connection.execute_sql (SQL_Strings.Drop_attribute_table)
			management_connection.execute_sql (SQL_Strings.Drop_class_table)
			database.release_connection (management_connection)
				--			database.close_connections
			make (database, SQL_Strings)
		end

feature {PS_READ_WRITE_BACKEND} -- Implementation

	internal_write (objects: LIST[PS_BACKEND_OBJECT]; transaction: PS_TRANSACTION)
			-- Write all `objects' to the database.
			-- Only write the attributes present in {PS_BACKEND_OBJECT}.attributes.
		local
			connection: PS_SQL_CONNECTION
			commands: LINKED_LIST[STRING]
		do
			across
				objects as cursor
			from
				create commands.make
			loop
				across
					cursor.item.attributes as attribute_cursor
				from
					-- Insert a default empty attribute to acknowledge the existence of the object.
					commands.extend (SQL_Strings.to_list_with_braces ([
						-- Primary key
						cursor.item.primary_key,
						-- Attribute key of default attribute ps_existence
						db_metadata_manager.create_get_primary_key_of_attribute (SQL_Strings.Existence_attribute, db_metadata_manager.create_get_primary_key_of_class (cursor.item.metadata.base_class.name)),
						-- Runtime type of ps_existence (NONE)
						db_metadata_manager.create_get_primary_key_of_class (SQL_Strings.None_class),
						-- Do we need a longtext value?
--						0, -- False
						-- Some dummy value
						""]))

				loop
					commands.extend (SQL_Strings.to_list_with_braces ([
						-- Primary key
						cursor.item.primary_key,
						-- Attribute key
						db_metadata_manager.create_get_primary_key_of_attribute (attribute_cursor.item, db_metadata_manager.create_get_primary_key_of_class (cursor.item.metadata.base_class.name)),
						-- Runtime type
						db_metadata_manager.create_get_primary_key_of_class (cursor.item.attribute_value(attribute_cursor.item).attribute_class_name),
						-- Do we need a longtext value?
--						0, -- False
						-- Value
						cursor.item.attribute_value(attribute_cursor.item).value
						]))
				end
			end

			connection := get_connection (transaction)
			connection.execute_sql (SQL_Strings.assemble_multi_replace(commands))
		rescue
			rollback (transaction)
		end

end
