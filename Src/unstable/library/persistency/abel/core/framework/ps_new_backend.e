note
	description: "Summary description for {PS_NEW_BACKEND}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	PS_NEW_BACKEND

inherit
	PS_EIFFELSTORE_EXPORT

inherit {NONE}
	REFACTORING_HELPER

feature {PS_EIFFELSTORE_EXPORT} -- Backend capabilities

	is_read_supported: BOOLEAN
			-- Can the current backend write objects?
		deferred
		end

	is_write_supported: BOOLEAN
			-- Can the current backend read objects?
		deferred
		end

	is_object_type_supported (type: PS_TYPE_METADATA): BOOLEAN
			-- Can the current backend handle objects of type `type'?
		deferred
		end

	is_generic_collection_supported: BOOLEAN
			-- Can the current backend support collections in general,
			-- i.e. is there a default strategy?
		do
			Result := attached default_collection_backend
		ensure
			has_handler: Result implies attached default_collection_backend
		end

	can_write_object_graph (an_object_graph: PS_OBJECT_GRAPH_ROOT): BOOLEAN
			-- Can the current backend write every object in the object graph?
		do
			Result := across an_object_graph as cursor
				all
					an_object_graph.write_operation = an_object_graph.write_operation.no_operation
				or else (
					attached {PS_SINGLE_OBJECT_PART} cursor.item as it
					and then is_object_type_supported (it.metadata)
				) or (
					attached {PS_OBJECT_COLLECTION_PART[ITERABLE [detachable ANY]]} cursor.item as col
					and then to_implement_assertion ("TODO: check if default collection backend can handle collection")
				) or (
					attached {PS_RELATIONAL_COLLECTION_PART[ITERABLE [detachable ANY]]} cursor.item as col
					and then to_implement_assertion ("TODO: check if there's a handler")
				)
				end
		end

feature {PS_EIFFELSTORE_EXPORT}

	frozen write (object_graph: PS_OBJECT_GRAPH_ROOT; transaction: PS_TRANSACTION)
			-- Write all objects in `object_graph' to the database.
		require
			write_enabled: is_write_supported
			can_handle_objects: rigorous_contracts implies can_write_object_graph (object_graph)
			all_objects_identified: rigorous_contracts implies across object_graph.new_smart_cursor as c all c.item.is_identified end
		do
			-- execute plugins before write
			internal_write (object_graph, transaction)
			-- execute plugins after write
		end

	frozen retrieve (type: PS_TYPE_METADATA; criteria: PS_CRITERION; attributes: LIST [STRING]; transaction: PS_TRANSACTION): ITERATION_CURSOR [PS_RETRIEVED_OBJECT]
			-- Retrieves all objects of class `type' (direct instance - not inherited from) that match the criteria in `criteria' within transaction `transaction'.
			-- If `attributes' is not empty, it will only retrieve the attributes listed there.
			-- If an attribute was `Void' during an insert, or it doesn't exist in the database because of a version mismatch, the attribute value during retrieval will be an empty string and its class name `NONE'.
			-- If `type' has a generic parameter, the retrieve function will return objects of all generic instances of the generating class.
			-- You can find out about the actual generic parameter by comparing the class name associated to a foreign key value.
		require
--			most_general_type: across type.supertypes as supertype all not (supertype.item.is_equal (type) and type.is_subtype_of (supertype.item)) end
--			all_attributes_exist: to_implement_assertion ("The requirement is too strong - e.g. ESCHER requires attributes that are theoretically not part of the object itself. across attributes as attr all type.attributes.has (attr.item) end")
		do
			-- execute plugins before retrieve
			Result := internal_retrieve (type, criteria, attributes, transaction)
			-- execute plugins after retrieve
		ensure
--			attributes_loaded: not Result.after implies are_attributes_loaded (type, attributes, Result.item)
--			class_metadata_set: not Result.after implies Result.item.class_metadata.is_equal (type.base_class)
		end

	retrieve_from_single_key (type: PS_TYPE_METADATA; primary_key: INTEGER; transaction: PS_TRANSACTION): LINKED_LIST [PS_RETRIEVED_OBJECT]
			-- Retrieve the object of type `type' and key `primary_key'. Wrapper of the `retrieve_from_keys' in case you only need one object.
		require
--			keys_exist: to_implement_assertion ("Some way to ensure that no arbitrary primary keys are getting queried")
		local
			keys: LINKED_LIST [INTEGER]
		do
			create keys.make
			keys.extend (primary_key)
			Result := Current.retrieve_from_keys (type, keys, transaction)
		ensure
