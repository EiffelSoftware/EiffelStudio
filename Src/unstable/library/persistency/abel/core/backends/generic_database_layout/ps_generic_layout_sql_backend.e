note
	description: "Stores objects in a SQL database using a generic database layout."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

class
	PS_GENERIC_LAYOUT_SQL_BACKEND

inherit

	PS_GENERIC_LAYOUT_SQL_READONLY_BACKEND

	PS_REPOSITORY_CONNECTOR

create
	make

feature {PS_ABEL_EXPORT} -- Primary key generation

	generate_all_object_primaries (order: HASH_TABLE [INTEGER, PS_TYPE_METADATA]; transaction: PS_INTERNAL_TRANSACTION): HASH_TABLE [LIST [PS_BACKEND_OBJECT], PS_TYPE_METADATA]
			-- <Precursor>
		local
			connection: PS_SQL_CONNECTION
			new_primary_key: INTEGER
			none_class_key: INTEGER
			existence_attribute_key: INTEGER
			current_list: ARRAYED_LIST [PS_BACKEND_OBJECT]
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
					create current_list.make (cursor.item)
					Result.extend (current_list, cursor.key)
				loop
						-- Generate a new primary key in the database by inserting the "existence"
						-- attribute with the objects object_identifier as a temporary value
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

	generate_collection_primaries (order: HASH_TABLE [INTEGER, PS_TYPE_METADATA]; transaction: PS_INTERNAL_TRANSACTION): HASH_TABLE [LIST [PS_BACKEND_COLLECTION], PS_TYPE_METADATA]
			-- <Precursor>
		local
			connection: PS_SQL_CONNECTION
			new_primary_key: INTEGER
			none_class_key: INTEGER
			current_list: ARRAYED_LIST [PS_BACKEND_COLLECTION]
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
					create current_list.make (cursor.item)
					Result.extend (current_list, cursor.key)
				loop
						-- Generate a new primary key in the database by inserting the "existence"
						-- attribute with the objects object_identifier as a temporary value
					connection.execute_sql (SQL_Strings.insert_new_collection (none_class_key))

					connection.execute_sql (SQL_Strings.query_last_collection_autoincrement)
					new_primary_key := connection.last_result.item.item (1).to_integer

					current_list.extend (create {PS_BACKEND_COLLECTION}.make_fresh (new_primary_key, cursor.key))
				end
			end

		rescue
			rollback (transaction)
		end


