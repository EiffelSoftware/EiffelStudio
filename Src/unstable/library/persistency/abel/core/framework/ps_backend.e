note
	description: "Abstraction of the actual DB backend and schema."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	PS_BACKEND

inherit

	PS_EIFFELSTORE_EXPORT

	PS_NEW_BACKEND

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

	can_handle_type (type: PS_TYPE_METADATA): BOOLEAN
			-- Can the current backend handle objects of type `type'?
		deferred
		end

	can_handle_relational_collection (owner_type, collection_item_type: PS_TYPE_METADATA): BOOLEAN
			-- Can the current backend handle the relational collection between the two classes `owner_type' and `collection_type'?
		deferred
		end

	can_handle_object_oriented_collection (collection_type: PS_TYPE_METADATA): BOOLEAN
			-- Can the current backend handle an object-oriented collection of type `collection_type'?
		deferred
		end

feature {PS_EIFFELSTORE_EXPORT} -- Object retrieval operations

--	retrieve (type: PS_TYPE_METADATA; criteria: PS_CRITERION; attributes: LIST [STRING]; transaction: PS_TRANSACTION): ITERATION_CURSOR [PS_RETRIEVED_OBJECT]
--			-- Retrieves all objects of class `type' (direct instance - not inherited from) that match the criteria in `criteria' within transaction `transaction'.
--			-- If `attributes' is not empty, it will only retrieve the attributes listed there.
--			-- If an attribute was `Void' during an insert, or it doesn't exist in the database because of a version mismatch, the attribute value during retrieval will be an empty string and its class name `NONE'.
--			-- If `type' has a generic parameter, the retrieve function will return objects of all generic instances of the generating class.
--			-- You can find out about the actual generic parameter by comparing the class name associated to a foreign key value.
--		require
--			most_general_type: across type.supertypes as supertype all not (supertype.item.is_equal (type) and type.is_subtype_of (supertype.item)) end
--			all_attributes_exist: to_implement_assertion ("The requirement is too strong - e.g. ESCHER requires attributes that are theoretically not part of the object itself. across attributes as attr all type.attributes.has (attr.item) end")
--		deferred
--			-- To have lazy loading support, you need to have a special ITERATION_CURSOR and a function next in this class to load the next item of this customized cursor
--		ensure
--			attributes_loaded: not Result.after implies are_attributes_loaded (type, attributes, Result.item)
--			class_metadata_set: not Result.after implies Result.item.class_metadata.is_equal (type.base_class)
--		end

	retrieve_from_single_key (type: PS_TYPE_METADATA; primary_key: INTEGER; transaction: PS_TRANSACTION): LINKED_LIST [PS_RETRIEVED_OBJECT]
			-- Retrieve the object of type `type' and key `primary_key'. Wrapper of the `retrieve_from_keys' in case you only need one object.
		require
			keys_exist: to_implement_assertion ("Some way to ensure that no arbitrary primary keys are getting queried")
		local
			keys: LINKED_LIST [INTEGER]
		do
			create keys.make
			keys.extend (primary_key)
			Result := Current.retrieve_from_keys (type, keys, transaction)
		ensure
			objects_loaded: to_implement_assertion ("This doesn't work: (primary_keys.count = Result.count), as some objects might have been deleted.")
			all_metadata_set: across Result as res all res.item.class_metadata.name = type.base_class.name end
		end

--	retrieve_from_keys (type: PS_TYPE_METADATA; primary_keys: LIST [INTEGER]; transaction: PS_TRANSACTION): LINKED_LIST [PS_RETRIEVED_OBJECT]
--			-- Retrieve all objects of type `type' and with primary key in `primary_keys'.
--		require
--			keys_exist: to_implement_assertion ("Some way to ensure that no arbitrary primary keys are getting queried")
--		deferred
--		ensure
--			objects_loaded: to_implement_assertion ("This doesn't work: (primary_keys.count = Result.count), as some objects might have been deleted.")
--			all_metadata_set: across Result as res all res.item.class_metadata.name = type.base_class.name end
--		end

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
			backend_can_handle_object: can_handle_type (an_object.object_wrapper.metadata)
			dependencies_known: dependencies_have_primary_key (an_object, a_transaction)
		deferred
		ensure
			object_known: key_mapper.has_primary_key_of (an_object.object_wrapper, a_transaction)
			object_written: is_successful_write (an_object, a_transaction)
		end

	update (an_object: PS_SINGLE_OBJECT_PART; a_transaction: PS_TRANSACTION)
			-- Updates `an_object' in the database.
		require
			mode_is_update: an_object.write_operation = an_object.write_operation.update
			object_known: key_mapper.has_primary_key_of (an_object.object_wrapper, a_transaction)
			backend_can_handle_object: can_handle_type (an_object.object_wrapper.metadata)
		deferred
		ensure
			object_still_known: key_mapper.has_primary_key_of (an_object.object_wrapper, a_transaction)
			object_written: is_successful_write (an_object, a_transaction)
		end

	delete (an_object: PS_SINGLE_OBJECT_PART; a_transaction: PS_TRANSACTION)
			-- Deletes `an_object' from the database.
		require
			mode_is_delete: an_object.write_operation = an_object.write_operation.delete
			object_known: key_mapper.has_primary_key_of (an_object.object_wrapper, a_transaction)
			backend_can_handle_object: can_handle_type (an_object.object_wrapper.metadata)
		deferred
		ensure
			not_known_anymore: not key_mapper.has_primary_key_of (an_object.object_wrapper, a_transaction)
		end

