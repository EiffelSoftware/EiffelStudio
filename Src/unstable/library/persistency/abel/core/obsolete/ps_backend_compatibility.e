note
	description: "Abstraction of the actual DB backend and schema."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	PS_BACKEND_COMPATIBILITY

inherit

	PS_ABEL_EXPORT

	PS_READ_ONLY_BACKEND
		rename
			retrieve_collection as retrieve_object_oriented_collection,
			is_generic_collection_supported as supports_object_collection
		end

	REFACTORING_HELPER

feature {PS_ABEL_EXPORT} -- Backend capabilities


	can_write_object_graph (an_object_graph: PS_OBJECT_GRAPH_ROOT): BOOLEAN
			-- Can the current backend write every object in the object graph?
		do
			Result :=
				across an_object_graph.new_smart_cursor as cursor
				all (
					attached {PS_SINGLE_OBJECT_PART} cursor.item as it
					and then is_object_type_supported (it.metadata)
				) or (
					attached {PS_OBJECT_COLLECTION_PART} cursor.item as col
					and then supports_object_collection
				) or (
					attached {PS_RELATIONAL_COLLECTION_PART} cursor.item as col
					and then to_implement_assertion ("TODO: check if there's a handler")
				)
				end
		end

feature {PS_ABEL_EXPORT} -- Supported collection operations


	supports_object_collection: BOOLEAN
			-- Can the current backend handle object collections?
		deferred
		end

	supports_relational_collection: BOOLEAN
			-- Can the current backend handle relational collections?
		deferred
		end

feature {PS_ABEL_EXPORT} -- Status report


	can_handle_relational_collection (owner_type, collection_item_type: PS_TYPE_METADATA): BOOLEAN
			-- Can the current backend handle the relational collection between the two classes `owner_type' and `collection_type'?
		deferred
		end

	can_handle_object_oriented_collection (collection_type: PS_TYPE_METADATA): BOOLEAN
			-- Can the current backend handle an object-oriented collection of type `collection_type'?
		deferred
		end

feature {PS_ABEL_EXPORT} -- Object graph write function

	frozen write (object_graph: PS_OBJECT_GRAPH_ROOT; transaction: PS_INTERNAL_TRANSACTION)
			-- Write all objects in `object_graph' to the database.		
		require
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
						plug_in_list.item_for_iteration.before_write_compatibility (object, transaction)
						plug_in_list.back
					variant
						plug_in_list.index
					end
				end
			end
			-- Store to database
			internal_write (object_graph, transaction)
		end

feature {PS_ABEL_EXPORT} -- internal_write: compatibility with new backend interface

	internal_write (object_graph: PS_OBJECT_GRAPH_ROOT; transaction: PS_INTERNAL_TRANSACTION)
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
			planner: PS_WRITE_PLANNER
			executor: PS_WRITE_EXECUTOR
		do
			create planner.make
			create executor.make (Current, transaction.repository.id_manager)
			planner.set_object_graph (object_graph)
			planner.generate_plan
			executor.perform_operations (planner.operation_plan, transaction)
		ensure
			objects_written: enable_expensive_contracts implies check_object_writes (object_graph, transaction)
			objects_deleted: enable_expensive_contracts implies check_object_deletes (object_graph, transaction)
			collections_written: enable_expensive_contracts implies check_collection_writes (object_graph, transaction)
			collections_deleted: enable_expensive_contracts implies check_collection_deletes (object_graph, transaction)
		end

