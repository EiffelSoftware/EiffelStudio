note
	description: "Summary description for {GENERIC_LAYOUT_SQL_READONLY_BACKEND}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PS_GENERIC_LAYOUT_SQL_READONLY_BACKEND

inherit
	PS_READ_ONLY_BACKEND

create
	make

feature {PS_EIFFELSTORE_EXPORT}-- Backend capabilities

	is_generic_collection_supported: BOOLEAN = True
			-- Can the current backend support collections in general,
			-- i.e. is there a default strategy?

feature {PS_EIFFELSTORE_EXPORT} -- Object retrieval operations

	internal_retrieve (type: PS_TYPE_METADATA; criteria: PS_CRITERION; attributes: PS_IMMUTABLE_STRUCTURE [STRING]; transaction: PS_TRANSACTION): ITERATION_CURSOR [PS_RETRIEVED_OBJECT]
			-- Retrieves all objects of type `type' (direct instance - not inherited from) that match the criteria in `criteria' within transaction `transaction'.
			-- If `attributes' is not empty, it will only retrieve the attributes listed there.
			-- If an attribute was `Void' during an insert, or it doesn't exist in the database because of a version mismatch, the attribute value during retrieval will be an empty string and its class name `NONE'.
			-- If `type' has a generic parameter, the retrieve function will return objects of all generic instances of the generating class.
			-- You can find out about the actual generic parameter by comparing the class name associated to a foreign key value.
		local
			connection: PS_SQL_CONNECTION
			current_obj: PS_RETRIEVED_OBJECT
			result_list: LINKED_LIST [PS_RETRIEVED_OBJECT]
			row_cursor: ITERATION_CURSOR [PS_SQL_ROW]
			sql_string: STRING
			attribute_name, attribute_value, class_name_of_value: STRING
		do
			connection := get_connection (transaction)
			create result_list.make
			sql_string := SQL_Strings.query_values_from_class (SQL_Strings.convert_to_sql (db_metadata_manager.attribute_keys_of_class (db_metadata_manager.create_get_primary_key_of_class (type.base_class.name))))
			if not transaction.is_readonly then
				sql_string.append (SQL_Strings.For_update_appendix)
			end
			connection.execute_sql (sql_string)
			from
				row_cursor := connection.last_result
			until
				row_cursor.after
			loop
					-- create new object
				create current_obj.make (row_cursor.item.at (SQL_Strings.Value_table_id_column).to_integer, type)
					-- fill all attributes - The result is ordered by the object id, therefore the attributes of a single object are grouped together.
				from
				until
					row_cursor.after or else row_cursor.item.at (SQL_Strings.Value_table_id_column).to_integer /= current_obj.primary_key
				loop
						--print (current_obj.class_metadata.name + ": " + db_metadata_manager.attribute_name_of_key (row_cursor.item.get_value ("attributeid").to_integer) + "%N")
					attribute_name := db_metadata_manager.attribute_name_of_key (row_cursor.item.at (SQL_Strings.Value_table_attributeid_column).to_integer)
					attribute_value := row_cursor.item.at (SQL_Strings.Value_table_value_column)
					class_name_of_value := db_metadata_manager.class_name_of_key (row_cursor.item.at (SQL_Strings.Value_table_runtimetype_column).to_integer)
					if not attribute_name.is_equal (SQL_Strings.Existence_attribute) then
						current_obj.add_attribute (attribute_name, attribute_value, class_name_of_value)
					end
					row_cursor.forth
				end
					-- fill in Void attributes
				fixme ("TODO: Remove the following loop as soon as the old backend version gets ditched - it isn't necessary any more")
				across
					type.attributes as attr
				loop
					if not current_obj.has_attribute (attr.item) then
						current_obj.add_attribute (attr.item, "", "NONE")
					end
				end
				result_list.extend (current_obj)
					-- do NOT go forth - we are already pointing to the next item, otherwise the inner loop would not have stopped.
			end
			Result := result_list.new_cursor
		rescue
			rollback (transaction)
		end


	internal_retrieve_by_primary (type: PS_TYPE_METADATA; key: INTEGER; attributes: PS_IMMUTABLE_STRUCTURE [STRING]; transaction: PS_TRANSACTION): detachable PS_RETRIEVED_OBJECT
			-- See function `retrieve_by_primary'.
			-- Use `internal_retrieve_by_primary' for contracts and other calls within a backend.
		local
			connection: PS_SQL_CONNECTION
			row_cursor: ITERATION_CURSOR [PS_SQL_ROW]
			sql_string: STRING
			attribute_name, attribute_value, class_name_of_value: STRING
		do
			connection := get_connection (transaction)
			sql_string := "SELECT * FROM ps_value WHERE objectid = " + key.out + " " + SQL_Strings.for_update_appendix
			connection.execute_sql (sql_string)
			row_cursor := connection.last_result

			if not row_cursor.after then
				from
					create Result.make (row_cursor.item.at (SQL_Strings.Value_table_id_column).to_integer, type)
				until
					row_cursor.after
				loop
					-- fill all attributes - The result is ordered by the object id, therefore the attributes of a single object are grouped together.

					attribute_name := db_metadata_manager.attribute_name_of_key (row_cursor.item.at (SQL_Strings.Value_table_attributeid_column).to_integer)
					attribute_value := row_cursor.item.at (SQL_Strings.Value_table_value_column)
					class_name_of_value := db_metadata_manager.class_name_of_key (row_cursor.item.at (SQL_Strings.Value_table_runtimetype_column).to_integer)
					if not attribute_name.is_equal (SQL_Strings.Existence_attribute) then
						Result.add_attribute (attribute_name, attribute_value, class_name_of_value)
					end
					row_cursor.forth
				end

					-- fill in Void attributes
				fixme ("TODO: Remove the following loop as soon as the old backend version gets ditched - it isn't necessary any more")
				across
					type.attributes as attr
				loop
					if not Result.has_attribute (attr.item) then
						Result.add_attribute (attr.item, "", "NONE")
					end
				end

			end

		rescue
			rollback (transaction)
		end