feature {PS_ABEL_EXPORT} -- Write operations


	delete (objects: LIST [PS_BACKEND_ENTITY]; transaction: PS_INTERNAL_TRANSACTION)
			-- <Precursor>
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
				-- Conveniently this also removes the last comma.
			stmt.put (')', stmt.count)

			connection.execute_sql (stmt)
		rescue
			rollback (transaction)
		end


	write_collections (collections: LIST [PS_BACKEND_COLLECTION]; transaction: PS_INTERNAL_TRANSACTION)
			-- <Precursor>
		local
			commands: ARRAYED_LIST [STRING]
			info_commands: ARRAYED_LIST [STRING]
			collection_type_key: INTEGER

			delete_command: STRING
			delete_command_list: STRING

			connection: PS_SQL_CONNECTION
			stmt: STRING
		do

			across
				collections as cursor
			from
				delete_command := "DELETE FROM ps_collection WHERE position > 0 AND collectionid IN ("
				create delete_command_list.make_empty

				create commands.make (5 * collections.count)
				create info_commands.make (collections.count)
			loop
					-- Insert all items
				across
					cursor.item as item_cursor
				from
					collection_type_key := db_metadata_manager.create_get_primary_key_of_class (cursor.item.type.name)

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
							-- Store the root status.
						cursor.item.is_root.out]))

						-- Clear database from any previous entry for that collection.
					if not cursor.item.is_update_delta then
						delete_command_list.append (cursor.item.primary_key.out + ",")
					end

				loop
					commands.extend (SQL_Strings.to_list_with_braces ([
							-- Primary key
						cursor.item.primary_key,
							-- Type of the collection
						collection_type_key,
							-- Position of the item
						item_cursor.target_index,
							-- Runtime type
						db_metadata_manager.create_get_primary_key_of_class (cursor.item.item_type (item_cursor.target_index)),
							-- Value
						item_cursor.item
						]))
				end

				across
					cursor.item.meta_information as info
				loop
					info_commands.extend (SQL_Strings.to_list_with_braces ([
							-- Primary key
						cursor.item.primary_key,
							-- Information key
						info.key,
							-- Actual info
						info.item
					]))
				end

			end

				-- Create the final SQL commands from the information gathered previously.
			if not delete_command_list.is_empty then
				delete_command_list.put (')', delete_command_list.count)
				delete_command.append (delete_command_list)
				stmt := delete_command + ";" + SQL_Strings.assemble_multi_replace_collection (commands)
			else
				stmt := SQL_Strings.assemble_multi_replace_collection (commands)
			end

			if not info_commands.is_empty then
				stmt.append (";" + SQL_Strings.assemble_multi_replace_collection_info (info_commands))
			end

			connection := get_connection (transaction)
			connection.execute_sql (stmt)

		rescue
			rollback (transaction)
		end

	delete_collections (collections: LIST [PS_BACKEND_ENTITY]; transaction: PS_INTERNAL_TRANSACTION)
			-- <Precursor>
		local
			connection: PS_SQL_CONNECTION
			stmt: STRING
		do

				-- Delete all items in the collection.
				-- The additional information gets deleted automatically
				-- by an integrity constraint in the database.
			across
				collections as cursor
			from
				connection := get_connection (transaction)
				stmt := "DELETE FROM ps_collection WHERE collectionid IN ("
			loop
				stmt.append (cursor.item.primary_key.out + ",")
			end
				-- Conveniently, this also removes the last comma.
			stmt.put (')', stmt.count)

			connection := get_connection (transaction)
			connection.execute_sql (stmt)
		rescue
			rollback (transaction)
		end

	wipe_out
			-- <Precursor>
		local
			old_plugins: like plugins
		do
			across
				active_connections as cursor
			loop
				cursor.item.commit
				database.release_connection (cursor.item)
				print ("found active transaction")
			end
			active_connections.wipe_out

			management_connection.execute_sql (SQL_Strings.Drop_value_table)
			management_connection.execute_sql (SQL_Strings.Drop_collection_info_table)
			management_connection.execute_sql (SQL_Strings.Drop_collection_table)
			management_connection.execute_sql (SQL_Strings.Drop_attribute_table)
			management_connection.execute_sql (SQL_Strings.Drop_class_table)
			database.release_connection (management_connection)

				-- Re-initialize, but keep the plugins.
			old_plugins := plugins
			make (database, SQL_Strings)
			plugins := old_plugins
		end

feature {PS_REPOSITORY_CONNECTOR} -- Implementation

	internal_write (objects: LIST [PS_BACKEND_OBJECT]; transaction: PS_INTERNAL_TRANSACTION)
			-- <Precursor>
		local
			connection: PS_SQL_CONNECTION
			commands: ARRAYED_LIST [STRING]
		do
			across
				objects as cursor
			from
				create commands.make (objects.count + 1)
			loop
				across
					cursor.item.attributes as attribute_cursor
				from
						-- Insert a default empty attribute to
						-- acknowledge the existence of the object.
					commands.extend (SQL_Strings.to_list_with_braces ([
							-- Primary key
						cursor.item.primary_key,
							-- Attribute key of default attribute ps_existence
						db_metadata_manager.create_get_primary_key_of_attribute (SQL_Strings.Existence_attribute, db_metadata_manager.create_get_primary_key_of_class (cursor.item.type.name)),
							-- Runtime type of ps_existence (NONE)
						db_metadata_manager.create_get_primary_key_of_class (SQL_Strings.None_class),
							-- Store the root status.
						cursor.item.is_root.out]))
				loop
					commands.extend (SQL_Strings.to_list_with_braces ([
							-- Primary key
						cursor.item.primary_key,
							-- Attribute key
						db_metadata_manager.create_get_primary_key_of_attribute (attribute_cursor.item, db_metadata_manager.create_get_primary_key_of_class (cursor.item.type.name)),
							-- Runtime type
						db_metadata_manager.create_get_primary_key_of_class (cursor.item.attribute_value (attribute_cursor.item).type),
							-- Value
						cursor.item.attribute_value (attribute_cursor.item).value
						]))
				end
			end

			connection := get_connection (transaction)
			connection.execute_sql (SQL_Strings.assemble_multi_replace (commands))
		rescue
			rollback (transaction)
		end

end