feature {PS_ABEL_EXPORT} -- Object write operations

	insert (an_object: PS_SINGLE_OBJECT_PART; a_transaction: PS_INTERNAL_TRANSACTION)
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

	update (an_object: PS_SINGLE_OBJECT_PART; a_transaction: PS_INTERNAL_TRANSACTION)
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

	delete (an_object: PS_SINGLE_OBJECT_PART; a_transaction: PS_INTERNAL_TRANSACTION)
			-- Deletes `an_object' from the database.
		require
			mode_is_delete: an_object.write_operation = an_object.write_operation.delete
			object_known: key_mapper.has_primary_key_of (an_object.object_wrapper, a_transaction)
			backend_can_handle_object: is_object_type_supported (an_object.object_wrapper.metadata)
		deferred
		ensure
			not_known_anymore: not key_mapper.has_primary_key_of (an_object.object_wrapper, a_transaction)
		end

feature {PS_ABEL_EXPORT} -- Object-oriented collection operations

	insert_object_oriented_collection (a_collection: PS_OBJECT_COLLECTION_PART; a_transaction: PS_INTERNAL_TRANSACTION)
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

	update_object_oriented_collection (a_collection: PS_OBJECT_COLLECTION_PART; a_transaction: PS_INTERNAL_TRANSACTION)
			-- Update `a_collection' in the database.
		do
			delete_object_oriented_collection (a_collection, a_transaction)
			insert_object_oriented_collection (a_collection, a_transaction)
		end

	delete_object_oriented_collection (a_collection: PS_OBJECT_COLLECTION_PART; a_transaction: PS_INTERNAL_TRANSACTION)
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

feature {PS_ABEL_EXPORT} -- Relational collection operations

	retrieve_relational_collection (owner_type, collection_item_type: PS_TYPE_METADATA; owner_key: INTEGER; owner_attribute_name: STRING; transaction: PS_INTERNAL_TRANSACTION): PS_RETRIEVED_RELATIONAL_COLLECTION
			-- Retrieves the relational collection between class `owner_type' and `collection_item_type', where the owner has primary key `owner_key' and the attribute name of the collection inside the owner object is called `owner_attribute_name'.
		require
			relational_collection_operation_supported: supports_relational_collection
			backend_can_handle_collection: can_handle_relational_collection (owner_type, collection_item_type)
		deferred
		end

	insert_relational_collection (a_collection: PS_RELATIONAL_COLLECTION_PART; a_transaction: PS_INTERNAL_TRANSACTION)
			-- Add all entries in `a_collection' to the database.
		require
			mode_is_insert: a_collection.write_operation = a_collection.write_operation.insert
			is_relational: a_collection.is_relationally_mapped
			relational_collection_operation_supported: supports_relational_collection
			backend_can_handle_collection: can_handle_relational_collection (a_collection.reference_owner.metadata, a_collection.values.first.metadata)
		deferred
		end

	delete_relational_collection (a_collection: PS_RELATIONAL_COLLECTION_PART; a_transaction: PS_INTERNAL_TRANSACTION)
			-- Delete `a_collection' from the database.
		require
			mode_is_delete: a_collection.write_operation = a_collection.write_operation.delete
			is_relational: a_collection.is_relationally_mapped
			relational_collection_operation_supported: supports_relational_collection
			backend_can_handle_collection: can_handle_relational_collection (a_collection.reference_owner.metadata, a_collection.values.first.metadata)
		deferred
		end


feature {PS_ABEL_EXPORT} -- Mapping


	is_mapped (object: PS_OBJECT_IDENTIFIER_WRAPPER; transaction: PS_INTERNAL_TRANSACTION): BOOLEAN
			-- Is `object' mapped to some database entry?
		do
			Result:= key_mapper.has_primary_key_of (object, transaction)
		end

	add_mapping (object: PS_OBJECT_IDENTIFIER_WRAPPER; key: INTEGER; transaction: PS_INTERNAL_TRANSACTION)
			-- Add a mapping from `object' to the database entry with primary key `key'
		do
			key_mapper.add_entry (object, key, transaction)
		end

	mapping (object: PS_OBJECT_IDENTIFIER_WRAPPER; transaction: PS_INTERNAL_TRANSACTION): INTEGER
			-- Get the mapping for `object'
		do
			Result := key_mapper.primary_key_of (object, transaction).first
		end

	key_mapper: PS_KEY_POID_TABLE
			-- Maps POIDs to primary keys as used by this backend.
		deferred
		end

feature {PS_ABEL_EXPORT} -- Testing

	wipe_out
			-- Wipe out everything and initialize new.
		deferred
		end

feature {PS_ABEL_EXPORT} -- Precondition checks

	dependencies_have_primary_key (an_object: PS_SINGLE_OBJECT_PART; transaction: PS_INTERNAL_TRANSACTION): BOOLEAN
			-- Ensure that every dependency in `an_object' has an object_wrapper attached.
		do
			Result := across an_object.attributes as attr_name
				all (attached {PS_COMPLEX_PART} an_object.attribute_value (attr_name.item) as comp
					and an_object.attribute_value (attr_name.item).write_operation /= an_object.write_operation.no_operation)
						implies key_mapper.has_primary_key_of (comp.object_wrapper, transaction)
				end
		end