--			objects_loaded: to_implement_assertion ("This doesn't work: (primary_keys.count = Result.count), as some objects might have been deleted.")
--			all_metadata_set: across Result as res all res.item.class_metadata.name = type.base_class.name end
		end


	frozen retrieve_from_keys (type: PS_TYPE_METADATA; primary_keys: LIST [INTEGER]; transaction: PS_TRANSACTION): LINKED_LIST [PS_RETRIEVED_OBJECT]
			-- Retrieve all objects of type `type' and with primary key in `primary_keys'.
		require
--			keys_exist: to_implement_assertion ("Some way to ensure that no arbitrary primary keys are getting queried")
		do
			-- execute plugins before retrieve
			Result := internal_retrieve_from_keys (type, primary_keys, transaction)
			-- execute plugins after retrieve
		ensure
--			objects_loaded: to_implement_assertion ("This doesn't work: (primary_keys.count = Result.count), as some objects might have been deleted.")
--			all_metadata_set: across Result as res all res.item.class_metadata.name = type.base_class.name end
		end


	default_collection_backend: detachable PS_COLLECTION_BACKEND
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
		require
			mapped: is_mapped (object, transaction)
		do
			Result := key_mapper.primary_key_of (object, transaction).first
		end

feature {NONE} -- Mapping, Implementation


	key_mapper: PS_KEY_POID_TABLE
			-- Maps POIDs to primary keys as used by this backend.
		deferred
		end

feature {PS_EIFFELSTORE_EXPORT} -- Testing

	wipe_out
			-- Wipe out everything and initialize new.
		deferred
		end

	rigorous_contracts: BOOLEAN = True
			-- Defines if some very expensive contracts should be enabled as well.

feature {PS_NEW_BACKEND}


	internal_write (object_graph: PS_OBJECT_GRAPH_ROOT; transaction: PS_TRANSACTION)
		require
			update_and_delete_mapped: rigorous_contracts implies
				across object_graph.new_smart_cursor as cursor
				all
					cursor.item.write_operation /= cursor.item.write_operation.insert implies is_mapped (cursor.item.object_wrapper, transaction)
				end
			insert_not_mapped_for_objects: rigorous_contracts implies
				across object_graph.new_smart_cursor as cursor
				all
					cursor.item.write_operation = cursor.item.write_operation.insert and attached {PS_SINGLE_OBJECT_PART} cursor.item
					implies not is_mapped (cursor.item.object_wrapper, transaction)
				end
		deferred
		ensure
			correct_write: rigorous_contracts implies check_write (object_graph, transaction)
		end


	internal_retrieve (type: PS_TYPE_METADATA; criteria: PS_CRITERION; attributes: LIST [STRING]; transaction: PS_TRANSACTION): ITERATION_CURSOR [PS_RETRIEVED_OBJECT]
			-- Retrieves all objects of class `type' (direct instance - not inherited from) that match the criteria in `criteria' within transaction `transaction'.
			-- If `attributes' is not empty, it will only retrieve the attributes listed there.
			-- If an attribute was `Void' during an insert, or it doesn't exist in the database because of a version mismatch, the attribute value during retrieval will be an empty string and its class name `NONE'.
			-- If `type' has a generic parameter, the retrieve function will return objects of all generic instances of the generating class.
			-- You can find out about the actual generic parameter by comparing the class name associated to a foreign key value.
		require
--			most_general_type: across type.supertypes as supertype all not (supertype.item.is_equal (type) and type.is_subtype_of (supertype.item)) end
--			all_attributes_exist: to_implement_assertion ("The requirement is too strong - e.g. ESCHER requires attributes that are theoretically not part of the object itself. across attributes as attr all type.attributes.has (attr.item) end")
		deferred
			-- To have lazy loading support, you need to have a special ITERATION_CURSOR and a function next in this class to load the next item of this customized cursor
		ensure
--			attributes_loaded: not Result.after implies are_attributes_loaded (type, attributes, Result.item)
--			class_metadata_set: not Result.after implies Result.item.class_metadata.is_equal (type.base_class)
		end

	internal_retrieve_from_keys (type: PS_TYPE_METADATA; primary_keys: LIST [INTEGER]; transaction: PS_TRANSACTION): LINKED_LIST [PS_RETRIEVED_OBJECT]
			-- Retrieve all objects of type `type' and with primary key in `primary_keys'.
		require
--			keys_exist: to_implement_assertion ("Some way to ensure that no arbitrary primary keys are getting queried")
		deferred
		ensure
