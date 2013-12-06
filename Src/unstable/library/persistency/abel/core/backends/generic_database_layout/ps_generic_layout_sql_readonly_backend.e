note
	description: "Retrieves objects from an SQL database using a generic database layout."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

class
	PS_GENERIC_LAYOUT_SQL_READONLY_BACKEND

inherit
	PS_READ_ONLY_BACKEND
		redefine
			close
		end

	PS_BACKEND_CONVERTER
		rename
			internal_specific_retrieve as unnecessary
		end

create
	make

feature {PS_ABEL_EXPORT} -- Lazy loading

	Default_batch_size: INTEGER = -1

feature {PS_ABEL_EXPORT} -- Access

	stored_types: LIST [READABLE_STRING_GENERAL]
			-- The type string for all objects and collections stored in `Current'.
		do
			-- Note to implementors: It is highly recommended to cache the result, and
			-- refresh it during a `retrieve' operation (or not at all if the result
			-- is always stable).
			fixme ("This also returns some basic types which are sometimes just present as attributes of other objects.")
			Result := db_metadata_manager.all_types
		end


feature {PS_ABEL_EXPORT}-- Backend capabilities

	is_generic_collection_supported: BOOLEAN = True
			-- Can the current backend support collections in general,
			-- i.e. is there a default strategy?

feature {PS_ABEL_EXPORT} -- Object retrieval operations



	internal_retrieve (type: PS_TYPE_METADATA; criteria: PS_CRITERION; attributes: PS_IMMUTABLE_STRUCTURE [STRING]; transaction: PS_INTERNAL_TRANSACTION): ITERATION_CURSOR [PS_BACKEND_OBJECT]
			-- Retrieves all objects of type `type' (direct instance - not inherited from) that match the criteria in `criteria' within transaction `transaction'.
			-- If `attributes' is not empty, it will only retrieve the attributes listed there.
			-- If an attribute was `Void' during an insert, or it doesn't exist in the database because of a version mismatch, the attribute value during retrieval will be an empty string and its class name `NONE'.
			-- If `type' has a generic parameter, the retrieve function will return objects of all generic instances of the generating class.
			-- You can find out about the actual generic parameter by comparing the class name associated to a foreign key value.
		do
			Result := create {PS_LAZY_CURSOR}.make (type, criteria, attributes, transaction, Current)
		rescue
			rollback (transaction)
		end

	internal_specific_retrieve (order: LIST [TUPLE [type: PS_TYPE_METADATA; primary_key: INTEGER]]; transaction: PS_INTERNAL_TRANSACTION): READABLE_INDEXABLE [PS_BACKEND_OBJECT]
			-- See function `specific_retrieve'.
			-- Use `internal_specific_retrieve' for contracts and other calls within a backend.
		local
			key_type_lookup: HASH_TABLE [PS_TYPE_METADATA, INTEGER]

			connection: PS_SQL_CONNECTION
			row_cursor: ITERATION_CURSOR [PS_SQL_ROW]
			sql_string: STRING

			primary_key: INTEGER
			attribute_foreign_key: INTEGER
			runtime_type_foreign_key: INTEGER

			attribute_name: STRING
			runtime_type: STRING
			value: STRING

			current_object: PS_BACKEND_OBJECT

			actual_result: HASH_TABLE [PS_BACKEND_OBJECT, INTEGER]
		do
			create key_type_lookup.make (order.count)
			create actual_result.make (order.count)

				-- Build the SQL query
			sql_string := "SELECT * FROM ps_value WHERE objectid IN ("
			sql_string.grow (sql_string.count + 10 * order.count + SQL_Strings.for_update_appendix.count)
			across
				order as order_cursor
			loop
				sql_string.append (order_cursor.item.primary_key.out + ", ")
				key_type_lookup.extend (order_cursor.item.type, order_cursor.item.primary_key)
			end
			sql_string.put (')', sql_string.count - 1)
			if not transaction.is_readonly then
				sql_string.append (SQL_Strings.for_update_appendix)
			end

			from
					-- Execute the result
				connection := get_connection (transaction)
				connection.execute_sql (sql_string)
				row_cursor := connection.last_result
			until
				row_cursor.after
			loop
					-- Build the data. Since the result is allowed to be unordered,
					-- just iterate over the result and create objects or add attributes
					-- however necessary.
				primary_key := row_cursor.item.at (SQL_Strings.value_table_id_column).to_integer

				attribute_foreign_key := row_cursor.item.at (SQL_Strings.value_table_attributeid_column).to_integer
				attribute_name := db_metadata_manager.attribute_name_of_key (attribute_foreign_key)

				value := row_cursor.item.at (SQL_Strings.value_table_value_column)

					-- Check if there is already a (maybe incomplete) object in the result set.
				if attached actual_result [primary_key] as obj then
					current_object := obj
				else
					create current_object.make (primary_key, attach (key_type_lookup [primary_key]))
					actual_result.extend (current_object, primary_key)
				end

				if not attribute_name.is_equal (SQL_Strings.Existence_attribute) then

						-- Add an attribute. For that we also need the runtime type.
					runtime_type_foreign_key := row_cursor.item.at (SQL_Strings.value_table_runtimetype_column).to_integer
					runtime_type := db_metadata_manager.class_name_of_key (runtime_type_foreign_key)

					current_object.add_attribute (attribute_name, value, runtime_type)
				else
						-- We are dealing with the artificial `ps_existence' attribute.
						-- Set the root status if present.
					if value /~ "NULL" then
						current_object.set_is_root (value.to_boolean)
					end
				end
				row_cursor.forth
			end

			Result := actual_result
		end


	internal_retrieve_by_primary (type: PS_TYPE_METADATA; key: INTEGER; attributes: PS_IMMUTABLE_STRUCTURE [STRING]; transaction: PS_INTERNAL_TRANSACTION): detachable PS_BACKEND_OBJECT
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
--					if not attribute_name.is_equal (SQL_Strings.Existence_attribute) then
--						Result.add_attribute (attribute_name, attribute_value, class_name_of_value)
--					end
					if not attribute_name.is_equal (SQL_Strings.Existence_attribute) then
--						if attribute_name /~ Result.root_key then
							Result.add_attribute (attribute_name, attribute_value, class_name_of_value)
--						end
					else
						if attribute_value /~ "NULL" then
							Result.set_is_root (attribute_value.to_boolean)
						end
					end

					row_cursor.forth
				end
			end
		rescue
			rollback (transaction)
		end

feature {PS_ABEL_EXPORT} -- Object-oriented collection operations

	collection_retrieve (collection_type: PS_TYPE_METADATA; transaction: PS_INTERNAL_TRANSACTION): ITERATION_CURSOR [PS_BACKEND_COLLECTION]
			-- Retrieves all collections of type `collection_type'.
		local
			result_list: LINKED_LIST[PS_BACKEND_COLLECTION]
