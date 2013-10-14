note
	description: "Abstraction of the actual DB backend and schema."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	PS_BACKEND_COMPATIBILITY

inherit

	PS_EIFFELSTORE_EXPORT

	PS_BACKEND
		rename
			retrieve_collection as retrieve_object_oriented_collection,
			is_generic_collection_supported as supports_object_collection
		end

inherit {NONE}

	REFACTORING_HELPER

feature {PS_EIFFELSTORE_EXPORT} -- Supported collection operations


	supports_object_collection: BOOLEAN
			-- Can the current backend handle object collections?
		deferred
		end

	supports_relational_collection: BOOLEAN
			-- Can the current backend handle relational collections?
		deferred
		end

feature {PS_EIFFELSTORE_EXPORT} -- Status report


	can_handle_relational_collection (owner_type, collection_item_type: PS_TYPE_METADATA): BOOLEAN
			-- Can the current backend handle the relational collection between the two classes `owner_type' and `collection_type'?
		deferred
		end

	can_handle_object_oriented_collection (collection_type: PS_TYPE_METADATA): BOOLEAN
			-- Can the current backend handle an object-oriented collection of type `collection_type'?
		deferred
		end

feature {PS_EIFFELSTORE_EXPORT} -- internal_write: compatibility with new backend interface

	internal_write (object_graph: PS_OBJECT_GRAPH_ROOT; transaction: PS_TRANSACTION)
		local
			planner: PS_WRITE_PLANNER
			executor: PS_WRITE_EXECUTOR
		do
			create planner.make
			create executor.make (Current, transaction.repository.id_manager)
			planner.set_object_graph (object_graph)
			planner.generate_plan
			executor.perform_operations (planner.operation_plan, transaction)
		end

feature {PS_EIFFELSTORE_EXPORT} -- Object write operations

	insert (an_object: PS_SINGLE_OBJECT_PART; a_transaction: PS_TRANSACTION)
			-- Inserts `an_object' into the database.
		require
			mode_is_insert: an_object.write_operation = an_object.write_operation.insert
			not_yet_known: not key_mapper.has_primary_key_of (an_object.object_wrapper, a_transaction)
			backend_can_handle_object: is_object_type_supported (an_object.object_wrapper.metadata)
			dependencies_known: dependencies_have_primary_key (an_object, a_transaction)
		deferred
		ensure
			object_known: key_mapper.has_primary_key_of (an_object.object_wrapper, a_transaction)
--			object_written: is_successful_write (an_object, a_transaction)
		end

	update (an_object: PS_SINGLE_OBJECT_PART; a_transaction: PS_TRANSACTION)
			-- Updates `an_object' in the database.
		require
			mode_is_update: an_object.write_operation = an_object.write_operation.update
			object_known: key_mapper.has_primary_key_of (an_object.object_wrapper, a_transaction)
			backend_can_handle_object: is_object_type_supported (an_object.object_wrapper.metadata)
		deferred
		ensure
			object_still_known: key_mapper.has_primary_key_of (an_object.object_wrapper, a_transaction)
--			object_written: is_successful_write (an_object, a_transaction)
		end

	delete (an_object: PS_SINGLE_OBJECT_PART; a_transaction: PS_TRANSACTION)
			-- Deletes `an_object' from the database.
		require
			mode_is_delete: an_object.write_operation = an_object.write_operation.delete
			object_known: key_mapper.has_primary_key_of (an_object.object_wrapper, a_transaction)
			backend_can_handle_object: is_object_type_supported (an_object.object_wrapper.metadata)
		deferred
		ensure
			not_known_anymore: not key_mapper.has_primary_key_of (an_object.object_wrapper, a_transaction)
		end