feature {PS_EIFFELSTORE_EXPORT} -- Object-oriented collection operations

	retrieve_all_collections (collection_type: PS_TYPE_METADATA; transaction: PS_TRANSACTION): ITERATION_CURSOR [PS_RETRIEVED_OBJECT_COLLECTION]
			-- Retrieves all collections of type `collection_type'.
		do
			check
				not_implemented: False
			end
			Result := (create {LINKED_LIST [PS_RETRIEVED_OBJECT_COLLECTION]}.make).new_cursor
		end

	retrieve_collection (collection_type: PS_TYPE_METADATA; collection_primary_key: INTEGER; transaction: PS_TRANSACTION): detachable PS_RETRIEVED_OBJECT_COLLECTION
			-- Retrieves the object-oriented collection of type `collection_type' and with primary key `collection_primary_key'.
		local
			position: INTEGER
			connection: PS_SQL_CONNECTION
			row_cursor: ITERATION_CURSOR [PS_SQL_ROW]
			sql_string: STRING
			value: STRING
			runtime_type: STRING
		do
			connection := get_connection (transaction)
			sql_string := "SELECT position, runtimetype, value FROM ps_collection WHERE collectionid= "
				+ collection_primary_key.out + " ORDER BY position " + SQL_Strings.for_update_appendix
			connection.execute_sql (sql_string)

			row_cursor := connection.last_result

			if not row_cursor.after then
				from
					create Result.make (collection_primary_key, collection_type)
				until
					row_cursor.after
				loop
					-- fill all attributes - The result is ordered by the object id, therefore the attributes of a single object are grouped together.

					position:= row_cursor.item.at ("position").to_integer
					value := row_cursor.item.at (SQL_Strings.Value_table_value_column)
					runtime_type := db_metadata_manager.class_name_of_key (row_cursor.item.at ("runtimetype").to_integer)

					if position > 0 then
						Result.add_item (value, runtime_type)
					end
					row_cursor.forth
				end
			end

--			check attached Result then
--				across
--					Result.collection_items as item
--				from
--					print (Result.primary_key.out + " " + Result.metadata.type.name + "%N")
--				loop
--					print ("%T" + item.item.first + " " + item.item.second + "%N")
--				end
--			end
--			connection.commit
--			check
--				not_implemented: False
--			end
		end