--			current_item: PS_RETRIEVED_OBJECT_COLLECTION

			primary_key: INTEGER
			position: INTEGER
			runtime_type: STRING
			value: STRING

			connection: PS_SQL_CONNECTION
			row_cursor: ITERATION_CURSOR [PS_SQL_ROW]
			sql_string: STRING
			key, info: STRING
		do
			-- Get the collection items
			connection := get_connection (transaction)
			sql_string := "SELECT collectionid, position, runtimetype, value FROM ps_collection WHERE collectiontype = "
				+ db_metadata_manager.primary_key_of_class (collection_type.name).out
				+ " ORDER BY collectionid, position " + SQL_Strings.for_update_appendix
			connection.execute_sql (sql_string)


			row_cursor := connection.last_result

			-- Get all the content
			from
				create result_list.make
			until
				row_cursor.after
			loop
				primary_key := row_cursor.item.at ("collectionid").to_integer
				position:= row_cursor.item.at ("position").to_integer

				if position <= 0 then
					-- new item
					result_list.extend (create {PS_BACKEND_COLLECTION}.make (primary_key, collection_type))
					result_list.last.set_is_root (row_cursor.item.at ("value").to_boolean)
				else
					runtime_type := db_metadata_manager.class_name_of_key (row_cursor.item.at ("runtimetype").to_integer)
					value := row_cursor.item.at ("value")
					result_list.last.add_item (value, runtime_type)
				end
				row_cursor.forth
			end

			-- Get the additional information
			across
				result_list as cursor
			loop
				fixme ("TODO: make this more efficient")

				sql_string := "SELECT info_key, info FROM ps_collection_info WHERE collectionid= "
					+ cursor.item.primary_key.out + SQL_Strings.for_update_appendix
				connection.execute_sql (sql_string)

				from
					row_cursor := connection.last_result
				until
					row_cursor.after
				loop
					key := row_cursor.item.at ("info_key")
					info := row_cursor.item.at ("info")

