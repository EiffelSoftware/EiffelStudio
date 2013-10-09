note
	description: "Summary description for {PS_SIMPLE_IN_MEMORY_BACKEND}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PS_SIMPLE_IN_MEMORY_BACKEND

inherit
	PS_BACKEND

create
	wipe_out

feature {PS_EIFFELSTORE_EXPORT} -- Backend capabilities

	is_generic_collection_supported: BOOLEAN
			-- Can the current backend support collections in general,
			-- i.e. is there a default strategy?
		do
			Result := false
		end

feature {PS_RETRIEVAL_MANAGER} -- Collection retrieval


	retrieve_all_collections (collection_type: PS_TYPE_METADATA; transaction: PS_TRANSACTION): ITERATION_CURSOR [PS_RETRIEVED_OBJECT_COLLECTION]
			-- Retrieves all collections of type `collection_type'.
		do
			Result := (create {LINKED_LIST[PS_RETRIEVED_OBJECT_COLLECTION]}.make).new_cursor
			check not_implemented: False end
		end

	retrieve_collection (collection_type: PS_TYPE_METADATA; collection_primary_key: INTEGER; transaction: PS_TRANSACTION): detachable PS_RETRIEVED_OBJECT_COLLECTION
			-- Retrieves the object-oriented collection of type `collection_type' and with primary key `collection_primary_key'.
		do
			check not_implemented: False end
		end

feature {PS_EIFFELSTORE_EXPORT} -- Transaction handling

	commit (a_transaction: PS_TRANSACTION)
			-- Tries to commit `a_transaction'. As with every other error, a failed commit will result in a new exception and the error will be placed inside `a_transaction'.
		do
		end

	rollback (a_transaction: PS_TRANSACTION)
			-- Aborts `a_transaction' and undoes all changes in the database.
		do
		end

	transaction_isolation_level: PS_TRANSACTION_ISOLATION_LEVEL
			-- The currently active transaction isolation level.
		do
			create Result
			Result := Result.read_uncommitted
		end

	set_transaction_isolation_level (a_level: PS_TRANSACTION_ISOLATION_LEVEL)
			-- Set the transaction isolation level `a_level' for all future transactions.
		do
		end

