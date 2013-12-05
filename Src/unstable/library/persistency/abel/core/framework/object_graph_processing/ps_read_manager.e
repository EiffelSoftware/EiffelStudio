note
	description: "This class processes queries and builds objects from the data provided by a PS_BACKEND."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

class
	PS_READ_MANAGER

inherit
	PS_ABSTRACT_MANAGER

create
	make

feature {NONE} -- Initialization

	make (
			a_metadata_factory: like metadata_factory;
			an_id_manager: like id_manager;
			a_primary_key_mapper: like primary_key_mapper;
			a_backend: like backend)
			-- Initialization for `Current'
		do
			initialize (a_metadata_factory, an_id_manager, a_primary_key_mapper)
			backend := a_backend

			create object_storage.make (default_size)
			create cache.make (small_size)

			create objects_to_retrieve.make (small_size)
			create collections_to_retrieve.make (small_size)

			to_process_next := new_interval
			to_process := new_interval
			to_finalize := new_interval
--			query_result_attr := (create {LINKED_LIST[PS_BACKEND_OBJECT]}.make).new_cursor
		end


	cache: HASH_TABLE[HASH_TABLE[INTEGER, INTEGER], PS_TYPE_METADATA]
			-- A cache to map a [type, primary_key] tuple to an index in `object_storage'.


feature

	backend: PS_READ_ONLY_BACKEND
			-- The database backend.


	cache_lookup (primary_key: INTEGER; type: PS_TYPE_METADATA):INTEGER
		do
			if attached cache[type] as inner then
				Result := inner[primary_key]
			end
		end


	execute (q: PS_QUERY[ANY]; a_transaction: PS_INTERNAL_TRANSACTION; a_max_level: INTEGER)
		local
			type: PS_TYPE_METADATA
			new_obj: PS_OBJECT_DATA
			found: BOOLEAN
			query_cursor: PS_QUERY_CURSOR
		do
			max_level := a_max_level
			object_storage.wipe_out
			cache.wipe_out
			internal_transaction := a_transaction

--			q.register_as_executed (transaction)

			type := metadata_factory.create_metadata_from_type(q.generic_type)

			create query_cursor.make (q, type.attributes, Current)
--			query_result_attr := dispatch_retrieve (type, q.criterion, create {PS_IMMUTABLE_STRUCTURE[STRING]}.make (type.attributes), transaction)
			q.set_internal_cursor (query_cursor)

			q.retrieve_next
--			next_entry (q)
		end

	execute_tuple (q: PS_TUPLE_QUERY[ANY]; a_transaction: PS_INTERNAL_TRANSACTION; a_max_level: INTEGER)
		local
			type: PS_TYPE_METADATA
			new_obj: PS_OBJECT_DATA
			found: BOOLEAN
			collector: PS_CRITERION_ATTRIBUTE_COLLECTOR
			trash: INTEGER
			query_cursor: PS_QUERY_CURSOR
		do
			max_level := a_max_level
			object_storage.wipe_out
			cache.wipe_out
			internal_transaction := a_transaction

--			q.register_as_executed (transaction)

			type := metadata_factory.create_metadata_from_type(q.generic_type)


			create collector.make
			trash := collector.visit (q.criterion)
			collector.attributes.compare_objects
			across q.projection as proj
			loop
				if not collector.attributes.has (proj.item) then
					collector.attributes.extend (proj.item)
				end
			end

			create query_cursor.make (q, collector.attributes, Current)
			q.set_internal_cursor (query_cursor)

--			across
--				identity_type_handlers as cursor
--			until
--				found
--			loop
--				if cursor.item.can_handle_type (type) then
--					found := True
--					check cursor.item.is_mapping_to_object end
--					query_result_attr := backend.retrieve (type, q.criterion, create {PS_IMMUTABLE_STRUCTURE[STRING]}.make (collector.attributes), transaction)
--				end
--			end
			q.retrieve_next
