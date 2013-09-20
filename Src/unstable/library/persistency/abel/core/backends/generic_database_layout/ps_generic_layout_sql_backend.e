note
	description: "Stores objects in a SQL database using a generic database layout."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

class
	PS_GENERIC_LAYOUT_SQL_BACKEND

inherit

	PS_BACKEND

create
	make

feature {PS_EIFFELSTORE_EXPORT} -- Supported collection operations

	supports_object_collection: BOOLEAN = False
			-- Can the current backend handle relational collections?

	supports_relational_collection: BOOLEAN = False
			-- Can the current backend handle relational collections?

feature {PS_EIFFELSTORE_EXPORT} -- Status report

	can_handle_type (type: PS_TYPE_METADATA): BOOLEAN
			-- Can the current backend handle objects of type `type'?
		do
			Result := True
		end

	can_handle_relational_collection (owner_type, collection_item_type: PS_TYPE_METADATA): BOOLEAN
			-- Can the current backend handle the relational collection between the two classes `owner_type' and `collection_type'?
		do
			Result := False
		end

	can_handle_object_oriented_collection (collection_type: PS_TYPE_METADATA): BOOLEAN
			-- Can the current backend handle an object-oriented collection of type `collection_type'?
		do
			Result := False
		end

feature {PS_EIFFELSTORE_EXPORT} -- Object retrieval operations

	retrieve (type: PS_TYPE_METADATA; criteria: PS_CRITERION; attributes: LIST [STRING]; transaction: PS_TRANSACTION): ITERATION_CURSOR [PS_RETRIEVED_OBJECT]
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
				create current_obj.make (row_cursor.item.at (SQL_Strings.Value_table_id_column).to_integer, type.base_class)
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

	retrieve_from_keys (type: PS_TYPE_METADATA; primary_keys: LIST [INTEGER]; transaction: PS_TRANSACTION): LINKED_LIST [PS_RETRIEVED_OBJECT]
			-- Retrieve all objects of type `type' and with primary key in `primary_keys'.
		local
			all_items: ITERATION_CURSOR [PS_RETRIEVED_OBJECT]
		do
			create Result.make
				-- Cheating a little ;-)
			all_items := retrieve (type, create {PS_EMPTY_CRITERION}, create {LINKED_LIST [STRING]}.make, transaction)
			from
			until
				all_items.after
			loop
				if primary_keys.has (all_items.item.primary_key) then
					Result.extend (all_items.item)
				end
				all_items.forth
			end
		end

feature {PS_EIFFELSTORE_EXPORT} -- Object write operations

	insert (an_object: PS_SINGLE_OBJECT_PART; a_transaction: PS_TRANSACTION)
			-- Inserts `an_object' into the database.
		local
			connection: PS_SQL_CONNECTION
			new_primary_key: INTEGER
			none_class_key: INTEGER
			existence_attribute_key: INTEGER
		do
				-- Retrieve some required information
			connection := get_connection (a_transaction)
			none_class_key := db_metadata_manager.create_get_primary_key_of_class (SQL_Strings.None_class)
			existence_attribute_key := db_metadata_manager.create_get_primary_key_of_attribute (SQL_Strings.Existence_attribute, db_metadata_manager.create_get_primary_key_of_class (an_object.object_wrapper.metadata.base_class.name))
				-- Generate a new primary key in the database by inserting the "existence" attribute with the objects object_identifier as a temporary value
			connection.execute_sql (SQL_Strings.Insert_value_use_autoincrement (existence_attribute_key, none_class_key, an_object.object_identifier.out))
			connection.execute_sql (SQL_Strings.Query_new_primary_of_object (existence_attribute_key, an_object.object_identifier.out))
			new_primary_key := connection.last_result.item.item (1).to_integer
				-- Insert the primary key to the key manager
			key_mapper.add_entry (an_object.object_wrapper, new_primary_key, a_transaction)
				-- Write all attributes
			write_attributes (an_object, connection, a_transaction)
				-- Delete the object identifier in the existence attribute
			connection.execute_sql (SQL_Strings.Remove_old_object_identifier (existence_attribute_key, an_object.object_identifier.out))
		rescue
			rollback (a_transaction)
		end

	update (an_object: PS_SINGLE_OBJECT_PART; a_transaction: PS_TRANSACTION)
			-- Updates `an_object' in the database.
		local
			connection: PS_SQL_CONNECTION
		do
			connection := get_connection (a_transaction)
			write_attributes (an_object, connection, a_transaction)
		rescue
			rollback (a_transaction)
		end

	delete (an_object: PS_SINGLE_OBJECT_PART; a_transaction: PS_TRANSACTION)
			-- Deletes `an_object' from the database.
		local
			connection: PS_SQL_CONNECTION
			primary: INTEGER
		do
			connection := get_connection (a_transaction)
			primary := key_mapper.primary_key_of (an_object.object_wrapper, a_transaction).first
			key_mapper.remove_primary_key (primary, an_object.object_wrapper.metadata, a_transaction)
			connection.execute_sql (SQL_Strings.Delete_values_of_object (primary))
		rescue
			rollback (a_transaction)
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

	retrieve_object_oriented_collection (collection_type: PS_TYPE_METADATA; collection_primary_key: INTEGER; transaction: PS_TRANSACTION): PS_RETRIEVED_OBJECT_COLLECTION
			-- Retrieves the object-oriented collection of type `collection_type' and with primary key `collection_primary_key'.
		do
			check
				not_implemented: False
			end
			create Result.make (collection_primary_key, collection_type.base_class)
		end

	insert_object_oriented_collection (a_collection: PS_OBJECT_COLLECTION_PART [ITERABLE [detachable ANY]]; a_transaction: PS_TRANSACTION)
			-- Add all entries in `a_collection' to the database. If the order is not conflicting with the items already in the database, it will try to preserve order.
		do
			check
				not_implemented: False
			end
		end

	delete_object_oriented_collection (a_collection: PS_OBJECT_COLLECTION_PART [ITERABLE [detachable ANY]]; a_transaction: PS_TRANSACTION)
			-- Delete `a_collection' from the database.
		do
			check
				not_implemented: False
			end
		end

