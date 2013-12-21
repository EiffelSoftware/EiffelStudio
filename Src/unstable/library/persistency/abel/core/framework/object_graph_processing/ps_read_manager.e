note
	description: "This class processes queries and builds objects from the data provided by a PS_BACKEND."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

class
	PS_READ_MANAGER

inherit
	PS_ABSTRACT_MANAGER [PS_OBJECT_READ_DATA]

	PS_TYPE_TABLE

create
	make

		-- Performance ToDo's:
		-- 1)	Investigate if it is more efficient to have two `storage_array' with correct types each.
		-- 2)	Check if `free_objects' has an effect at all, or if it's better to let the GC manage the free list.
		--		(The release of PS_OBJECT_READ_DATA at the end of `build' certainly has an effect)
		-- 3)	Improve `process_step' performance, e.g. by not allocating cursor objects.
		--		For small batch sizes this function needs to be very efficient.
		-- 4)	Improve `QUERY_CURSOR.batch_retrieve': e.g. use an `INTEGER_INTERVAL' when possible.
		-- 5)	Improve `process_batch_retrieve' for collections as well.

feature {NONE} -- Initialization

	make (
			a_metadata_factory: like metadata_factory;
			an_id_manager: like id_manager;
			a_primary_key_mapper: like primary_key_mapper;
			a_backend: like backend;
			a_transaction: like transaction)
			-- Initialization for `Current'
		local
			bogus: PS_OBJECT_READ_DATA
		do
			initialize (a_metadata_factory, an_id_manager, a_primary_key_mapper)
			backend := a_backend
			internal_transaction := a_transaction


			create storage_array.make_empty (default_size)
				-- Fill the first position with a bogus result.
			create bogus.make_with_primary_key (0, -1, metadata_factory.create_metadata_from_type ({NONE}), -1)
			storage_array.extend (bogus)

			create cache.make (small_size)

			create object_primaries_to_retrieve.make (small_size)
			create object_types_to_retrieve.make (small_size)
			create collections_to_retrieve.make (small_size)

			to_process_next := new_interval
			to_process := new_interval
			to_finalize := new_interval

			create free_objects.make (10)
		end


	cache: HASH_TABLE [HASH_TABLE [INTEGER, INTEGER], PS_TYPE_METADATA]
--	cache: PS_LOOKUP_TABLE [INTEGER]
			-- A cache to map a [type, primary_key] tuple to an index in `object_storage'.

--	storage_array: SPECIAL [PS_OBJECT_READ_DATA]
	storage_array: SPECIAL [detachable ANY]
			-- An internal storage for objects.

	free_objects: ARRAYED_STACK [PS_OBJECT_READ_DATA]




feature {PS_ABEL_EXPORT} -- Access

	count: INTEGER
			-- The number of objects known to this manager.

	item (index: INTEGER): PS_OBJECT_READ_DATA
			-- Get the object with index `index'
		do
			check to_finalize.has (index) or to_process.has (index) or to_process_next.has (index) end
			check attached {PS_OBJECT_READ_DATA} storage_array [index] as res then
				Result := res
			end
		ensure then
			object_correct: storage_array [index] = Result
		end

	object_item (index: INTEGER): detachable ANY
		do
			check not (to_finalize.has (index) or to_process.has (index) or to_process_next.has (index)) end
			Result := storage_array [index]--.reflector.object
		end

	backend: PS_READ_ONLY_BACKEND
			-- The database backend.


	cache_lookup (primary_key: INTEGER; type: PS_TYPE_METADATA):INTEGER
			-- See if an object of type `type' and with primary key `primary_key' is already loaded.
			-- The result is 0 if no such object exists.
		do
			if attached cache [type] as inner then
				Result := inner [primary_key]
			end
		ensure
--			correct: Result > 0 implies item (Result).primary_key = primary_key and item (Result).type ~ type
			correct: Result > to_finalize.lower implies item (Result).primary_key = primary_key and item (Result).type ~ type
		end

feature {PS_ABEL_EXPORT} -- Element change

	add_object (object: PS_OBJECT_READ_DATA; cached: BOOLEAN)
			-- Add `object' to the object_storage and register it in cache, if `cached' is True.
		require
			correct_index: object.index = count + 1
		local
			new_inner_cache: HASH_TABLE [INTEGER, INTEGER]
		do
			count := count + 1
			if count = storage_array.capacity then
					-- Array is full...
				storage_array := storage_array.aliased_resized_area (2 * count)
			end
			storage_array.extend (object)

				-- Add the item to the cache.
				-- Also add items which have not been found in the database (i.e. backend_representation = Void).
				-- This avoids a potential problem that a shared object that got deleted may be queried several times.
			if cached then
				if attached cache [object.type] as inner_cache then
					inner_cache.extend (object.index, object.primary_key)
				else
					create new_inner_cache.make (small_size)
					new_inner_cache.extend (object.index, object.primary_key)
					cache.extend (new_inner_cache, object.type)
				end
			end
		ensure
			inserted: count - 1 = old count
			correct_position: item (object.index) = object
		end

	wipe_out
			-- Empty caches and remove all data.
		do
			storage_array.keep_head (1)
			count := 0
			cache.wipe_out
			object_primaries_to_retrieve.wipe_out
			object_types_to_retrieve.wipe_out
			collections_to_retrieve.wipe_out

			to_process_next := new_interval
			to_process := new_interval
			to_finalize := new_interval
		end