feature {PS_EIFFELSTORE_EXPORT} -- Object-oriented collection operations

	insert_object_oriented_collection (a_collection: PS_OBJECT_COLLECTION_PART [ITERABLE [detachable ANY]]; a_transaction: PS_TRANSACTION)
			-- Add all entries in `a_collection' to the database. If the order is not conflicting with the items already in the database, it will try to preserve order.
		require
--			mode_is_insert: a_collection.write_operation = a_collection.write_operation.insert
			objectoriented_mode: not a_collection.is_relationally_mapped
--			not_yet_known: not key_mapper.has_primary_key_of (a_collection.object_wrapper, a_transaction)
			objectoriented_collection_operation_supported: supports_object_collection
			backend_can_handle_collection: can_handle_object_oriented_collection (a_collection.object_wrapper.metadata)
		deferred
		ensure
			collection_known: key_mapper.has_primary_key_of (a_collection.object_wrapper, a_transaction)
		end

	update_object_oriented_collection (a_collection: PS_OBJECT_COLLECTION_PART [ITERABLE [detachable ANY]]; a_transaction: PS_TRANSACTION)
			-- Update `a_collection' in the database.
		do
			delete_object_oriented_collection (a_collection, a_transaction)
			insert_object_oriented_collection (a_collection, a_transaction)
		end

	delete_object_oriented_collection (a_collection: PS_OBJECT_COLLECTION_PART [ITERABLE [detachable ANY]]; a_transaction: PS_TRANSACTION)
			-- Delete `a_collection' from the database.
		require
			mode_is_delete: a_collection.write_operation = a_collection.write_operation.delete
			objectoriented_mode: not a_collection.is_relationally_mapped
			collection_known: key_mapper.has_primary_key_of (a_collection.object_wrapper, a_transaction)
			objectoriented_collection_operation_supported: supports_object_collection
			backend_can_handle_collection: can_handle_object_oriented_collection (a_collection.object_wrapper.metadata)
		deferred
		ensure
			not_known_anymore: not key_mapper.has_primary_key_of (a_collection.object_wrapper, a_transaction)
		end

feature {PS_EIFFELSTORE_EXPORT} -- Relational collection operations

	retrieve_relational_collection (owner_type, collection_item_type: PS_TYPE_METADATA; owner_key: INTEGER; owner_attribute_name: STRING; transaction: PS_TRANSACTION): PS_RETRIEVED_RELATIONAL_COLLECTION
			-- Retrieves the relational collection between class `owner_type' and `collection_item_type', where the owner has primary key `owner_key' and the attribute name of the collection inside the owner object is called `owner_attribute_name'.
		require
			relational_collection_operation_supported: supports_relational_collection
			backend_can_handle_collection: can_handle_relational_collection (owner_type, collection_item_type)
		deferred
		end

	insert_relational_collection (a_collection: PS_RELATIONAL_COLLECTION_PART [ITERABLE [detachable ANY]]; a_transaction: PS_TRANSACTION)
			-- Add all entries in `a_collection' to the database.
		require
			mode_is_insert: a_collection.write_operation = a_collection.write_operation.insert
			is_relational: a_collection.is_relationally_mapped
			relational_collection_operation_supported: supports_relational_collection
			backend_can_handle_collection: can_handle_relational_collection (a_collection.reference_owner.metadata, a_collection.values.first.metadata)
		deferred
		end

	delete_relational_collection (a_collection: PS_RELATIONAL_COLLECTION_PART [ITERABLE [detachable ANY]]; a_transaction: PS_TRANSACTION)
			-- Delete `a_collection' from the database.
		require
			mode_is_delete: a_collection.write_operation = a_collection.write_operation.delete
			is_relational: a_collection.is_relationally_mapped
			relational_collection_operation_supported: supports_relational_collection
			backend_can_handle_collection: can_handle_relational_collection (a_collection.reference_owner.metadata, a_collection.values.first.metadata)
		deferred
		end


feature {PS_EIFFELSTORE_EXPORT} -- Mapping


	is_mapped (object: PS_OBJECT_IDENTIFIER_WRAPPER; transaction: PS_TRANSACTION): BOOLEAN
			-- Is `object' mapped to some database entry?
		do
			Result:= key_mapper.has_primary_key_of (object, transaction)
		end

	add_mapping (object: PS_OBJECT_IDENTIFIER_WRAPPER; key: INTEGER; transaction: PS_TRANSACTION)
			-- Add a mapping from `object' to the database entry with primary key `key'
		do
			key_mapper.add_entry (object, key, transaction)
		end

	mapping (object: PS_OBJECT_IDENTIFIER_WRAPPER; transaction: PS_TRANSACTION): INTEGER
			-- Get the mapping for `object'
		do
			Result := key_mapper.primary_key_of (object, transaction).first
		end

	key_mapper: PS_KEY_POID_TABLE
			-- Maps POIDs to primary keys as used by this backend.
		deferred
		end

feature {PS_EIFFELSTORE_EXPORT} -- Testing

	wipe_out
			-- Wipe out everything and initialize new.
		deferred
		end

feature {PS_EIFFELSTORE_EXPORT} -- Precondition checks

	dependencies_have_primary_key (an_object: PS_SINGLE_OBJECT_PART; transaction: PS_TRANSACTION): BOOLEAN
			-- Ensure that every dependency in `an_object' has an object_wrapper attached.
		do
			Result := across an_object.attributes as attr_name
				all (attached {PS_COMPLEX_PART} an_object.attribute_value (attr_name.item) as comp
					and an_object.attribute_value (attr_name.item).write_operation /= an_object.write_operation.no_operation)
						implies key_mapper.has_primary_key_of (comp.object_wrapper, transaction)
				end
		end


feature {NONE} -- Correctness checks

	are_attributes_loaded (type: PS_TYPE_METADATA; attributes: LIST [STRING]; obj: PS_RETRIEVED_OBJECT): BOOLEAN
			-- Check that there is a value for every attribute in `attributes' (or `type.attributes', if `attributes' is empty).
		do
			if attributes.is_empty then
				Result := across type.attributes as cursor all obj.has_attribute (cursor.item) end
			else
				Result := across attributes as cursor all obj.has_attribute (cursor.item) end
			end
		end

end