feature {PS_EIFFELSTORE_EXPORT} -- Object-oriented collection operations

	retrieve_all_collections (collection_type: PS_TYPE_METADATA; transaction: PS_TRANSACTION): ITERATION_CURSOR [PS_RETRIEVED_OBJECT_COLLECTION]
			-- Retrieves all collections of type `collection_type'.
		require
			objectoriented_collection_operation_supported: supports_object_collection
			backend_can_handle_collection: can_handle_object_oriented_collection (collection_type)
		deferred
		end

	retrieve_object_oriented_collection (collection_type: PS_TYPE_METADATA; collection_primary_key: INTEGER; transaction: PS_TRANSACTION): PS_RETRIEVED_OBJECT_COLLECTION
			-- Retrieves the object-oriented collection of type `collection_type' and with primary key `collection_primary_key'.
		require
			object_oriented_collection_operation_supported: supports_object_collection
			backend_can_handle_collection: can_handle_object_oriented_collection (collection_type)
		deferred
		end

	insert_object_oriented_collection (a_collection: PS_OBJECT_COLLECTION_PART [ITERABLE [detachable ANY]]; a_transaction: PS_TRANSACTION)
			-- Add all entries in `a_collection' to the database. If the order is not conflicting with the items already in the database, it will try to preserve order.
		require
			mode_is_insert: a_collection.write_operation = a_collection.write_operation.insert
			objectoriented_mode: not a_collection.is_relationally_mapped
			not_yet_known: not key_mapper.has_primary_key_of (a_collection.object_wrapper, a_transaction)
			objectoriented_collection_operation_supported: supports_object_collection
			backend_can_handle_collection: can_handle_object_oriented_collection (a_collection.object_wrapper.metadata)
		deferred
		ensure
			collection_known: key_mapper.has_primary_key_of (a_collection.object_wrapper, a_transaction)
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

feature {PS_EIFFELSTORE_EXPORT} -- Transaction handling

	commit (a_transaction: PS_TRANSACTION)
			-- Tries to commit `a_transaction'. As with every other error, a failed commit will result in a new exception and the error will be placed inside `a_transaction'.
		deferred
		end

	rollback (a_transaction: PS_TRANSACTION)
			-- Aborts `a_transaction' and undoes all changes in the database.
		deferred
		end

	transaction_isolation_level: PS_TRANSACTION_ISOLATION_LEVEL
			-- The currently active transaction isolation level.
		deferred
		end

	set_transaction_isolation_level (a_level: PS_TRANSACTION_ISOLATION_LEVEL)
			-- Set the transaction isolation level `a_level' for all future transactions.
		deferred
		end

feature {PS_EIFFELSTORE_EXPORT} -- Mapping

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

	is_successful_write (an_object: PS_SINGLE_OBJECT_PART; transaction: PS_TRANSACTION): BOOLEAN
			-- Checks if a write to an object returns the correct result.
		local
			retrieved_object: PS_RETRIEVED_OBJECT
			retrieved_obj_list: LIST [PS_RETRIEVED_OBJECT]
			keys: LINKED_LIST [INTEGER]
			current_item: PS_OBJECT_GRAPH_PART
		do
			Result := True
			create keys.make
			keys.extend (key_mapper.primary_key_of (an_object.object_wrapper, transaction).first)
			retrieved_obj_list := retrieve_from_keys (an_object.object_wrapper.metadata, keys, transaction)
			across
				an_object.object_wrapper.metadata.attributes as attr
			loop
				if an_object.attributes.has (attr.item) then
					retrieved_object := retrieved_obj_list.first
					current_item := an_object.attribute_value (attr.item)
					Result := Result and current_item.as_attribute (key_mapper.quick_translate (current_item.object_identifier, transaction)).value.is_equal (retrieved_object.attribute_value (attr.item).value)
					Result := Result and current_item.as_attribute (key_mapper.quick_translate (current_item.object_identifier, transaction)).type.is_equal (retrieved_object.attribute_value (attr.item).attribute_class_name)
				end
			end
		end

end
