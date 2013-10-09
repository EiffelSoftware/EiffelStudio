note
	description: "Summary description for {PS_NEW_BACKEND}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	PS_BACKEND

inherit
	PS_EIFFELSTORE_EXPORT

inherit {NONE}
	REFACTORING_HELPER

feature {PS_EIFFELSTORE_EXPORT} -- Backend capabilities

	is_read_supported: BOOLEAN
			-- Can the current backend read objects?
		do
			Result := True
		end

	is_write_supported: BOOLEAN
			-- Can the current backend write objects?
		do
			Result := True
		end

	is_object_type_supported (type: PS_TYPE_METADATA): BOOLEAN
			-- Can the current backend handle objects of type `type'?
		local
			reflection: INTERNAL
		do
			create reflection
			Result := not reflection.is_special_type (type.type.type_id)
		end

	is_generic_collection_supported: BOOLEAN
			-- Can the current backend support collections in general,
			-- i.e. is there a default strategy?
		deferred
		end

	can_write_object_graph (an_object_graph: PS_OBJECT_GRAPH_ROOT): BOOLEAN
			-- Can the current backend write every object in the object graph?
		do
			Result := is_write_supported and then
				across an_object_graph.new_smart_cursor as cursor
				all (
					attached {PS_SINGLE_OBJECT_PART} cursor.item as it
					and then is_object_type_supported (it.metadata)
				) or (
					attached {PS_OBJECT_COLLECTION_PART[ITERABLE [detachable ANY]]} cursor.item as col
					and then is_generic_collection_supported
				) or (
					attached {PS_RELATIONAL_COLLECTION_PART[ITERABLE [detachable ANY]]} cursor.item as col
					and then to_implement_assertion ("TODO: check if there's a handler")
				)
				end
		end

feature {PS_EIFFELSTORE_EXPORT} -- Object graph write function

	frozen write (object_graph: PS_OBJECT_GRAPH_ROOT; transaction: PS_TRANSACTION)
			-- Write all objects in `object_graph' to the database.		
		require
			write_enabled: is_write_supported
			can_handle_objects: enable_expensive_contracts implies can_write_object_graph (object_graph)
			all_objects_identified: enable_expensive_contracts implies across object_graph.new_smart_cursor as c all c.item.is_identified end
			update_and_delete_mapped: enable_expensive_contracts implies
				across object_graph.new_smart_cursor as cursor
				all
					cursor.item.write_operation /= cursor.item.write_operation.insert implies is_mapped (cursor.item.object_wrapper, transaction)
				end
			insert_not_mapped_for_objects: enable_expensive_contracts implies
				across object_graph.new_smart_cursor as cursor
				all
					cursor.item.write_operation = cursor.item.write_operation.insert and attached {PS_SINGLE_OBJECT_PART} cursor.item
					implies not is_mapped (cursor.item.object_wrapper, transaction)
				end
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