feature {PS_ABEL_EXPORT} -- Smart retrieval

	dispatch_retrieve (type: PS_TYPE_METADATA; criterion: PS_CRITERION; attributes: PS_IMMUTABLE_STRUCTURE [STRING]; a_transaction: PS_INTERNAL_TRANSACTION): ITERATION_CURSOR [PS_BACKEND_ENTITY]
			-- Retrieve a set of collections or objects (based on the handler for `type').
		local
			found: BOOLEAN
		do
			Result := (create {LINKED_LIST [PS_BACKEND_ENTITY]}.make).new_cursor


			if attached search_value_type_handler (type) then
				Result := backend.retrieve (type, criterion, create {PS_IMMUTABLE_STRUCTURE [STRING]}.make (<<{PS_BACKEND_OBJECT}.value_type_item>>), a_transaction)
				found := True
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
						Result := backend.collection_retrieve (type, a_transaction)
					end
				end
			end

			check handler_found: found end
		end


feature {PS_ABEL_EXPORT} -- Object building

	build (index_set: PS_INTEGER_INTERVAL --INDEXABLE [INTEGER, INTEGER]
		; a_max_level: INTEGER)
			-- Build all items in `index_set'.
		local
			object: PS_OBJECT_READ_DATA
		do
			from
				max_level := a_max_level

				to_finalize := empty_interval
				to_process := empty_interval
				to_process_next := index_set

				current_level := 0
			until
				to_process_next.is_empty and to_process.is_empty and to_finalize.is_empty
				or (current_level >= max_level and max_level > 0)
			loop
				across
					to_finalize as cursor
				loop
					object := item (cursor.item)
					if object.reflector /= object then
							-- Expanded type
						storage_array.put (object.reflector, cursor.item)
					elseif object.is_object_initialized then
						storage_array.put (object.reflector.object, cursor.item)
					else
						storage_array.put (Void, cursor.item)
					end

					free_objects.put (object)
				end

				to_finalize := to_process
				to_process := to_process_next
				to_process_next := new_interval

				process_step

				current_level := current_level + 1
			end
		end


feature {NONE}  -- Object building: loop control variables

	max_level: INTEGER
			-- The maximum object initialization depth.

	current_level: INTEGER
			-- The current object initialization depth.

	to_process_next: PS_INTEGER_INTERVAL
			-- The objects to retrieve and build in the next iteration.

	to_process: PS_INTEGER_INTERVAL
			-- The objects to retrieve and (partially) build in this iteration.

	to_finalize: PS_INTEGER_INTERVAL
			-- The objects from the last iteration which need to be finalized.

	new_interval: PS_INTEGER_INTERVAL
			-- Create a new empty interval with values [count+1, count]
		do
			create Result.make_new (count+1, count)
		end

	empty_interval: PS_INTEGER_INTERVAL
		do
			create Result.make_new (1, 0)
		end

feature {PS_ABEL_EXPORT} -- Handler support functions

	try_build_attribute (value: STRING; type: PS_TYPE_METADATA; referer: PS_OBJECT_READ_DATA): detachable ANY
			-- Check if the attribute identified by the [`value', `type'] tuple
			-- can be built right now. The result is attached when
			-- `type' is a value type or when the object has been retrieved before.
		require
			not_none: not type.type.name.ends_with ("NONE")
		local
			managed: MANAGED_POINTER
			referee_index: INTEGER
			referee: PS_OBJECT_READ_DATA
			foreign_key: INTEGER
			l_type: INTEGER
		do
			l_type := type.type.type_id
			if type.type.is_expanded and then basic_expanded_types.has (l_type) then

				if l_type = ({INTEGER_8}).type_id then
					Result := value.to_integer_8
				elseif l_type = ({INTEGER_16}).type_id then
					Result := value.to_integer_16
				elseif l_type = ({INTEGER_32}).type_id then
					Result := value.to_integer_32
				elseif l_type = ({INTEGER_64}).type_id then
					Result := value.to_integer_64
				elseif l_type = ({NATURAL_8}).type_id then
					Result := value.to_natural_8
				elseif l_type = ({NATURAL_16}).type_id then
					Result := value.to_natural_16
				elseif l_type = ({NATURAL_32}).type_id then
					Result := value.to_natural_32
				elseif l_type = ({NATURAL_64}).type_id then
					Result := value.to_natural_64
				elseif l_type = ({REAL_32}).type_id then
					create managed.make ({PLATFORM}.real_32_bytes)
					managed.put_integer_32_be (value.to_integer_32, 0)
					Result := managed.read_real_32_be (0)
				elseif l_type = ({REAL_64}).type_id then
					create managed.make ({PLATFORM}.real_64_bytes)
					managed.put_integer_64_be ( value.to_integer_64, 0)
					Result := managed.read_real_64_be (0)
				elseif l_type = ({BOOLEAN}).type_id then
					Result := value.to_boolean
				elseif l_type = ({CHARACTER_8}).type_id then
					Result := value.to_natural_8.to_character_8
				elseif l_type = ({CHARACTER_32}).type_id then
					Result := value.to_natural_32.to_character_32
				elseif l_type = ({POINTER}).type_id then
					fixme ("Warn the user?")
					Result := default_pointer
				else
					check
						unknown_basic_type: False
					end
				end

			elseif attached search_value_type_handler (type) as safe_handler then
				Result := safe_handler.build_from_string (value, type)

			else
				check value_is_primary: value.is_integer end

				foreign_key := value.to_integer
				referee_index := cache_lookup (foreign_key, type)

				if referee_index <= 0 then
					process_next (foreign_key, type, referer)

				elseif referee_index < to_finalize.lower then
					Result := object_item (referee_index)
					check no_reflector: not attached {REFLECTED_OBJECT} Result end

				elseif referee_index < to_process_next.lower then
					referee := item (referee_index)
					if referee.is_object_initialized then
						referee.set_referer (referer.index)
						Result := referee.reflector.object
					end
				else
					referee := item (referee_index)
					referee.set_referer (referer.index)
				end
			end
		end

	build_attribute (foreign_key: INTEGER; type: PS_TYPE_METADATA; referer: PS_OBJECT_READ_DATA): detachable ANY
			-- Get the reference to the object identified by [`foreign_key', `type'].
		local
			referee_index: INTEGER
			referee: PS_OBJECT_READ_DATA
		do
			referee_index := cache_lookup (foreign_key, type)
				check in_to_process: to_process.has (referee_index) end

			check object_exists: referee_index > 0 end
			referee := item (referee_index)
			if not referee.is_ignored then
				Result := referee.reflector.object
				referee.set_referer (referer.index)
			end
		end


	is_attribute_ready (value: STRING; type: PS_TYPE_METADATA): BOOLEAN
			-- Check if the object identified by the [`value', `type'] tuple
			-- can be processed right now. The result is true when
			-- `type' is a value type or when the object has been retrieved before.
		require
			not_none: not type.type.name.ends_with ("NONE")
		do
			Result := (type.type.is_expanded and then basic_expanded_types.has (type.type.type_id))
				or else attached search_value_type_handler (type)
				or else (attached cache [type] as second_lvl
					and then second_lvl [value.to_integer] > 0
					and then (item (second_lvl [value.to_integer]).is_object_initialized
						or item (second_lvl [value.to_integer]).is_ignored))
		end

	process_next (key: INTEGER; type: PS_TYPE_METADATA; referer: PS_OBJECT_READ_DATA)
			-- Retrieve the object with primary key `key' and type `type' in the next iteration.
			-- The `referer' denotes the object issuing the request.
		require
			not_in_cache: cache_lookup (key, type) = 0
		local
			index: INTEGER
			object: PS_OBJECT_READ_DATA
			found: BOOLEAN
		do
				-- Extend the objects list for retrieval
			index := count + 1
			if free_objects.is_empty then
				create object.make_with_primary_key (index, key, type, current_level)
			else
				object := free_objects.item
				free_objects.remove
				object.reset (index, key, type, current_level)
			end

			add_object (object, True)
			to_process_next.extend (index)

				-- Update the referer
			object.set_referer (referer.index)
		end


feature {PS_ABEL_EXPORT} -- Handler support: Batch Retrieval


	add_to_object_batch_retrieve (object: PS_OBJECT_READ_DATA)
			-- Register `object' to be added to the next batch retrieval request.
		do
			if not attached object.backend_representation then
				object_types_to_retrieve.extend (object.type)
				object_primaries_to_retrieve.extend (object.primary_key)
			end
		end

	add_to_collection_batch_retrieve (collection: PS_OBJECT_READ_DATA)
			-- Register `collection' to be added to the next batch retrieval request.
		do
			if not attached collection.backend_representation then
				collections_to_retrieve.extend ([collection.type, collection.primary_key, collection.index])
			end
		end

feature {NONE} -- Implementation: Loop body

	process_step
			-- Retrieve and build all objects in `to_process'.
			-- Collect all objects to be retrieved in the next iteration in `to_process_next'.
			-- Finish initialization of all objects in `to_finalize'
		require
			collections_to_retrieve.is_empty
			object_types_to_retrieve.is_empty
			object_primaries_to_retrieve.is_empty
		local
			i: INTEGER
			identifier: PS_OBJECT_IDENTIFIER_WRAPPER
			object: PS_OBJECT_READ_DATA
		do
				-- Search for an appropriate handler for all items to be created
			assign_handlers (to_process)

				-- Command the handlers to retrieve their objects.
				-- (Most of them will place an order for a batch retrieve though)

			across
				to_process as idx
			loop
				object := item (idx.item)

				check not_ignored: not object.is_ignored end
				check initialized: object.is_handler_initialized end

				object.handler.retrieve (object, Current)
			end

				-- Do a batch retrieve
			process_batch_retrieve

				-- Create the objects, but don't initialize them yet
			across
				to_process as idx
			loop
				object := item (idx.item)

				check not_ignored: not object.is_ignored end
				check initialized: object.is_handler_initialized end

				if attached object.backend_representation then
					object.handler.create_object (object, Current)
				else
					object.ignore
				end
			end


				-- Identify and cache the objects
			if not transaction.is_readonly then

				across
					to_process as idx_cursor
				loop
					object := item (idx_cursor.item)

					if not object.is_ignored and not object.type.type.is_expanded then
							-- Identify the object with the id_manager
						id_manager.identify (object.reflector.object, transaction)

						identifier := id_manager.identifier_wrapper (object.reflector.object, transaction)
						object.set_identifier (identifier.object_identifier)

							-- Update the ABEL id -> primary key mapping
						primary_key_mapper.add_entry (identifier, object.primary_key, transaction)

							-- Update the root status
						check attached object.backend_representation as br then
							transaction.root_flags.force (br.is_root, identifier.object_identifier)
						end
					end
				end

			end

				-- Update the references from the last iteration
			across
				to_finalize as idx
			loop
				object := item (idx.item)
				if not object.is_ignored then
					check initialized: object.is_handler_initialized end
					object.handler.finish_initialize (object, Current)
				end
			end


				-- Do some basic initialization and search for objects
				-- which need to be built in the next iteration
			across
				to_process as idx
			loop
				object := item (idx.item)
				if not object.is_ignored then
					check initialized: object.is_handler_initialized end
					object.handler.initialize (object, Current)
				end
			end

		end

feature {NONE} -- Implementation: Batch retrieval

--	objects_to_retrieve: ARRAYED_LIST [TUPLE [type:PS_TYPE_METADATA; primary:INTEGER; index:INTEGER]]
			-- All objects to be retrieved in the next batch retrieval operation.

	object_primaries_to_retrieve: ARRAYED_LIST [INTEGER]

	object_types_to_retrieve: ARRAYED_LIST [PS_TYPE_METADATA]

	collections_to_retrieve: ARRAYED_LIST [TUPLE [type:PS_TYPE_METADATA; primary:INTEGER; index:INTEGER]]
			-- All collections to be retrieved in the next batch retrieval operation.

	process_batch_retrieve
			-- Retrieve all objects and collections `objects_to_retrieve' and `collections_to_retrieve'.
			-- If the entity is present in the database, update the reference in the corresponding
			-- `{PS_OBJECT_DATA}.backend_representation'. Else set `{PS_OBJECT_DATA}.is_ignored' to true.
		local
			retrieved_objects: READABLE_INDEXABLE [PS_BACKEND_OBJECT]
			retrieved_collections: READABLE_INDEXABLE [PS_BACKEND_COLLECTION]
		do

			if not object_primaries_to_retrieve.is_empty then
				retrieved_objects := backend.specific_retrieve (object_primaries_to_retrieve, object_types_to_retrieve, transaction)

				across
					retrieved_objects as obj
				loop
					item (cache_lookup (obj.item.primary_key, obj.item.metadata)).set_backend_representation (obj.item)
				end
			end

			if not collections_to_retrieve.is_empty then
				retrieved_collections := backend.specific_collection_retrieve (collections_to_retrieve, transaction)

				across
					retrieved_collections as coll
				loop
					item (cache_lookup (coll.item.primary_key, coll.item.metadata)).set_backend_representation (coll.item)
				end
			end

			collections_to_retrieve.wipe_out

			object_primaries_to_retrieve.wipe_out
			object_types_to_retrieve.wipe_out

		ensure
			cleared_arrays: collections_to_retrieve.is_empty
			more_cleared_arrays: object_primaries_to_retrieve.is_empty and object_types_to_retrieve.is_empty
		end

invariant
	count_correct: count = storage_array.count - 1
end
