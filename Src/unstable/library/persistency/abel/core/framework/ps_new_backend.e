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
			-- Execute plugins before write
			across object_graph.new_smart_cursor as cursor
			loop
				if attached {PS_SINGLE_OBJECT_PART} cursor.item as object then
					from
						plug_in_list.finish
					until
						plug_in_list.before
					loop
						plug_in_list.item_for_iteration.before_write (object, transaction)
						plug_in_list.back
					variant
						plug_in_list.index
					end
				end
			end
			-- Store to database
			internal_write (object_graph, transaction)

			-- TODO: maybe execute plugins after write
		end

	frozen retrieve (type: PS_TYPE_METADATA; criteria: PS_CRITERION; attributes: LIST [STRING]; transaction: PS_TRANSACTION): ITERATION_CURSOR [PS_RETRIEVED_OBJECT]
			-- Retrieves all objects of class `type' (direct instance - not inherited from) that match the criteria in `criteria' within transaction `transaction'.
			-- It will only retrieve the attributes listed there.
			-- If an attribute was `Void' during an insert, or it doesn't exist in the database because of a version mismatch, the attribute value during retrieval will be an empty string and its class name `NONE'.
			-- If `type' has a generic parameter, the retrieve function will return objects of all generic instances of the generating class.
			-- You can find out about the actual generic parameter by comparing the class name associated to a foreign key value.
		require
--			most_general_type: across type.supertypes as supertype all not (supertype.item.is_equal (type) and type.is_subtype_of (supertype.item)) end
--			attributes_exist: across attributes as attr all type.attributes.has (attr.item) end
		local
			real_cursor: ITERATION_CURSOR[PS_RETRIEVED_OBJECT]
			wrapper: PS_CURSOR_WRAPPER
		do
			-- execute plugins before retrieve
			across plug_in_list as cursor
			loop
				cursor.item.before_retrieve (type, criteria, attributes, transaction)
			end

			-- Retrieve result from backend
			real_cursor := internal_retrieve (type, criteria, attributes, transaction)

			-- Wrap the cursor
			create wrapper.make (Current, real_cursor, type, criteria, attributes, transaction)
			Result := wrapper

			-- execute plugins after retrieve
			if not Result.after then
				apply_plugins (Result.item, transaction)
			end
		ensure
--			loaded_attributes_exist: not Result.after implies across Result.item.attributes as attr all type.attributes.has(attr.item) end
			metadata_set: not Result.after implies Result.item.metadata.is_equal (type)
			correct: not Result.after implies check_retrieved_object (Result.item, type, criteria, attributes, transaction)
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


	default_collection_backend: --detachable
			PS_COLLECTION_BACKEND
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

feature {PS_EIFFELSTORE_EXPORT} -- Plugins

	plug_in_list: LINKED_LIST[PS_PLUGIN]
			-- A collection of plugins providing additional functionality.
			-- The list is traversed front-to-back during retrieval operations,
			-- and back-to-front during write operations
		once ("OBJECT")
			fixme ("Move to creation procedure of all subclasses...")
			create Result.make
		end

	add_plug_in (plug_in: PS_PLUGIN)
			-- Add `plugin' to the end of the current plugin list.
		do
			plug_in_list.extend (plug_in)
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
			--correct_write: rigorous_contracts implies check_write (object_graph, transaction)
			objects_written: rigorous_contracts implies check_object_writes (object_graph, transaction)
			objects_deleted: rigorous_contracts implies check_object_deletes (object_graph, transaction)
			collections_written: rigorous_contracts implies check_collection_writes (object_graph, transaction)
			collections_deleted: rigorous_contracts implies check_collection_deletes (object_graph, transaction)
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
			all_attributes_loaded: not Result.after implies across attributes as attr all Result.item.has_attribute(attr.item) end
			metadata_set: not Result.after implies Result.item.metadata.is_equal (type)

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

feature {PS_CURSOR_WRAPPER}

	apply_plugins (item: PS_RETRIEVED_OBJECT; transaction: PS_TRANSACTION)
		do
			across plug_in_list as cursor loop
				cursor.item.after_retrieve (item, transaction)
			end
		end