feature {NONE} -- Correctness checks

	are_attributes_loaded (type: PS_TYPE_METADATA; attributes: LIST [STRING]; obj: PS_BACKEND_OBJECT): BOOLEAN
			-- Check that there is a value for every attribute in `attributes' (or `type.attributes', if `attributes' is empty).
		do
			if attributes.is_empty then
				Result := across type.attributes as cursor all obj.has_attribute (cursor.item) end
			else
				Result := across attributes as cursor all obj.has_attribute (cursor.item) end
			end
		end

	check_object_writes (object_graph: PS_OBJECT_GRAPH_ROOT; transaction:PS_INTERNAL_TRANSACTION): BOOLEAN
			-- Check if all objects were successfully written
		local
			retrieved: LIST[PS_BACKEND_OBJECT]
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
								object.metadata.attributes,
								transaction
								),
							transaction))
				end
		end

	check_object_deletes (object_graph: PS_OBJECT_GRAPH_ROOT; transaction:PS_INTERNAL_TRANSACTION): BOOLEAN
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

	check_collection_writes (object_graph: PS_OBJECT_GRAPH_ROOT; transaction:PS_INTERNAL_TRANSACTION): BOOLEAN
			-- Check if all object collections were successfully inserted
		do
			Result :=
				across object_graph.new_smart_cursor as cursor
				all
					(attached {PS_OBJECT_COLLECTION_PART} cursor.item as collection
						and then collection.write_operation /= collection.write_operation.delete)
					implies (is_mapped (collection.object_wrapper, transaction) and then
						is_equal_collection (
							collection,
							retrieve_object_oriented_collection(
								collection.metadata,
								mapping(collection.object_wrapper, transaction),
								transaction
								),
							transaction))
				end
		end

	check_collection_deletes (object_graph: PS_OBJECT_GRAPH_ROOT; transaction:PS_INTERNAL_TRANSACTION): BOOLEAN
			-- Check if all object collections were successfully deleted
		do
			Result :=
				across object_graph.new_smart_cursor as cursor
				all
					(attached {PS_OBJECT_COLLECTION_PART} cursor.item as collection
						and then collection.write_operation = collection.write_operation.delete)
					implies not is_mapped (collection.object_wrapper, transaction)
				end
		end

	check_relational_collection_inserts (object_graph: PS_OBJECT_GRAPH_ROOT; transaction:PS_INTERNAL_TRANSACTION): BOOLEAN
			-- Check if all relationally mapped collections were successfully inserted
		do
			fixme ("TODO")
		end

	check_relational_collection_deletes (object_graph: PS_OBJECT_GRAPH_ROOT; transaction:PS_INTERNAL_TRANSACTION): BOOLEAN
			-- Check if all relationally mapped collections were successfully deleted
		do
			fixme ("TODO")
		end

	is_equal_object (object: PS_SINGLE_OBJECT_PART; retrieved_object: detachable PS_BACKEND_OBJECT; transaction:PS_INTERNAL_TRANSACTION): BOOLEAN
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

	is_equal_collection (collection: PS_OBJECT_COLLECTION_PART; retrieved_collection: detachable PS_BACKEND_COLLECTION; transaction:PS_INTERNAL_TRANSACTION): BOOLEAN
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



	is_equal_relation (relation: PS_RELATIONAL_COLLECTION_PART; retrieved_relation: PS_RETRIEVED_RELATIONAL_COLLECTION)
		do
			fixme ("TODO")
		end

	is_equal_tuple (object_part: PS_OBJECT_GRAPH_PART; tuple: TUPLE[value:STRING; type:STRING]; transaction:PS_INTERNAL_TRANSACTION): BOOLEAN
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