feature {PS_EIFFELSTORE_EXPORT} -- Transaction handling

	commit (a_transaction: PS_TRANSACTION)
			-- Tries to commit `a_transaction'. As with every other error, a failed commit will result in a new exception and the error will be placed inside `a_transaction'.
		local
			connection: PS_SQL_CONNECTION
		do
			connection := get_connection (a_transaction)
			connection.commit
			database.release_connection (connection)
			release_connection (a_transaction)
--			key_mapper.commit (a_transaction)
		rescue
			rollback (a_transaction)
		end

	rollback (a_transaction: PS_TRANSACTION)
			-- Aborts `a_transaction' and undoes all changes in the database.
		local
			connection: PS_SQL_CONNECTION
		do
			if not a_transaction.has_error then -- Avoid a "double rollback"
				connection := get_connection (a_transaction)
				a_transaction.set_error (connection.last_error)
				connection.rollback
				release_connection (a_transaction)
--				key_mapper.rollback (a_transaction)
			end
		end

	transaction_isolation_level: PS_TRANSACTION_ISOLATION_LEVEL
			-- The currently active transaction isolation level.
		do
			Result := database.transaction_isolation_level
		end

	set_transaction_isolation_level (a_level: PS_TRANSACTION_ISOLATION_LEVEL)
			-- Set the transaction isolation level `a_level' for all future transactions.
		do
			database.set_transaction_isolation_level (a_level)
		end

feature {NONE} -- Implementation - Connection and Transaction handling

	get_connection (transaction: PS_TRANSACTION): PS_SQL_CONNECTION
			-- Get the connection associated with `transaction'.
			-- Acquire a new connection if the transaction is new.
		local
			new_connection: PS_PAIR [PS_SQL_CONNECTION, PS_TRANSACTION]
			the_actual_result_as_detachable_because_of_stupid_void_safety_rule: detachable PS_SQL_CONNECTION
		do
			if transaction.is_readonly then
				Result := management_connection
			else
				across
					active_connections as cursor
				loop
					if cursor.item.second.is_equal (transaction) then
						the_actual_result_as_detachable_because_of_stupid_void_safety_rule := cursor.item.first
							--					print ("found existing%N")
					end
				end
				if not attached the_actual_result_as_detachable_because_of_stupid_void_safety_rule then
					the_actual_result_as_detachable_because_of_stupid_void_safety_rule := database.acquire_connection
					create new_connection.make (the_actual_result_as_detachable_because_of_stupid_void_safety_rule, transaction)
					active_connections.extend (new_connection)
						--					print ("created new%N")
				end
				Result := attach (the_actual_result_as_detachable_because_of_stupid_void_safety_rule)
			end
		end

	release_connection (transaction: PS_TRANSACTION)
			-- Release the connection associated with `transaction'.
		do
			from
				active_connections.start
			until
				active_connections.after
			loop
				if active_connections.item.second.is_equal (transaction) then
					database.release_connection (active_connections.item.first)
					active_connections.remove
				else
					active_connections.forth
				end
			end
		end

	active_connections: LINKED_LIST [PS_PAIR [PS_SQL_CONNECTION, PS_TRANSACTION]]
			-- These are the normal connections attached to a transaction.
			-- They do not have auto-commit and they are closed once the transaction is finished.
			-- They only write and read the ps_value table.

	management_connection: PS_SQL_CONNECTION
			-- This is a special connection used for management and read-only transactions.
			-- It uses auto-commit, and is always active.
			-- The connection can only read and write tables ps_attribute and ps_class.

feature {NONE} -- Initialization

	make (a_database: PS_SQL_DATABASE; strings: PS_GENERIC_LAYOUT_SQL_STRINGS)
			-- Initialization for `Current'.
		local
			initialization_connection: PS_SQL_CONNECTION
		do
			SQL_Strings := strings
			database := a_database
			management_connection := database.acquire_connection
			management_connection.set_autocommit (True)
			create db_metadata_manager.make (management_connection, SQL_Strings)
			create active_connections.make
		end

	database: PS_SQL_DATABASE
			-- The actual database.

	db_metadata_manager: PS_METADATA_TABLES_MANAGER
			-- The manager for the metadata tables.

	SQL_Strings: PS_GENERIC_LAYOUT_SQL_STRINGS
			-- All predefined SQL statements.

end