--			next_tuple_entry (q)
		end

	dispatch_retrieve (type: PS_TYPE_METADATA; criterion: PS_CRITERION; attributes: PS_IMMUTABLE_STRUCTURE [STRING]; a_transaction: PS_INTERNAL_TRANSACTION): ITERATION_CURSOR [PS_BACKEND_ENTITY]
			-- Retrieve a set of collections or objects (based on the handler for `type').
		local
			found: BOOLEAN
		do
			Result := (create {LINKED_LIST [PS_BACKEND_ENTITY]}.make).new_cursor

			across
				value_type_handlers as cursor
			loop
				if cursor.item.can_handle_type (type) then
					Result := backend.retrieve (type, criterion, create {PS_IMMUTABLE_STRUCTURE[STRING]}.make (<<value_type_item>>), a_transaction)
					found := True
				end
			end

			across
				identity_type_handlers as cursor
			until
				found
			loop
				if cursor.item.can_handle_type (type) then
					found := True
					if cursor.item.is_mapping_to_object then
						Result := backend.retrieve (type, criterion, attributes, a_transaction)
					else
						Result := backend.retrieve_all_collections (type, a_transaction)
					end
				end
			end

			check handler_found: found end
		end

	next_tuple_entry (query: PS_TUPLE_QUERY [ANY])
			-- Retrieve the next entry of query `query'.
		local
			type: PS_TYPE_METADATA
			new_obj: PS_OBJECT_DATA
			tuple: TUPLE
			i, index: INTEGER

			l_query_cursor: ITERATION_CURSOR [ANY]
		do
			-- Get the type of objects that the query operates on.
			type := metadata_factory.create_metadata_from_type (query.generic_type)


		check attached query.internal_cursor as qc then
			l_query_cursor := qc
		end

		l_query_cursor.forth

		if l_query_cursor.after then
			query.set_is_after
		else
				-- extract the required information

--			new_obj := item (l_query_cursor.item)

			check attached {TUPLE} type.reflection.new_instance_of (metadata_factory.generate_tuple_type (type.type, query.projection)) as t then
				tuple := t
			end

			across query.projection as attr_cursor
			from i := 1
			loop
				index := type.field_index (attr_cursor.item)
				tuple.put (type.reflection.field (index, l_query_cursor.item), i)
				i:= i+1
			end

			query.set_result_item (tuple)

		end



--			if not query_result_attr.after then
--				new_obj := next_query_result (False, query_result_attr)
--				query_result_attr.forth
--				if query.criterion.is_satisfied_by (new_obj.reflector.object) then

--						-- extract the required information
--					check attached {TUPLE} type.reflection.new_instance_of (metadata_factory.generate_tuple_type (type.type, query.projection)) as t then
--						tuple := t
--					end

--					across query.projection as attr_cursor
--					from i := 1
--					loop
--						index := type.field_index (attr_cursor.item)
--						tuple.put (type.reflection.field (index, new_obj.reflector.object), i)
--						i:= i+1
--					end

--					query.set_result_item (tuple)

--				else
--					next_tuple_entry (query)
--				end
--			else
--				query.set_is_after
--			end
		end


--	query_item: INTEGER

--	next_entry (query: PS_QUERY [ANY])
--			-- Retrieve the next entry of query `query'.
--		local
--			new_obj: PS_OBJECT_DATA
--			l_query_cursor: PS_READ_CURSOR
--		do
--			check attached query_cursor as qc then
--				l_query_cursor := qc
--			end
--			l_query_cursor.forth
--			if l_query_cursor.after then
--				query.set_is_after
--			else
--				query.set_result_item (l_query_cursor.item)
--			end


----			if not query_result_attr.after then
----				new_obj := next_query_result (True, query_result_attr)
----				query_result_attr.forth
----				if
----					query.criterion.is_satisfied_by (new_obj.reflector.object)
----					and (query.is_non_root_ignored
----					implies (transaction.root_flags[new_obj.identifier] or else (attached new_obj.backend_representation as br and then br.is_root)))
----				then
----					query.set_result_item (new_obj.reflector.object)
----				else
----					next_entry (query)
----				end
----			else
----				query.set_is_after
----			end
--		end



--	next_query_result (enable_cache: BOOLEAN; query_result: ITERATION_CURSOR [PS_BACKEND_ENTITY]): PS_OBJECT_DATA
--		local
--			index: INTEGER
--		do
--			fixme ("Maybe ask the backend for its lazy loading batch size, that way some double loading of objects can be avoided")
--			index := cache_lookup (query_result.item.primary_key, query_result.item.metadata)
--			if index > 0 then
--				Result := item (index)

--				fixme ("Make sure the object gets loaded to the correct level")
--				if not Result.is_object_initialized then

--					check not_retrieved: not attached Result.backend_representation end

--					Result.set_backend_representation (query_result.item)
--					build (index |..| index)
--				end
--			else
--				Result := create {PS_OBJECT_DATA}.make_with_primary_key (count + 1, query_result.item.primary_key, query_result.item.metadata, 0)
--				Result.set_backend_representation (query_result.item)

--				add_object (Result, enable_cache)

--				build (count |..| count)
--			end

--		end


feature {NONE}

--	query_result_attr: ITERATION_CURSOR[PS_BACKEND_ENTITY]




feature {PS_ABEL_EXPORT} -- Object building: loop control variables

	build (index_set: INDEXABLE [INTEGER, INTEGER])
			-- Build all items in `index_set'.
		do
			from
				to_finalize := new_interval
				to_process := new_interval
				to_process_next := index_set

				current_level := 0
			until
				to_process_next.is_empty and to_process.is_empty and to_finalize.is_empty
				or (current_level >= max_level and max_level > 0)
			loop
				to_finalize := to_process
				to_process := to_process_next
				to_process_next := new_interval

				process_step

				current_level := current_level + 1
			end
		end


	current_level: INTEGER


	max_level: INTEGER

	to_process_next: INDEXABLE[INTEGER, INTEGER]
	to_process: INDEXABLE [INTEGER, INTEGER]
	to_finalize: INDEXABLE[INTEGER, INTEGER]




	new_interval: PS_INTEGER_INTERVAL
			-- Create a new empty interval with values [count+1, count]
		do
			create Result.make_new (count+1, count)
		end

feature {PS_ABEL_EXPORT} -- Handler support functions

	is_processable (value: STRING; type: PS_TYPE_METADATA): BOOLEAN
			-- Check if the object identified by the [`value', `type'] tuple
			-- can be processed right now. The result is true when
			-- `type' is a value type or when the object has been retrieved before.
		do
			Result := (type.type.is_expanded and then basic_types.has (type.type.type_id))
				or else type.type.name.ends_with ("NONE")
				or else (across value_type_handlers as cursor some cursor.item.can_handle_type (type) end)
				or else (attached cache[type] as second_lvl
					and then second_lvl[value.to_integer] > 0
					and then (item(second_lvl[value.to_integer]).is_object_initialized
						or item(second_lvl[value.to_integer]).is_ignored))
		end

	processed_object (value: STRING; type: PS_TYPE_METADATA; referer: PS_OBJECT_DATA): detachable ANY
			-- Get the object identified by the [`value', `type'] tuple.
			-- The object may be served from cache or built on the fly in case of a value type.
			-- The `referer' denotes the object issuing the request.
		require
			buildable: is_processable (value, type)
		local
			current_index:INTEGER
			object_result: detachable PS_BACKEND_OBJECT
			collection_result: detachable PS_BACKEND_COLLECTION
			managed: MANAGED_POINTER
			conv: UTF_CONVERTER

			handler: detachable PS_HANDLER
		do
			current_index := referer.index
			-- Try to find a handler
			handler := search_value_type_handler (type)

			fixme ("No string comparisons")

			if type.type.name.ends_with ("NONE") then
				Result := Void
			elseif type.type.is_expanded and then basic_types.has (type.type.type_id) then
				if type.type.name.is_equal ("INTEGER_8") then
					Result := value.to_integer_8
				elseif type.type.name.is_equal ("INTEGER_16") then
					Result := value.to_integer_16
				elseif type.type.name.is_equal ("INTEGER_32") then
					Result := value.to_integer_32
				elseif type.type.name.is_equal ("INTEGER_64") then
					Result := value.to_integer_64
				elseif type.type.name.is_equal ("NATURAL_8") then
					Result := value.to_natural_8
				elseif type.type.name.is_equal ("NATURAL_16") then
					Result := value.to_natural_16
				elseif type.type.name.is_equal ("NATURAL_32") then
					Result := value.to_natural_32
				elseif type.type.name.is_equal ("NATURAL_64") then
					Result := value.to_natural_64
				elseif type.type.name.is_equal ("REAL_32") then
					create managed.make ({PLATFORM}.real_32_bytes)
					managed.put_integer_32_be (value.to_integer_32, 0)
					Result := managed.read_real_32_be (0)
				elseif type.type.name.is_equal ("REAL_64") then
					create managed.make ({PLATFORM}.real_64_bytes)
					managed.put_integer_64_be ( value.to_integer_64, 0)
					Result := managed.read_real_64_be (0)
				elseif type.type.name.is_equal ("BOOLEAN") then
					Result := value.to_boolean
				elseif type.type.name.is_equal ("CHARACTER_8") then
					Result := value.to_natural_8.to_character_8
				elseif type.type.name.is_equal ("CHARACTER_32") then
					Result := value.to_natural_32.to_character_32
				elseif type.type.name.is_equal ("POINTER") then
					fixme ("Warn the user?")
					Result := default_pointer
				else
					check
						unknown_basic_type: False
					end
				end


			elseif attached handler as safe_handler then
				Result := safe_handler.build_from_string (value, type)

			elseif
				attached cache[type] as second_lvl
				and then value.is_integer
				and then second_lvl[value.to_integer] > 0
			then
				if attached item(second_lvl[value.to_integer]).backend_representation then
					Result := item(second_lvl[value.to_integer]).reflector.object

					item(current_index).references.extend (second_lvl[value.to_integer])
					item(second_lvl[value.to_integer]).referers.extend (current_index)
				else
					Result := Void
				end

			else
				check implementation_error: False end
			end

		end

	process_next (key: INTEGER; type: PS_TYPE_METADATA; referer: PS_OBJECT_DATA)
			-- Retrieve the object with primary key `key' and type `type' in the next iteration.
			-- The `referer' denotes the object issuing the request.
		local
			i: INTEGER
			primary: INTEGER
			found: BOOLEAN
		do
			-- First check if the item is not already registered for retrieval
			across
				to_process_next as cursor
			from
				primary := key
				found := False
			until
				found
			loop
				i := cursor.item
				if item(i).primary_key = primary and then item(i).type.is_equal (type) then
					found := True
					-- Update the referers and references tables
					referer.references.extend (i)
					item(i).referers.extend (referer.index)
				end
			end

			-- Extend the objects list for retrieval
			if not found then
--				object_storage.extend (create {PS_OBJECT_DATA}.make_with_primary_key (count + 1, primary, type, current_level + 1))
				add_object (create {PS_OBJECT_DATA}.make_with_primary_key (count + 1, primary, type, current_level + 1), True)
				to_process_next.extend (count)
				-- Update the referers and references tables
				referer.references.extend (count)
				item(count).referers.extend (referer.index)
			end
		end


feature {PS_ABEL_EXPORT} -- Handler support: Batch Retrieval


	add_to_object_batch_retrieve (object: PS_OBJECT_DATA)
			-- Register `object' to be added to the next batch retrieval request.
		do
			if not attached object.backend_representation then
				objects_to_retrieve.extend ([object.type, object.primary_key, object.index])
			end
		end

	add_to_collection_batch_retrieve (collection: PS_OBJECT_DATA)
			-- Register `collection' to be added to the next batch retrieval request.
		do
			if not attached collection.backend_representation then
				collections_to_retrieve.extend ([collection.type, collection.primary_key, collection.index])
			end
		end

feature {NONE} -- Implementation

	process_step
			-- Retrieve and build all objects in `to_process'.
			-- Collect all objects to be retrieved in the next iteration in `to_process_next'.
			-- Finish initialization of all objects in `to_finalize'
		require
			collections_to_retrieve.is_empty
			objects_to_retrieve.is_empty
		local
			i: INTEGER
			identifier: PS_OBJECT_IDENTIFIER_WRAPPER
		do
			-- Search for an appropriate handler for all items to be created
			assign_handlers (to_process)

			-- Command the handlers to retrieve their objects.
			-- (Most of them will place an order for a batch retrieve though)
			do_all_in_set (agent {PS_HANDLER}.retrieve (?, Current), to_process)

			-- Do a batch retrieve
			process_batch_retrieve

			-- Create the objects, but don't initialize them yet
			do_all_in_set (agent {PS_HANDLER}.create_object (?, Current), to_process)

			-- Identify and cache the objects
			across
				to_process as idx_cursor
			loop
				i := idx_cursor.item
				if not item(i).is_ignored and not item(i).type.type.is_expanded then
					-- Identify the object with the id_manager
					id_manager.identify (item(i).reflector.object, transaction)

					identifier := id_manager.identifier_wrapper (item(i).reflector.object, transaction)
					item(i).set_identifier (identifier.object_identifier)

					-- Update the ABEL id -> primary key mapping
					primary_key_mapper.add_entry (identifier, item(i).primary_key, transaction)

					-- Update the root status
					check attached item(i).backend_representation as br then
						transaction.root_flags.force (br.is_root, identifier.object_identifier)
					end
				end
			end

			-- Update the references from the last iteration
			do_all_in_set (agent {PS_HANDLER}.finish_initialize (?, Current), to_finalize)

			-- Do some basic initialization and search for objects
			-- which need to be built in the next iteration
			do_all_in_set (agent {PS_HANDLER}.initialize (?, Current), to_process)

		end

feature {PS_ABEL_EXPORT} -- Implementation

	add_object (object: PS_OBJECT_DATA; cached: BOOLEAN)
			-- Add `object' to the object_storage and register it in cache, if `cached' is True.
		require
			correct_index: object.index = count + 1
		local
			new_inner_cache: HASH_TABLE[INTEGER, INTEGER]
		do
			object_storage.extend (object)

			-- Add the item to the cache.
			-- Also add items which have not been found in the database (i.e. backend_representation = Void).
			-- This avoids a potential problem that a shared object that got deleted may be queried several times.
			if cached then
				if attached cache[object.type] as inner_cache then
					inner_cache.extend (object.index, object.primary_key)
				else
					create new_inner_cache.make (small_size)
					new_inner_cache.extend (object.index, object.primary_key)
					cache.extend (new_inner_cache, object.type)
				end
			end
		ensure
			inserted: count - 1 = old count
			correct_position: item(object.index) = object
		end

feature {NONE} -- Implementation: Batch retrieval

	objects_to_retrieve: ARRAYED_LIST[TUPLE[type:PS_TYPE_METADATA; primary:INTEGER; index:INTEGER]]
			-- All objects to be retrieved in the next batch retrieval operation.

	collections_to_retrieve: ARRAYED_LIST[TUPLE[type:PS_TYPE_METADATA; primary:INTEGER; index:INTEGER]]
			-- All collections to be retrieved in the next batch retrieval operation.

	process_batch_retrieve
			-- Retrieve all objects and collections `objects_to_retrieve' and `collections_to_retrieve'.
			-- If the entity is present in the database, update the reference in the corresponding
			-- `{PS_OBJECT_DATA}.backend_representation'. Else set `{PS_OBJECT_DATA}.is_ignored' to true.
		do
			fixme ("Implement support for batch retrieval in the backends.")
			across
				objects_to_retrieve as cursor
			loop
				if attached backend.retrieve_by_primary (cursor.item.type, cursor.item.primary, create {PS_IMMUTABLE_STRUCTURE[STRING]}.make (cursor.item.type.attributes), transaction) as retrieved then
					item(cursor.item.index).set_backend_representation (retrieved)
				else
					item(cursor.item.index).ignore
				end
			end

			across
				collections_to_retrieve as cursor
			loop
				if attached backend.retrieve_collection (cursor.item.type, cursor.item.primary, transaction) as retrieved then
					item(cursor.item.index).set_backend_representation (retrieved)
				else
					item(cursor.item.index).ignore
				end
			end

			collections_to_retrieve.wipe_out
			objects_to_retrieve.wipe_out
		ensure
			cleared_arrays: collections_to_retrieve.is_empty and objects_to_retrieve.is_empty
		end

invariant
--	unique_objects:
--		enable_expensive_contracts implies
--			across
--				1 |..| count as idx
--			all not (
--				across
--					1 |..| count as idx2
--				some
--					(idx.item /= idx2.item
--					and item(idx.item).primary_key =  item (idx2.item).primary_key
--					and item(idx.item).type.is_equal (item(idx2.item).type))
--				end
--				)
--			end

end
