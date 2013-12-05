note
	description: "Summary description for {PS_READ_CURSOR}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PS_QUERY_CURSOR

inherit
	PS_ABEL_EXPORT

	ITERATION_CURSOR [ANY]

create
	make

feature {NONE} -- Initialization

	make (a_query: PS_ABSTRACT_QUERY [ANY, ANY]; a_filter: READABLE_INDEXABLE [STRING]; a_read_manager: PS_READ_MANAGER)
			-- Initialization for `Current'.
		local
			reflector: REFLECTOR
			stored_types: LIST [READABLE_STRING_GENERAL]
			subtypes_list: LINKED_LIST [PS_TYPE_METADATA]

			type, l_type: PS_TYPE_METADATA

			empty_result: LINKED_LIST [PS_BACKEND_ENTITY]
			empty_processed: LINKED_LIST [INTEGER]
		do
			query := a_query
			filter := a_filter
			read_manager := a_read_manager
			type := read_manager.metadata_factory.create_metadata_from_type (query.generic_type)
			create reflector
			create subtypes_list.make
			stored_types := read_manager.backend.stored_types

			across
				stored_types as cursor
			from
				create subtypes_list.make
				subtypes_list.extend (type)
			loop
				l_type := read_manager.metadata_factory.create_metadata_from_type_id (reflector.dynamic_type_from_string (cursor.item))
				if l_type.type.type_id /= type.type.type_id and reflector.type_conforms_to (l_type.type.type_id, type.type.type_id) then
					subtypes_list.extend (l_type)
				end
			end

			subtypes := subtypes_list.new_cursor

			create empty_result.make
			current_result := empty_result.new_cursor
			create empty_processed.make

				-- Populate with a bogus item such that a call to `forth' can be used
				-- for proper initialization.
			empty_processed.extend (-1)
			processed_items := empty_processed.new_cursor
		end

feature {PS_ABEL_EXPORT}

	query: PS_ABSTRACT_QUERY [ANY, ANY]

	filter: READABLE_INDEXABLE [STRING]

	subtypes: ITERATION_CURSOR [PS_TYPE_METADATA]

	current_result: ITERATION_CURSOR [PS_BACKEND_ENTITY]

	processed_items: ITERATION_CURSOR [INTEGER]

	read_manager: PS_READ_MANAGER



	advance_type
			-- Retrieve the query result for the next type and update `current_result'.
		do
			if not subtypes.after then
					-- Query the database and initialize the new current_result.
				current_result := read_manager.dispatch_retrieve (subtypes.item, query.criterion, create {PS_IMMUTABLE_STRUCTURE [STRING] }.make (filter), read_manager.transaction)
				subtypes.forth
			end
		end

	advance_current_result
			-- Build the next batch of items in `current_result' and update `processed_items'.
		do
			from
			until
				not current_result.after or after
			loop
				advance_type
			end

			if not after then
				build_batch
			end
		end

	advance_item
			-- Get the next item.
		do
			from
				processed_items.forth
			until
				not processed_items.after or after
			loop
				advance_current_result
			end
		end


	forth
			-- Get objects until one satisfies the query criteria.
		do
			from
				advance_item
			until
				after or else query.criterion.is_satisfied_by (item)
			loop
				advance_item
			end
		end

	build_batch
			-- Build all objects which were returned in the last batch by the backend.
		local
			index: INTEGER
			batch_count: INTEGER

			retrieved_entity: PS_BACKEND_ENTITY
			new_object: PS_OBJECT_DATA

			to_build: LINKED_LIST [INTEGER]
			processed_item_list: LINKED_LIST [INTEGER]
		do
			create processed_item_list.make
			create to_build.make

			from
				batch_count := read_manager.backend.batch_retrieval_size
				--batch_count := 1
			until
				batch_count = 0 or current_result.after
			loop
				retrieved_entity := current_result.item
				current_result.forth
					-- Ignore non-root objects when not required.
				if retrieved_entity.is_root or not query.is_non_root_ignored then

						-- Check if the object has been loaded previously.
					index := read_manager.cache_lookup (retrieved_entity.primary_key, retrieved_entity.metadata)

					if index > 0 then
						new_object := read_manager.item (index)
						fixme ("Make sure this object is loaded to the correct depth.")
					else
						index := read_manager.count + 1
						create new_object.make_with_primary_key (index, retrieved_entity.primary_key, retrieved_entity.metadata, 0)
						read_manager.add_object (new_object, not query.is_tuple_query)
					end

					if not new_object.is_object_initialized then
						fixme ("Remove suberfluous attributes for TUPLE_QUERY")
						new_object.set_backend_representation (retrieved_entity)
						to_build.extend (index)
					end

					processed_item_list.extend (index)

				end
				batch_count := batch_count - 1
			end

			read_manager.build (to_build)
			processed_items := processed_item_list.new_cursor
		end

	item: ANY
		do
			Result := read_manager.item (processed_items.item).reflector.object
		end

	after: BOOLEAN
		do
			Result := subtypes.after and current_result.after and processed_items.after
		end

end