feature {PS_CURSOR_WRAPPER} -- Contracts


	check_retrieved_object (object: PS_RETRIEVED_OBJECT; type:PS_TYPE_METADATA; criteria: PS_CRITERION; attributes: LIST[STRING]; transaction:PS_TRANSACTION): BOOLEAN
			-- Check if the retrieved object meets some conditions
		local
			reflection: INTERNAL
			attr_type: INTEGER
		do
			create reflection

			-- Check if the type is correct
			Result := object.metadata.is_equal (type)

			if Result then
				-- Check if all requested attributes are present
				Result := Result and attributes.for_all (agent object.has_attribute)

				-- For attributes actually present in an object, check if the runtime type makes sense.
				across attributes as cursor
				loop
					if type.attributes.has (cursor.item) then
						attr_type := reflection.dynamic_type_from_string (object.attribute_value (cursor.item).attribute_class_name)

						-- For expanded types, or when an object was attached, the runtime type must conform to the declared type
						Result := Result and (attr_type > 0 implies
							reflection.type_conforms_to (attr_type, type.attribute_type (cursor.item).type.type_id))

						-- If a reference was Void during write, the runtime type was stored as NONE and the value is 0
						Result := Result and (attr_type = reflection.none_type implies
							not type.attribute_type (cursor.item).type.is_attached -- Type can be detachable
							and object.attribute_value (cursor.item).value.is_equal ("0")) -- Value is 0
					end
				end
			end
		end



	check_object_writes (object_graph: PS_OBJECT_GRAPH_ROOT; transaction:PS_TRANSACTION): BOOLEAN
			-- Check if all objects were successfully written
		local
			retrieved: LIST[PS_RETRIEVED_OBJECT]
		do
			Result :=
				across object_graph.new_smart_cursor as cursor
				all
					(attached {PS_SINGLE_OBJECT_PART} cursor.item as object
						and then object.write_operation /= object.write_operation.delete)
					implies (is_mapped (object.object_wrapper, transaction) and then
						is_equal_object (
							object,
							retrieve_from_single_key(
								object.metadata,
								mapping(object.object_wrapper, transaction),
								transaction
								).first,
							transaction))
				end
		end

	check_object_deletes (object_graph: PS_OBJECT_GRAPH_ROOT; transaction:PS_TRANSACTION): BOOLEAN
			-- Check if all objects were successfully deleted
		do
			Result :=
				across object_graph.new_smart_cursor as cursor
				all
					(attached {PS_SINGLE_OBJECT_PART} cursor.item as object
						and then object.write_operation = object.write_operation.delete)
					implies not is_mapped (object.object_wrapper, transaction)
				end
		end

	check_collection_writes (object_graph: PS_OBJECT_GRAPH_ROOT; transaction:PS_TRANSACTION): BOOLEAN
			-- Check if all object collections were successfully inserted
		do
			Result :=
				across object_graph.new_smart_cursor as cursor
				all
					(attached {PS_OBJECT_COLLECTION_PART[ITERABLE [detachable ANY]]} cursor.item as collection
						and then collection.write_operation /= collection.write_operation.delete)
					implies (is_mapped (collection.object_wrapper, transaction) and then
						is_equal_collection (
							collection,
							default_collection_backend.retrieve(
								collection.metadata,
								mapping(collection.object_wrapper, transaction),
								transaction
								),
							transaction))
				end
		end

	check_collection_deletes (object_graph: PS_OBJECT_GRAPH_ROOT; transaction:PS_TRANSACTION): BOOLEAN
			-- Check if all object collections were successfully deleted
		do
			Result :=
				across object_graph.new_smart_cursor as cursor
				all
					(attached {PS_OBJECT_COLLECTION_PART[ITERABLE [detachable ANY]]} cursor.item as collection
						and then collection.write_operation = collection.write_operation.delete)
					implies not is_mapped (collection.object_wrapper, transaction)
				end
		end

	check_relational_collection_inserts (object_graph: PS_OBJECT_GRAPH_ROOT; transaction:PS_TRANSACTION): BOOLEAN
			-- Check if all relationally mapped collections were successfully inserted
		do
			fixme ("TODO")
		end

	check_relational_collection_deletes (object_graph: PS_OBJECT_GRAPH_ROOT; transaction:PS_TRANSACTION): BOOLEAN
			-- Check if all relationally mapped collections were successfully deleted
		do
			fixme ("TODO")
		end

--	check_write (object_graph: PS_OBJECT_GRAPH_ROOT; transaction:PS_TRANSACTION): BOOLEAN
--			-- Checks if all operations within an object graph have been successfully completed.
--		local
--			key: INTEGER
--		do
--			across object_graph.new_smart_cursor as cursor
--			from
--				Result := true
--			loop
--				if attached {PS_SINGLE_OBJECT_PART} cursor.item as object then
--					if object.write_operation /= object.write_operation.delete then
--						Result := Result and is_object_write_successful (object, transaction)
--					else
--						Result := Result and not is_mapped (object.object_wrapper, transaction)
--					end
--				else -- it is a collection...
--					if cursor.item.write_operation = cursor.item.write_operation.insert then
--						if attached {PS_OBJECT_COLLECTION_PART[ITERABLE [detachable ANY]]} cursor.item as obj_coll then