feature {PS_EIFFELSTORE_EXPORT} -- Relational collection operations

	retrieve_relational_collection (owner_type, collection_item_type: PS_TYPE_METADATA; owner_key: INTEGER; owner_attribute_name: STRING; transaction: PS_TRANSACTION): PS_RETRIEVED_RELATIONAL_COLLECTION
			-- Retrieves the relational collection between class `owner_type' and `collection_item_type', where the owner has primary key `owner_key' and the attribute name of the collection inside the owner object is called `owner_attribute_name'.
		do
			check
				not_implemented: False
			end
			create Result.make (owner_key, owner_type.base_class, owner_attribute_name)
		end

	insert_relational_collection (a_collection: PS_RELATIONAL_COLLECTION_PART [ITERABLE [detachable ANY]]; a_transaction: PS_TRANSACTION)
			-- Add all entries in `a_collection' to the database.
		do
			check
				not_implemented: False
			end
		end

	delete_relational_collection (a_collection: PS_RELATIONAL_COLLECTION_PART [ITERABLE [detachable ANY]]; a_transaction: PS_TRANSACTION)
			-- Delete `a_collection' from the database.
		do
			check
				not_implemented: False
			end
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
			key_mapper.commit (a_transaction)
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
				key_mapper.rollback (a_transaction)
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

feature {PS_EIFFELSTORE_EXPORT} -- Mapping

	key_mapper: PS_KEY_POID_TABLE
			-- Maps POIDs to primary keys as used by this backend.

feature {PS_EIFFELSTORE_EXPORT} -- Testing helpers

	wipe_out_data
			-- Wipe out all object data, but keep the metadata.
		local
			connection: PS_SQL_CONNECTION
		do
			create key_mapper.make
			management_connection.execute_sql (SQL_Strings.Delete_all_values)
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

feature {NONE} -- Implementation

	write_attributes (object: PS_SINGLE_OBJECT_PART; a_connection: PS_SQL_CONNECTION; transaction: PS_TRANSACTION)
			-- Write all attributes of `object'.
		local
			primary: INTEGER
			already_present_attributes: LINKED_LIST [INTEGER]
			runtime_type: INTEGER
			attribute_id: INTEGER
			value: STRING
			referenced_part: PS_OBJECT_GRAPH_PART
			collected_insert_statements: STRING
		do
			primary := key_mapper.primary_key_of (object.object_wrapper, transaction).first
			create already_present_attributes.make
			a_connection.execute_sql (SQL_Strings.Query_present_attributes_of_object (primary))
			across
				a_connection as cursor
			loop
				already_present_attributes.extend (cursor.item.item (1).to_integer)
			end
			collected_insert_statements := ""
			across
				object.attributes as current_attribute
			loop
					-- get the needed information
				referenced_part := object.attribute_value (current_attribute.item)
				value := referenced_part.as_attribute (key_mapper.quick_translate (referenced_part.object_identifier, transaction)).value
				attribute_id := db_metadata_manager.create_get_primary_key_of_attribute (current_attribute.item, db_metadata_manager.create_get_primary_key_of_class (object.object_wrapper.metadata.base_class.name))
					--, a_connection), a_connection)
				runtime_type := db_metadata_manager.create_get_primary_key_of_class (referenced_part.as_attribute (key_mapper.quick_translate (referenced_part.object_identifier, transaction)).type) --, a_connection)
					-- Perform update or insert, depending on the presence in the database
				if already_present_attributes.has (attribute_id) then
						-- Update
					collected_insert_statements.append (" " + SQL_Strings.Update_value (primary, attribute_id, runtime_type, value) + ";")
				else
						-- Insert
					collected_insert_statements.append (" " + SQL_Strings.Insert_value (primary, attribute_id, runtime_type, value) + ";")
				end
			end
			if not collected_insert_statements.is_empty then
				a_connection.execute_sql (collected_insert_statements)
			end
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
			create key_mapper.make
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
