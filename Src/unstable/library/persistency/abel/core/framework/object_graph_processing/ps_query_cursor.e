note
	description: "An internal query result cursor capable of lazy loading."
	author: "Roman Schmocker"
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

	default_batch_size: INTEGER = 100
			-- The default batch size when not specified by the backend.
			-- A batch size is useful to reduce memory usage and maybe exploit caching.

	make (a_query: PS_ABSTRACT_QUERY [ANY, ANY]; a_filter: READABLE_INDEXABLE [STRING]; a_read_manager: PS_READ_MANAGER)
			-- Initialization for `Current'.
		local
			reflector: REFLECTOR
			stored_types: READABLE_INDEXABLE [IMMUTABLE_STRING_8]
			subtypes_list: ARRAYED_LIST [PS_TYPE_METADATA]

			query_type, l_type: PS_TYPE_METADATA

			empty_result: LINKED_LIST [PS_BACKEND_ENTITY]
			empty_processed: LINKED_LIST [INTEGER]
		do
			query := a_query
			create filter.make (a_filter)
			read_manager := a_read_manager
			query_type := read_manager.type_factory.create_metadata_from_type (query.generic_type)

			create subtypes_list.make (1)
			subtypes_list.extend (query_type)

			if query.is_subtype_included then
				stored_types := read_manager.connector.stored_types
				create reflector

				across
					stored_types as cursor
				loop
					l_type := read_manager.type_factory.create_metadata_from_type_id (reflector.dynamic_type_from_string (cursor.item))
					if l_type /~ query_type and reflector.type_conforms_to (l_type.type.type_id, query_type.type.type_id) then
						subtypes_list.extend (l_type)
					end
				end
			end

			type_cursor := subtypes_list.new_cursor

			create empty_result.make
			retrieved_cursor := empty_result.new_cursor
			create empty_processed.make

				-- Populate with a bogus item such that a call to `forth' can be used
				-- for proper initialization.
			empty_processed.extend (-1)
			item_cursor := empty_processed.new_cursor
			item := Current -- for void safety...
		end

feature {PS_ABEL_EXPORT} -- Access

	item: ANY
			-- <Precursor>

	read_manager: PS_READ_MANAGER
			-- The read manager to be used for object retrieval.

feature {PS_ABEL_EXPORT} -- Status report

	after: BOOLEAN
			-- <Precursor>
		do
			Result := type_cursor.after and retrieved_cursor.after and item_cursor.after
		end

feature {PS_ABEL_EXPORT} -- Cursor movement

	forth
			-- <Precursor>
		do
			from
				advance_item
			until
				after or else query.criterion.is_satisfied_by (item)
			loop
				advance_item
			end
		end

feature {NONE} -- Implementation: Access


	query: PS_ABSTRACT_QUERY [ANY, ANY]
			-- The query object associated to `Current'.

	filter: PS_IMMUTABLE_STRUCTURE [STRING]
			-- An attribute filter. Attributes not listed in `filter' should not be retrieved.

	filter_lookup: HASH_TABLE [BOOLEAN, STRING]
			-- Quick lookup for `filter'.
		attribute
			create Result.make (filter.count)
			filter.do_all (agent Result.extend (True, ?))
		end


	type_cursor: ITERATION_CURSOR [PS_TYPE_METADATA]
			-- A cursor over the different types to be retrieved.

	retrieved_cursor: ITERATION_CURSOR [PS_BACKEND_ENTITY]
			-- A cursor over the result of a specific type.

	item_cursor: ITERATION_CURSOR [INTEGER]
			-- A cursor over the finalized items.



	advance_type
			-- Retrieve the query result for the next type and reset `retrieved_cursor'.
		do
			if not type_cursor.after then
					-- Query the database and initialize the new current_result.
				retrieved_cursor := read_manager.dispatch_retrieve (type_cursor.item, query.criterion, query.is_non_root_ignored, filter, read_manager.transaction)
				type_cursor.forth
			end
		end

	advance_retrieved
			-- Build the next batch of items in `retrieved_cursor' and reset `item_cursor'.
		do
			from
			until
				not retrieved_cursor.after or after
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
				item_cursor.forth
			until
				after or (not item_cursor.after and then attached maybe_item)
			loop
				advance_retrieved
			end

			if not after and then attached maybe_item as it then
				item := it
			end
		end


	build_batch
			-- Build all objects which were returned in the last batch by the backend.
		local
			index: INTEGER
			batch_count: INTEGER

			retrieved_entity: PS_BACKEND_ENTITY
			new_object: PS_OBJECT_READ_DATA

			to_build: PS_INTEGER_INTERVAL

			processed_interval: PS_INTEGER_INTERVAL
			processed_array: ARRAYED_LIST [INTEGER]

			processed: INDEXABLE [INTEGER, INTEGER]
		do


			from

				batch_count := read_manager.connector.batch_retrieval_size
					-- Some reasonable default to exploit caches.
				if batch_count < 1 then
					batch_count := default_batch_size
				end

				if query.object_initialization_depth >= 0 then
						-- Wipe out the read manager, because there are a lot of half-initialized objects.
					read_manager.wipe_out
				end

				create to_build.make_new (read_manager.count + 1, read_manager.count)
				create processed_interval.make_new (read_manager.count + 1, read_manager.count)
				processed := processed_interval
			until
				batch_count = 0 or retrieved_cursor.after
			loop
				retrieved_entity := retrieved_cursor.item
				retrieved_cursor.forth
					-- Ignore non-root objects when not required.
				if retrieved_entity.is_root or not query.is_non_root_ignored then

						-- Check if the object has been loaded previously.
					index := read_manager.cache_lookup (retrieved_entity.primary_key, retrieved_entity.type)

					if index = 0 then

						new_object := read_manager.new_object_data (retrieved_entity.primary_key, retrieved_entity.type, 0)
						index := new_object.index

						read_manager.add_object (new_object, not query.is_tuple_query)

							-- Remove suberfluous attributes for tuple queries to prevent
							-- automatic loading in the handlers.
						if query.is_tuple_query and then attached {PS_BACKEND_OBJECT} retrieved_entity as backend_obj then
							backend_obj.filter_attributes (filter_lookup)
						end

						new_object.set_backend_representation (retrieved_entity)
						to_build.extend (index)

					elseif processed = processed_interval then
							-- The list is no longer continuous, and we need to store the retrieved items in an array.
						create processed_array.make (2 * processed_interval.count)
						processed_interval.do_all (agent processed_array.extend)
						processed := processed_array
					end

					processed.extend (index)

				end
				batch_count := batch_count - 1
			end

			read_manager.build (to_build, query.object_initialization_depth)
			item_cursor := processed.new_cursor
		end


	maybe_item: detachable ANY
			-- Retrieve the item pointed to by `item_cursor', if any.
		do
			if 0 < query.object_initialization_depth and query.object_initialization_depth <= 2 then
				Result := read_manager.item (item_cursor.item).reflector.object
			elseif attached {REFLECTED_OBJECT} read_manager.object_item (item_cursor.item) as res then
				Result := res.object
			else
				Result := read_manager.object_item (item_cursor.item)
			end
		end

end