--					if key /~ cursor.item.root_key then
						cursor.item.add_information (key, info)
--					end

					row_cursor.forth
				end
			end
			Result := result_list.new_cursor
		end

	retrieve_collection (collection_type: PS_TYPE_METADATA; collection_primary_key: INTEGER; transaction: PS_INTERNAL_TRANSACTION): detachable PS_BACKEND_COLLECTION
			-- Retrieves the object-oriented collection of type `collection_type' and with primary key `collection_primary_key'.
		local
			position: INTEGER
			connection: PS_SQL_CONNECTION
			row_cursor: ITERATION_CURSOR [PS_SQL_ROW]
			sql_string: STRING
			value: STRING
			runtime_type: STRING
			key, info: STRING
		do
			-- Get the collection items
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
					position:= row_cursor.item.at ("position").to_integer
					value := row_cursor.item.at (SQL_Strings.Value_table_value_column)
					runtime_type := db_metadata_manager.class_name_of_key (row_cursor.item.at ("runtimetype").to_integer)

					if position > 0 then
						Result.add_item (value, runtime_type)
					else
						Result.set_is_root (value.to_boolean)
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

			-- Get the additional information

			sql_string := "SELECT info_key, info FROM ps_collection_info WHERE collectionid= "
				+ collection_primary_key.out + SQL_Strings.for_update_appendix
			connection.execute_sql (sql_string)

			from
				row_cursor := connection.last_result
			until
				row_cursor.after or not attached Result
			loop
				key := row_cursor.item.at ("info_key")
				info := row_cursor.item.at ("info")

--				if key /~ Result.root_key then
					Result.add_information (key, info)
--				end
				row_cursor.forth
			end


--			connection.commit
--			check
--				not_implemented: False
--			end
		end

feature {PS_ABEL_EXPORT} -- Transaction handling

	commit (a_transaction: PS_INTERNAL_TRANSACTION)
			-- Tries to commit `a_transaction'. As with every other error, a failed commit will result in a new exception and the error will be placed inside `a_transaction'.
		local
			connection: PS_SQL_CONNECTION
		do
			connection := get_connection (a_transaction)
			connection.commit
--			database.release_connection (connection)
			release_connection (a_transaction)
--			key_mapper.commit (a_transaction)
		rescue
			rollback (a_transaction)
		end

	rollback (a_transaction: PS_INTERNAL_TRANSACTION)
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

	close
			-- Close all connections.
		do
			database.close_connections
		end

feature {PS_LAZY_CURSOR} -- Implementation - Connection and Transaction handling

	get_connection (transaction: PS_INTERNAL_TRANSACTION): PS_SQL_CONNECTION
			-- Get the connection associated with `transaction'.
			-- Acquire a new connection if the transaction is new.
		local
			new_connection: PS_PAIR [PS_SQL_CONNECTION, PS_INTERNAL_TRANSACTION]
			the_actual_result_as_detachable_because_of_stupid_void_safety_rule: detachable PS_SQL_CONNECTION
		do
			if transaction.is_readonly then
				fixme ("remove this hack")
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

	release_connection (transaction: PS_INTERNAL_TRANSACTION)
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

	active_connections: LINKED_LIST [PS_PAIR [PS_SQL_CONNECTION, PS_INTERNAL_TRANSACTION]]
			-- These are the normal connections attached to a transaction.
			-- They do not have auto-commit and they are closed once the transaction is finished.
			-- They only write and read the ps_value table.

	management_connection: PS_SQL_CONNECTION
			-- This is a special connection used for management and read-only transactions.
			-- It uses auto-commit, and is always active.
			-- The connection can only read and write tables ps_attribute and ps_class.

feature {PS_LAZY_CURSOR} -- Implementation: Various fields

	database: PS_SQL_DATABASE
			-- The actual database.

	db_metadata_manager: PS_METADATA_TABLES_MANAGER
			-- The manager for the metadata tables.

	SQL_Strings: PS_GENERIC_LAYOUT_SQL_STRINGS
			-- All predefined SQL statements.

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

			batch_retrieval_size := Default_batch_size

			create plugins.make
			plugins.extend (create {PS_AGENT_CRITERION_ELIMINATOR_PLUGIN})

		end

invariant
	valid_batchsize: batch_retrieval_size > 0 or batch_retrieval_size = -1

end