feature {PS_EIFFELSTORE_EXPORT} -- Mapping

	is_mapped (object: PS_OBJECT_IDENTIFIER_WRAPPER; transaction: PS_TRANSACTION): BOOLEAN
			-- Is `object' mapped to some database entry?
		do
			Result := mapping_set.has(object.object_identifier)
		end

	add_mapping (object: PS_OBJECT_IDENTIFIER_WRAPPER; key: INTEGER; transaction: PS_TRANSACTION)
			-- Add a mapping from `object' to the database entry with primary key `key'
		do
			mapping_set.force (key, object.object_identifier)
		end

	mapping (object: PS_OBJECT_IDENTIFIER_WRAPPER; transaction: PS_TRANSACTION): INTEGER
			-- Get the mapping for `object'
		do
			Result := mapping_set[object.object_identifier]
		end

	mapping_set: HASH_TABLE[INTEGER, INTEGER]


feature {PS_EIFFELSTORE_EXPORT} -- Testing

	wipe_out
			-- Wipe out everything and initialize new.
		do
			create mapping_set.make (100)
			create database.make (50)
		end

feature {PS_BACKEND}


	internal_write (object_graph: PS_OBJECT_GRAPH_ROOT; transaction: PS_TRANSACTION)
			-- Semantics of different operations for `SIMPLE_OBJECT_GRAPH' objects:
			-- Insert:
			--		- Generate a mapping (primary key)
			--		- Write primary key, type and all attributes in `{PS_SIMPLE_OBJECT_GRAPH}.attributes' (including their runtime type) to persistent storage
			-- Update:
			--		- Update only the attributes in `{PS_SIMPLE_OBJECT_GRAPH}.attributes' (including their runtime type)
			-- Delete:
			--		- Delete the object and all its attributes
			-- Semantics of different operations for `PS_OBJECT_COlLECTION_PART'
			-- Insert:
			--		- Generate a mapping (primary key)
			--		- Write all items in `{PS_OBJECT_COlLECTION_PART}.values' (including their runtime type) to persistent storage
			--		- Write all infos in `{PS_OBJECT_COlLECTION_PART}.additional_information' to persistent storage
			-- Update:
			--		- First delete any existing database entries for `{PS_OBJECT_COlLECTION_PART}.values'
			--		- Then add all entries from the object to update
			--		- Replace all information in `{PS_OBJECT_COlLECTION_PART}.additional_information' as well
			-- Delete:
			--		- Delete the whole object
			-- Semantics of different operations for `PS_RELATIONAL_COLLECTIION_PART'
			--		- Forward request to the handler.
			--
			-- General: Make sure that any referenced objects (attributes or items) are already mapped.		
		local
			old_obj, new_obj: PS_RETRIEVED_OBJECT
			int: INTEGER
			type_db: HASH_TABLE[PS_RETRIEVED_OBJECT, INTEGER]
		do
			across object_graph.new_smart_cursor as cursor
			loop
				if not is_mapped (cursor.item.object_wrapper, transaction) then
					Current.add_mapping (cursor.item.object_wrapper, cursor.item.object_wrapper.object_identifier, transaction)
				end
			end

			across object_graph.new_smart_cursor as cursor
			loop
				if attached {PS_SINGLE_OBJECT_PART} cursor.item as object then
					prepare(object.metadata)

					if object.write_operation = object.write_operation.insert then
						new_obj := to_retrieved(object)
						across object.metadata.attributes as attr
						loop
							if not new_obj.has_attribute (attr.item) then
								new_obj.add_attribute (attr.item, "", "NONE")
							end
						end
						attach (database[object.metadata.type.type_id]).extend(new_obj, new_obj.primary_key)

					elseif object.write_operation = object.write_operation.update then

						new_obj := to_retrieved (object)
						type_db := attach (database[object.metadata.type.type_id])
						old_obj := attach (type_db.item(mapping(object.object_wrapper, transaction)))
						across new_obj.attributes as attr
						loop
							old_obj.remove_attribute (attr.item)
							old_obj.add_attribute (attr.item, new_obj.attribute_value (attr.item).value, new_obj.attribute_value (attr.item).attribute_class_name)
						end

					elseif object.write_operation = object.write_operation.delete then
						attach (database[object.metadata.type.type_id]).remove (mapping(object.object_wrapper, transaction))
						mapping_set.remove (object.object_identifier) -- TODO: remove any other mapping to the same primary key as well
					end

				elseif attached {PS_OBJECT_COLLECTION_PART[ITERABLE[detachable ANY]]} cursor.item as collection then

					if collection.write_operation = collection.write_operation.insert then

					elseif collection.write_operation = collection.write_operation.update then

					elseif collection.write_operation = collection.write_operation.delete then

					end

				else
					check relations_not_implemented: False end
				end
			end
		end


	internal_retrieve (type: PS_TYPE_METADATA; criteria: PS_CRITERION; attributes: LIST [STRING]; transaction: PS_TRANSACTION): ITERATION_CURSOR [PS_RETRIEVED_OBJECT]
			-- See function `retrieve'.
			-- Use `internal_retrieve' for contracts and other calls within a backend.
		do
			prepare(type)
			Result := attach(database[type.type.type_id]).new_cursor
		end

	internal_retrieve_by_primary (type: PS_TYPE_METADATA; key: INTEGER; attributes: LIST [STRING]; transaction: PS_TRANSACTION): detachable PS_RETRIEVED_OBJECT
			-- See function `retrieve_by_primary'.
			-- Use `internal_retrieve_by_primary' for contracts and other calls within a backend.
		do
			prepare(type)
			Result := attach(database.item (type.type.type_id)).item(key)
		end


feature {NONE} -- Implementation

	database: HASH_TABLE[HASH_TABLE[PS_RETRIEVED_OBJECT, INTEGER], INTEGER]
		-- First key: Type ID
		-- Second key: unique object identifier

	to_retrieved (object: PS_SINGLE_OBJECT_PART): PS_RETRIEVED_OBJECT
		local
			attr: PS_PAIR[STRING, STRING]
			id: INTEGER
		do
			across object.attributes as cursor
			from
				create Result.make (mapping_set[object.object_identifier], object.metadata)
			loop
				if attached {PS_COMPLEX_PART} object.attribute_value (cursor.item) then
					id := mapping_set[object.attribute_value (cursor.item).object_identifier]
				end
				attr := object.attribute_value (cursor.item).as_attribute (id)
				Result.add_attribute (cursor.item, attr.first, attr.second)
			end


		end

	prepare (type: PS_TYPE_METADATA)
		do
			if not database.has (type.type.type_id) then
				database.extend (create {HASH_TABLE[PS_RETRIEVED_OBJECT, INTEGER]}.make(100), type.type.type_id)
			end
		end

end