--							Result := Result and is_collection_write_successful (obj_coll, transaction)
--						end

--					else
--						-- collection delete operation... probably as part of an update, but might be
--						-- standalone. I that case check if operation was successful
--					end
--				end
--			end
--		end

--	is_collection_write_successful (a_collection: PS_OBJECT_COLLECTION_PART[ITERABLE [detachable ANY]]; transaction:PS_TRANSACTION):BOOLEAN
--			-- Checks if a write of a collection was successful.
--		do
--			fixme ("TODO")
--			Result := true
--		end

--	is_object_write_successful (an_object: PS_SINGLE_OBJECT_PART; transaction: PS_TRANSACTION): BOOLEAN
--			-- Checks if a write to an object returns the correct result.
--		local
--			retrieved_object: PS_RETRIEVED_OBJECT
--			retrieved_obj_list: LIST [PS_RETRIEVED_OBJECT]
--			keys: LINKED_LIST [INTEGER]
--			current_item: PS_OBJECT_GRAPH_PART
--		do
--			Result := True
--			create keys.make
--			keys.extend (key_mapper.primary_key_of (an_object.object_wrapper, transaction).first)
--			retrieved_obj_list := retrieve_from_keys (an_object.object_wrapper.metadata, keys, transaction)
--			Result := is_equal_object (an_object, retrieved_obj_list.first, transaction)
--		end


	is_equal_object (object: PS_SINGLE_OBJECT_PART; retrieved_object: PS_RETRIEVED_OBJECT; transaction:PS_TRANSACTION): BOOLEAN
			-- Check if the two objects are the same.
		local
			same_attribute: BOOLEAN
			attribute_value: STRING
		do
			-- Check that primary keys and types are the same
			Result := is_mapped (object.object_wrapper, transaction) and then (
				mapping (object.object_wrapper, transaction) = retrieved_object.primary_key and
				object.metadata.is_equal (retrieved_object.metadata) )

			-- Proceed by checking the attributes
			if Result then
				across object.attributes as cursor
				loop
					-- Check if the attribute is actually present
					same_attribute := retrieved_object.has_attribute (cursor.item)
						-- Check if the types and values are the same
						and then is_equal_tuple (object.attribute_value (cursor.item), retrieved_object.attribute_value (cursor.item), transaction)
				end
			end
		end

	is_equal_collection (collection: PS_OBJECT_COLLECTION_PART[ITERABLE[detachable ANY]]; retrieved_collection: PS_RETRIEVED_OBJECT_COLLECTION; transaction:PS_TRANSACTION): BOOLEAN
		local
			collection_item, retrieved_collection_item: TUPLE [value: STRING; type: STRING]
			same_item: BOOLEAN
			index: INTEGER
		do
			-- Check that primary key and types are the same
			Result := is_mapped (collection.object_wrapper, transaction) and then (
				mapping (collection.object_wrapper, transaction) = retrieved_collection.primary_key and
				collection.metadata.is_equal (retrieved_collection.metadata) )

			-- Proceed by having a look at the collection items
			if Result then
				Result := Result and collection.values.count = retrieved_collection.collection_items.count

				from index := 1
				until not Result or index = collection.values.count
				loop
					Result := Result and
						is_equal_tuple (collection.values.at (index), retrieved_collection.collection_items.at (index), transaction)
					index := index +1
				end
			end

			-- Now check if the additional information fields are stored as well
			if Result then
				across collection.additional_information.current_keys as cursor
				loop
					Result := Result and attach(collection.additional_information[cursor.item]).is_equal (retrieved_collection.get_information (cursor.item))
				end
			end
		end



	is_equal_relation (relation: PS_RELATIONAL_COLLECTION_PART[ITERABLE[detachable ANY]]; retrieved_relation: PS_RETRIEVED_RELATIONAL_COLLECTION)
		do
			fixme ("TODO")
		end

	is_equal_tuple (object_part: PS_OBJECT_GRAPH_PART; tuple: TUPLE[value:STRING; type:STRING]; transaction:PS_TRANSACTION): BOOLEAN
		do
			-- Check if the types are the same
			Result := object_part.metadata.base_class.name.is_equal (tuple.type)

			-- Check if the values are the same
			if attached {PS_COMPLEX_PART} object_part as part and then is_mapped (part.object_wrapper, transaction) then
				Result := Result and mapping (part.object_wrapper, transaction).out.is_equal (tuple.value)
			else
				-- the 0 should be ignored...
				Result := Result and object_part.as_attribute (0).value.is_equal (tuple.value)
			end

		end

end