feature {PS_RETRIEVAL_MANAGER} -- Object retrieval


	frozen retrieve (type: PS_TYPE_METADATA; criteria: PS_CRITERION; attributes: LIST [STRING]; transaction: PS_TRANSACTION): ITERATION_CURSOR [PS_RETRIEVED_OBJECT]
			-- Retrieves all objects from the database where the following conditions hold:
			--		1) The object is a (direct) instance of `type'
			--		2) The object is visible within the current `transaction' (e.g. not deleted previously)
			--		3) The `criteria' are satisfied for this object (this point is optional however).
			-- All attributes defined in `attributes' are guaranteed to be present. Additional attributes may be included.
			-- If an attribute was `Void' during an insert, or it doesn't exist in the database because of a version mismatch,
			-- the attribute value during retrieval will be an empty string and its class name `NONE'.
		require
			supported: is_read_supported and then is_object_type_supported (type)
			attributes_exist: across attributes as attr all type.attributes.has (attr.item) end
			no_agent_criteria: to_implement_assertion ("Adapt upper layers for this precondition")--not criteria.has_agent_criterion
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
			metadata_set: not Result.after implies Result.item.metadata.is_equal (type)
			correct: not Result.after implies check_retrieved_object (Result.item, type, attributes, transaction)
		end

	frozen retrieve_by_primary (type: PS_TYPE_METADATA; primary_key: INTEGER; attributes: LIST[STRING] transaction: PS_TRANSACTION): detachable PS_RETRIEVED_OBJECT
			-- Retrieve the object where the following conditions hold:
			--		1) The object is a (direct) instance of `type'
			--		2) The object is visible within the current `transaction' (e.g. not deleted previously)
			--		3) The object has the unique primary key `primary_key'.
			-- All attributes defined in `attributes' are guaranteed to be present. Additional attributes may be included.
			-- If an attribute was `Void' during an insert, or it doesn't exist in the database because of a version mismatch,
			-- the attribute value during retrieval will be an empty string and its class name `NONE'.
			-- Note: A primary key only has to be unique among the set of objects with type `type'.
		require
			supported: is_read_supported and then is_object_type_supported (type)
			attributes_exist: across attributes as attr all type.attributes.has (attr.item) end
		local
			keys: LINKED_LIST [INTEGER]
			res: LIST[PS_RETRIEVED_OBJECT]
		do
			-- execute plugins before retrieve
			across plug_in_list as cursor
			loop
				cursor.item.before_retrieve (type, Void, attributes, transaction)
			end

			-- Retrieve the result from the actual backend
			Result := internal_retrieve_by_primary (type, primary_key, attributes, transaction)

			-- Apply plugins after retrieve, if necessary
			if attached Result then
				apply_plugins (Result, transaction)
			end
		ensure
			metadata_set: attached Result implies Result.metadata.is_equal (type)
			correct: attached Result implies check_retrieved_object (Result, type, attributes, transaction)
			primary_key_correct: attached Result implies Result.primary_key = primary_key
		end

feature {PS_RETRIEVAL_MANAGER} -- Collection retrieval


	retrieve_all_collections (collection_type: PS_TYPE_METADATA; transaction: PS_TRANSACTION): ITERATION_CURSOR [PS_RETRIEVED_OBJECT_COLLECTION]
			-- Retrieves all collections of type `collection_type'.
		require
			collections_supported: is_generic_collection_supported
		deferred
		ensure
			correct: not Result.after implies check_retrieved_collection (Result.item, collection_type, transaction)
		end

	retrieve_collection (collection_type: PS_TYPE_METADATA; collection_primary_key: INTEGER; transaction: PS_TRANSACTION): detachable PS_RETRIEVED_OBJECT_COLLECTION
			-- Retrieves the object-oriented collection of type `collection_type' and with primary key `collection_primary_key'.
		require
			collections_supported: is_generic_collection_supported
		deferred
		ensure
			correct: attached Result implies check_retrieved_collection (Result, collection_type, transaction)
			primary_key_set: attached Result implies Result.primary_key = collection_primary_key
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
		deferred
		end

	add_mapping (object: PS_OBJECT_IDENTIFIER_WRAPPER; key: INTEGER; transaction: PS_TRANSACTION)
			-- Add a mapping from `object' to the database entry with primary key `key'
		deferred
		end

	mapping (object: PS_OBJECT_IDENTIFIER_WRAPPER; transaction: PS_TRANSACTION): INTEGER
			-- Get the mapping for `object'
		require
			mapped: is_mapped (object, transaction)
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

	enable_expensive_contracts: BOOLEAN = True
			-- Defines if some very expensive contracts should be enabled as well.

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
		deferred
		ensure
			objects_written: enable_expensive_contracts implies check_object_writes (object_graph, transaction)
			objects_deleted: enable_expensive_contracts implies check_object_deletes (object_graph, transaction)
			collections_written: enable_expensive_contracts implies check_collection_writes (object_graph, transaction)
			collections_deleted: enable_expensive_contracts implies check_collection_deletes (object_graph, transaction)
		end


	internal_retrieve (type: PS_TYPE_METADATA; criteria: PS_CRITERION; attributes: LIST [STRING]; transaction: PS_TRANSACTION): ITERATION_CURSOR [PS_RETRIEVED_OBJECT]
			-- See function `retrieve'.
			-- Use `internal_retrieve' for contracts and other calls within a backend.
		require
			supported: is_read_supported and then is_object_type_supported (type)
			no_agent_criteria: to_implement_assertion ("Adapt upper layers for this precondition")--not criteria.has_agent_criterion
		deferred
			-- To have lazy loading support, you need to have a special ITERATION_CURSOR and a function next in this class to load the next item of this customized cursor
		ensure
		end

	internal_retrieve_by_primary (type: PS_TYPE_METADATA; key: INTEGER; attributes: LIST [STRING]; transaction: PS_TRANSACTION): detachable PS_RETRIEVED_OBJECT
			-- See function `retrieve_by_primary'.
			-- Use `internal_retrieve_by_primary' for contracts and other calls within a backend.
		require
			supported: is_read_supported and then is_object_type_supported (type)
		deferred
		end

feature {PS_CURSOR_WRAPPER}

	apply_plugins (item: PS_RETRIEVED_OBJECT; transaction: PS_TRANSACTION)
		do
			across plug_in_list as cursor loop
				cursor.item.after_retrieve (item, transaction)
			end
		end

feature {PS_CURSOR_WRAPPER} -- Contracts


	check_retrieved_object (object: PS_RETRIEVED_OBJECT; type:PS_TYPE_METADATA;  attributes: LIST[STRING]; transaction:PS_TRANSACTION): BOOLEAN
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
						Result := Result and (attr_type >= 0 implies
							reflection.type_conforms_to (attr_type, type.attribute_type (cursor.item).type.type_id))

						-- If a reference was Void during write, the runtime type was stored as NONE and the value is 0
						Result := Result and (attr_type = reflection.none_type implies
							not type.attribute_type (cursor.item).type.is_attached -- Type can be detachable
							and object.attribute_value (cursor.item).value.is_empty) -- Value is an empty string

						-- something strange happened...
--						if attr_type <= 0 and attr_type /= reflection.none_type then
--							Result := False
--						end
					end
				end
			end
		end


	check_retrieved_collection (collection: PS_RETRIEVED_OBJECT_COLLECTION; type:PS_TYPE_METADATA; transaction:PS_TRANSACTION): BOOLEAN
			-- Check if the retrieved collection meets some conditions
		local
			collection_item_type: INTEGER
			runtime_type: INTEGER
			reflection: INTERNAL
		do
			-- Check if the type is correct
			Result := collection.metadata.is_equal(type)

			if Result then
				-- For all values, check if the runtime type makes sense
				across collection.collection_items as cursor
				from
					create reflection
					collection_item_type := type.actual_generic_parameter (1).type.type_id
				loop
					runtime_type := reflection.dynamic_type_from_string (cursor.item.second)

					if runtime_type >= 0 then
						-- Check if runtime type conforms to collection type
						Result := Result and reflection.type_conforms_to (runtime_type, collection_item_type)
					else
						-- Item was Void during insert
						Result := Result
							and runtime_type = reflection.none_type -- Runtime type set to "NONE"
							and not reflection.is_attached_type (collection_item_type) -- Collection type allowed to be detachable
							and cursor.item.first.is_empty -- Value is an empty string
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
							internal_retrieve_by_primary(
								object.metadata,
								mapping(object.object_wrapper, transaction),
								object.metadata.attributes.deep_twin,
								transaction
								),
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
							retrieve_collection(
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

	is_equal_object (object: PS_SINGLE_OBJECT_PART; retrieved_object: detachable PS_RETRIEVED_OBJECT; transaction:PS_TRANSACTION): BOOLEAN
			-- Check if the two objects are the same.
		local
			same_attribute: BOOLEAN
			attribute_value: STRING
		do
			if attached retrieved_object then

				-- Check that primary keys and types are the same
				Result := is_mapped (object.object_wrapper, transaction) and then (
					mapping (object.object_wrapper, transaction) = retrieved_object.primary_key and
					object.metadata.is_equal (retrieved_object.metadata) )

				-- Proceed by checking the attributes
				if Result then
					across object.attributes as cursor
					loop
--						print (cursor.item + " " + retrieved_object.has_attribute (cursor.item).out + "%N")
						-- Check if the attribute is actually present
						same_attribute := retrieved_object.has_attribute (cursor.item)
							-- Check if the types and values are the same
							and then is_equal_tuple (object.attribute_value (cursor.item), retrieved_object.attribute_value (cursor.item), transaction)

						-- Backends are allowed to drop Void references
						if not attached {PS_NULL_REFERENCE_PART} object.attribute_value (cursor.item) then
							Result := Result and same_attribute
						end
--						print (cursor.item + Result.out + "%N")
					end
				end
			end
		end

	is_equal_collection (collection: PS_OBJECT_COLLECTION_PART[ITERABLE[detachable ANY]]; retrieved_collection: detachable PS_RETRIEVED_OBJECT_COLLECTION; transaction:PS_TRANSACTION): BOOLEAN
		local
			collection_item, retrieved_collection_item: TUPLE [value: STRING; type: STRING]
			same_item: BOOLEAN
			index: INTEGER
		do
			if attached retrieved_collection then

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
		end



	is_equal_relation (relation: PS_RELATIONAL_COLLECTION_PART[ITERABLE[detachable ANY]]; retrieved_relation: PS_RETRIEVED_RELATIONAL_COLLECTION)
		do
			fixme ("TODO")
		end

	is_equal_tuple (object_part: PS_OBJECT_GRAPH_PART; tuple: TUPLE[value:STRING; type:STRING]; transaction:PS_TRANSACTION): BOOLEAN
		do
			-- Check if the types are the same
--			Result := object_part.metadata.base_class.name.is_equal (tuple.type) -- not used anymore - include generics!
			Result := object_part.metadata.type.name.is_equal (tuple.type)
--			print (object_part.metadata.type.name + "%N" + tuple.type + "%N%N")

			-- Check if the values are the same
			if attached {PS_COMPLEX_PART} object_part as part and then is_mapped (part.object_wrapper, transaction) then
				Result := Result and mapping (part.object_wrapper, transaction).out.is_equal (tuple.value)
--				print (object_part.metadata.type.name + "%N" + object_part.as_attribute (mapping (part.object_wrapper, transaction)).value.out + "%N" + tuple.value+ "%N"+ "%N")
			else
				-- the 0 should be ignored...
				Result := Result and object_part.as_attribute (0).value.is_equal (tuple.value)
--				print (object_part.metadata.type.name + "%N" + object_part.as_attribute (0).value.out + "%N" + tuple.value+ "%N"+ "%N")
			end

		end

end