--			objects_loaded: to_implement_assertion ("This doesn't work: (primary_keys.count = Result.count), as some objects might have been deleted.")
--			all_metadata_set: across Result as res all res.item.class_metadata.name = type.base_class.name end
		end

feature {NONE} -- Contracts

	check_object_writes (object_graph: PS_OBJECT_GRAPH_ROOT; transaction:PS_TRANSACTION): BOOLEAN
			-- Check if all objects were successfully written
		local
			retrieved: LIST[PS_RETRIEVED_OBJECT]
		do
			Result := True
			if rigorous_contracts then
				across object_graph.new_smart_cursor as cursor
				loop
					if attached {PS_SINGLE_OBJECT_PART} cursor.item as object
								and cursor.item.write_operation /= cursor.item.write_operation.delete then

						if not is_mapped (object.object_wrapper, transaction) then
							Result := False
						else
							Result := Result and is_object_write_successful (object, transaction)
						end
					end
				end
			end
		end

	check_object_deletes (object_graph: PS_OBJECT_GRAPH_ROOT; transaction:PS_TRANSACTION): BOOLEAN
			-- Check if all objects were successfully deleted
		do
			Result := True
			if rigorous_contracts then
				across object_graph.new_smart_cursor as cursor
				loop
					if attached {PS_SINGLE_OBJECT_PART} cursor.item as object
								and cursor.item.write_operation = cursor.item.write_operation.delete then
						Result := Result and not is_mapped (object.object_wrapper, transaction)
					end
				end
			end
		end

	check_object_collection_inserts (object_graph: PS_OBJECT_GRAPH_ROOT; transaction:PS_TRANSACTION): BOOLEAN
			-- Check if all object collections were successfully inserted
		do
			Result := True
			if rigorous_contracts then
				across object_graph.new_smart_cursor as cursor
				loop
					if attached {PS_OBJECT_COLLECTION_PART[ITERABLE [detachable ANY]]} cursor.item as obj_coll then
						if not is_mapped (obj_coll.object_wrapper, transaction) then
							Result := False
						else

						end
					end
				end
			end
		end

	check_object_collection_deletes (object_graph: PS_OBJECT_GRAPH_ROOT; transaction:PS_TRANSACTION): BOOLEAN
			-- Check if all object collections were successfully deleted
		do
			Result := True
			if rigorous_contracts then
				-- careful: some deletes just happen as part of an update

			end
		end

	check_relational_collection_inserts (object_graph: PS_OBJECT_GRAPH_ROOT; transaction:PS_TRANSACTION): BOOLEAN
			-- Check if all relationally mapped collections were successfully inserted
		do
			Result := True
			if rigorous_contracts then

			end
		end

	check_relational_collection_deletes (object_graph: PS_OBJECT_GRAPH_ROOT; transaction:PS_TRANSACTION): BOOLEAN
			-- Check if all relationally mapped collections were successfully deleted
		do
			Result := True
			if rigorous_contracts then
				-- careful: some deletes just happen as part of an update

			end
		end

	check_write (object_graph: PS_OBJECT_GRAPH_ROOT; transaction:PS_TRANSACTION): BOOLEAN
			-- Checks if all operations within an object graph have been successfully completed.
		local
			key: INTEGER
		do
			across object_graph.new_smart_cursor as cursor
			from
				Result := true
			loop
				if attached {PS_SINGLE_OBJECT_PART} cursor.item as object then
					if object.write_operation /= object.write_operation.delete then
						Result := Result and is_object_write_successful (object, transaction)
					else
						Result := Result and not is_mapped (object.object_wrapper, transaction)
					end
				else -- it is a collection...
					if cursor.item.write_operation = cursor.item.write_operation.insert then
						if attached {PS_OBJECT_COLLECTION_PART[ITERABLE [detachable ANY]]} cursor.item as obj_coll then

							Result := Result and is_collection_write_successful (obj_coll, transaction)
						end

					else
						-- collection delete operation... probably as part of an update, but might be
						-- standalone. I that case check if operation was successful
					end
				end
			end
		end

	is_collection_write_successful (a_collection: PS_OBJECT_COLLECTION_PART[ITERABLE [detachable ANY]]; transaction:PS_TRANSACTION):BOOLEAN
			-- Checks if a write of a collection was successful.
		do
			fixme ("TODO")
			Result := true
		end

	is_object_write_successful (an_object: PS_SINGLE_OBJECT_PART; transaction: PS_TRANSACTION): BOOLEAN
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
