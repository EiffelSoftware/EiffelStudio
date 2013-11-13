note
	description: "Stores objects in a SQL database using a generic database layout."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

class
	PS_GENERIC_LAYOUT_SQL_BACKEND

inherit
	PS_GENERIC_LAYOUT_SQL_READONLY_BACKEND
		redefine
			make
		end

	PS_BACKEND_COMPATIBILITY
		rename
			retrieve_object_oriented_collection as retrieve_collection,
			supports_object_collection as is_generic_collection_supported
--		undefine
--			internal_retrieve_by_primary
		end

create
	make

feature {PS_ABEL_EXPORT} -- Supported collection operations

	supports_relational_collection: BOOLEAN = False
			-- Can the current backend handle relational collections?

feature {PS_ABEL_EXPORT} -- Status report

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

	internal_retrieve_from_keys (type: PS_TYPE_METADATA; primary_keys: LIST [INTEGER]; transaction: PS_INTERNAL_TRANSACTION): LINKED_LIST [PS_BACKEND_OBJECT]
			-- Retrieve all objects of type `type' and with primary key in `primary_keys'.
		local
			all_items: ITERATION_CURSOR [PS_BACKEND_OBJECT]
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

feature {PS_ABEL_EXPORT} -- Object write operations

	insert (an_object: PS_SINGLE_OBJECT_PART; a_transaction: PS_INTERNAL_TRANSACTION)
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

	update (an_object: PS_SINGLE_OBJECT_PART; a_transaction: PS_INTERNAL_TRANSACTION)
			-- Updates `an_object' in the database.
		local
			connection: PS_SQL_CONNECTION
		do
			connection := get_connection (a_transaction)
			write_attributes (an_object, connection, a_transaction)
		rescue
			rollback (a_transaction)
		end

	delete (an_object: PS_SINGLE_OBJECT_PART; a_transaction: PS_INTERNAL_TRANSACTION)
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

feature {PS_ABEL_EXPORT} -- Object-oriented collection operations

	insert_object_oriented_collection (a_collection: PS_OBJECT_COLLECTION_PART; a_transaction: PS_INTERNAL_TRANSACTION)
			-- Add all entries in `a_collection' to the database. If the order is not conflicting with the items already in the database, it will try to preserve order.
		do
			check
				not_implemented: False
			end
		end

	delete_object_oriented_collection (a_collection: PS_OBJECT_COLLECTION_PART; a_transaction: PS_INTERNAL_TRANSACTION)
			-- Delete `a_collection' from the database.
		do
			check
				not_implemented: False
			end
		end

feature {PS_ABEL_EXPORT} -- Relational collection operations

	retrieve_relational_collection (owner_type, collection_item_type: PS_TYPE_METADATA; owner_key: INTEGER; owner_attribute_name: STRING; transaction: PS_INTERNAL_TRANSACTION): PS_RETRIEVED_RELATIONAL_COLLECTION
			-- Retrieves the relational collection between class `owner_type' and `collection_item_type', where the owner has primary key `owner_key' and the attribute name of the collection inside the owner object is called `owner_attribute_name'.
		do
			check
				not_implemented: False
			end
			create Result.make (owner_key, owner_type.base_class, owner_attribute_name)
		end

	insert_relational_collection (a_collection: PS_RELATIONAL_COLLECTION_PART; a_transaction: PS_INTERNAL_TRANSACTION)
			-- Add all entries in `a_collection' to the database.
		do
			check
				not_implemented: False
			end
		end

	delete_relational_collection (a_collection: PS_RELATIONAL_COLLECTION_PART; a_transaction: PS_INTERNAL_TRANSACTION)
			-- Delete `a_collection' from the database.
		do
			check
				not_implemented: False
			end
		end

feature {PS_ABEL_EXPORT} -- Mapping

	key_mapper: PS_KEY_POID_TABLE
			-- Maps POIDs to primary keys as used by this backend.

feature {PS_ABEL_EXPORT} -- Testing helpers

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

	write_attributes (object: PS_SINGLE_OBJECT_PART; a_connection: PS_SQL_CONNECTION; transaction: PS_INTERNAL_TRANSACTION)
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


feature {NONE} -- Initialization

	make (a_database: PS_SQL_DATABASE; strings: PS_GENERIC_LAYOUT_SQL_STRINGS)
			-- Initialization for `Current'.
		local
			initialization_connection: PS_SQL_CONNECTION
		do
			create key_mapper.make
			precursor (a_database, strings)
		end

end
