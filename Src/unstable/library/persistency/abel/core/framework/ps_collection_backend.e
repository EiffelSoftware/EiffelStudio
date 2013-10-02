note
	description: "Summary description for {PS_COLLECTION_BACKEND}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	PS_COLLECTION_BACKEND

inherit
	PS_EIFFELSTORE_EXPORT

feature {PS_EIFFELSTORE_EXPORT}

	can_handle_object_oriented_collection (collection_type: PS_TYPE_METADATA): BOOLEAN
			-- Can the current backend handle an object-oriented collection of type `collection_type'?
		deferred
		end


	retrieve_all (collection_type: PS_TYPE_METADATA; transaction: PS_TRANSACTION): ITERATION_CURSOR [PS_RETRIEVED_OBJECT_COLLECTION]
			-- Retrieves all collections of type `collection_type'.
		require
--			objectoriented_collection_operation_supported: supports_object_collection
			backend_can_handle_collection: can_handle_object_oriented_collection (collection_type)
		deferred
		end

	retrieve (collection_type: PS_TYPE_METADATA; collection_primary_key: INTEGER; transaction: PS_TRANSACTION): PS_RETRIEVED_OBJECT_COLLECTION
			-- Retrieves the object-oriented collection of type `collection_type' and with primary key `collection_primary_key'.
		require
--			object_oriented_collection_operation_supported: supports_object_collection
			backend_can_handle_collection: can_handle_object_oriented_collection (collection_type)
		deferred
		end

	insert (a_collection: PS_OBJECT_COLLECTION_PART [ITERABLE [detachable ANY]]; a_transaction: PS_TRANSACTION)
			-- Add all entries in `a_collection' to the database. If the order is not conflicting with the items already in the database, it will try to preserve order.
		require
--			mode_is_insert: a_collection.write_operation = a_collection.write_operation.insert
			objectoriented_mode: not a_collection.is_relationally_mapped
			not_yet_known: not key_mapper.has_primary_key_of (a_collection.object_wrapper, a_transaction)
--			objectoriented_collection_operation_supported: supports_object_collection
			backend_can_handle_collection: can_handle_object_oriented_collection (a_collection.object_wrapper.metadata)
		deferred
		ensure
			collection_known: key_mapper.has_primary_key_of (a_collection.object_wrapper, a_transaction)
		end

	update (a_collection: PS_OBJECT_COLLECTION_PART [ITERABLE [detachable ANY]]; a_transaction: PS_TRANSACTION)
			-- Update `a_collection' in the database.
		deferred
		end


	delete (a_collection: PS_OBJECT_COLLECTION_PART [ITERABLE [detachable ANY]]; a_transaction: PS_TRANSACTION)
			-- Delete `a_collection' from the database.
		require
--			mode_is_delete: a_collection.write_operation = a_collection.write_operation.delete
			objectoriented_mode: not a_collection.is_relationally_mapped
			collection_known: key_mapper.has_primary_key_of (a_collection.object_wrapper, a_transaction)
--			objectoriented_collection_operation_supported: supports_object_collection
			backend_can_handle_collection: can_handle_object_oriented_collection (a_collection.object_wrapper.metadata)
		deferred
		ensure
			not_known_anymore: not key_mapper.has_primary_key_of (a_collection.object_wrapper, a_transaction)
		end

	key_mapper: PS_KEY_POID_TABLE
		deferred
		end

end
