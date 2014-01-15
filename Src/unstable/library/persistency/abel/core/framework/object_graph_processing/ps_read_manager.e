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

feature {NONE} -- Initialization

	make (
			a_metadata_factory: like type_factory;
			a_connector: like connector;
			a_transaction: like transaction)
			-- Initialization for `Current'
		local
			bogus: PS_OBJECT_READ_DATA
		do
			initialize (a_metadata_factory)
			connector := a_connector
			transaction := a_transaction


			create storage_array.make_empty (default_size)
				-- Fill the first position with a bogus result.
			create bogus.make_with_primary_key (0, -1, type_factory.create_metadata_from_type ({NONE}), -1)
			storage_array.extend (bogus)

			create cache.make (small_size)

			create object_primaries_to_retrieve.make (small_size)
			create object_types_to_retrieve.make (small_size)
			create collection_primaries_to_retrieve.make (small_size)
			create collection_types_to_retrieve.make (small_size)

			to_process_next := new_interval
			to_process := new_interval
			to_finalize := new_interval

			create free_objects.make (default_size)
		end

feature {NONE} -- Data structures

	cache: HASH_TABLE [HASH_TABLE [INTEGER, INTEGER], PS_TYPE_METADATA]
			-- A cache to map a [type, primary_key] tuple to an index in `storage_array'.

	storage_array: SPECIAL [detachable ANY]
			-- An internal storage for objects.
			-- In the area 1 |..| (to_finalize.lower - 1), the array contains a direct
			--		reference to a retrieved objects or a reflector in case of an expanded type.
			-- In the area to_finalize.lower |..| count, the array contains a `PS_OBJECT_READ_DATA'.
			-- To retrieve items only use the two functions `item' and `object_item'.

	free_objects: ARRAYED_STACK [PS_OBJECT_READ_DATA]
			-- A stack of free `PS_OBJECT_READ_DATA' which can be used instead of creating new objects.

feature {PS_ABEL_EXPORT} -- Access

	get_cache: like cache
			-- Get the cache.
			-- Do not manipulate the result!
		do
			Result := cache
		end

	count: INTEGER
			-- The number of objects which are finalized or under construction.

	transaction: PS_INTERNAL_TRANSACTION
			-- The transaction in which the current operation is running.

	connector: PS_READ_REPOSITORY_CONNECTOR
			-- The database backend.

	cache_lookup (primary_key: INTEGER; type: PS_TYPE_METADATA):INTEGER
			-- See if an object of type `type' and with primary key `primary_key' is already loaded.
			-- The result is 0 if no such object exists.
		do
			if attached cache [type] as inner then
				Result := inner [primary_key]
			end
		ensure
			correct: is_valid_index (Result) implies item (Result).primary_key = primary_key and item (Result).type ~ type
		end

	item (index: INTEGER): PS_OBJECT_READ_DATA
			-- Get the object with index `index'.
			-- Use this function for objects not yet finalized.
		do
			check attached {PS_OBJECT_READ_DATA} storage_array [index] as res then
				Result := res
			end
		ensure then
			object_correct: storage_array [index] = Result
		end

	object_item (index: INTEGER): detachable ANY
			-- Get the object with index `index'.
			-- Use this function for finalized objects (i.e. all attributes are set).
			-- The result will be a `REFLECTED_OBJECT' for expanded types.
		require
			in_bounds: 1 <= index and index <= count
			finalized: not is_valid_index (index) -- <==> index < to_finalize.lower
		do
			Result := storage_array [index]
		end

feature {PS_ABEL_EXPORT} -- Status report

	is_valid_index (index: INTEGER): BOOLEAN
			-- Is `index' a valid index?
		do
			Result := 1 <= index and to_finalize.lower <= index and index <= count
		ensure then
			in_set: Result implies to_finalize.has (index) or to_process.has (index) or to_process_next.has (index)
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
					create new_inner_cache.make (default_size)
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
			collection_primaries_to_retrieve.wipe_out
			collection_types_to_retrieve.wipe_out

			to_process_next := new_interval
			to_process := new_interval
			to_finalize := new_interval
		end

feature {PS_ABEL_EXPORT} -- Smart retrieval

	dispatch_retrieve (type: PS_TYPE_METADATA; criterion: PS_CRITERION; is_root_only: BOOLEAN; attributes: PS_IMMUTABLE_STRUCTURE [STRING]; a_transaction: PS_INTERNAL_TRANSACTION): ITERATION_CURSOR [PS_BACKEND_ENTITY]
			-- Retrieve a set of collections or objects (based on the handler for `type').
		local
			found: BOOLEAN
		do
				-- Void safety...
			Result := (create {LINKED_LIST [PS_BACKEND_ENTITY]}.make).new_cursor

				-- First check if a value type handler is responsible for `type'.
			if attached search_value_type_handler (type) then
				Result := connector.retrieve (type, criterion, is_root_only, create {PS_IMMUTABLE_STRUCTURE [STRING]}.make (<<{PS_BACKEND_OBJECT}.value_type_item>>), a_transaction)
				found := True
			end

				-- If not, try to find a handler and decide whether to retrieve objects or collections.
			across
				identity_type_handlers as cursor
			until
				found
			loop
				if cursor.item.can_handle_type (type) then
					found := True
					if cursor.item.is_mapping_to_object then
						Result := connector.retrieve (type, criterion, is_root_only, attributes, a_transaction)
					else
						Result := connector.collection_retrieve (type, is_root_only, a_transaction)
					end
				end
			end

			check handler_found: found end
		end

feature {PS_ABEL_EXPORT} -- Factory functions

	new_object_data (primary_key: INTEGER; type: PS_TYPE_METADATA; level: INTEGER): PS_OBJECT_READ_DATA
			-- Create a new object data with index = `count' + 1 and other data as specified.
		do
			if free_objects.is_empty then
				create Result.make_with_primary_key (count + 1, primary_key, type, level)
			else
				Result := free_objects.item
				free_objects.remove
				Result.reset (count + 1, primary_key, type, level)
			end
		ensure
			index_correct: Result.index = count + 1
			type_correct: Result.type = type
			primary_correct: Result.primary_key = primary_key
			level_correct: Result.level = level
		end

	new_interval: PS_INTEGER_INTERVAL
			-- Create a new empty interval with values [count+1, count]
		do
			create Result.make_new (count+1, count)
		end

	empty_interval: PS_INTEGER_INTERVAL
		do
			create Result.make_new (1, 0)
		end

feature {PS_ABEL_EXPORT} -- Object building

	build (index_set: PS_INTEGER_INTERVAL; a_max_level: INTEGER)
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
					elseif object.is_reflector_initialized then
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
						-- Do not restore the pointer.
						-- The memory address will be very likely invalid, thus
						-- setting the default pointer is the only reasonable choice.
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
					if referee.is_reflector_initialized then
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
					and then (item (second_lvl [value.to_integer]).is_reflector_initialized
						or item (second_lvl [value.to_integer]).is_ignored))
		end

	process_next (key: INTEGER; type: PS_TYPE_METADATA; referer: PS_OBJECT_READ_DATA)
			-- Retrieve the object with primary key `key' and type `type' in the next iteration.
			-- The `referer' denotes the object issuing the request.
		require
			not_in_cache: cache_lookup (key, type) = 0
		local
			object: PS_OBJECT_READ_DATA
		do
				-- Extend the objects list for retrieval
			object := new_object_data (key, type, current_level)
			add_object (object, True)
			to_process_next.extend (count)

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
				collection_primaries_to_retrieve.extend (collection.primary_key)
				collection_types_to_retrieve.extend (collection.type)
			end
		end

feature {NONE} -- Implementation: Loop body

	process_step
			-- Retrieve and build all objects in `to_process'.
			-- Collect all objects to be retrieved in the next iteration in `to_process_next'.
			-- Finish initialization of all objects in `to_finalize'
		require
			cleared_collections: collection_primaries_to_retrieve.is_empty and collection_types_to_retrieve.is_empty
			cleared_objects: object_primaries_to_retrieve.is_empty and object_types_to_retrieve.is_empty
		local
			i: INTEGER
			identifier: NATURAL_64
			object: PS_OBJECT_READ_DATA

			start, stop: INTEGER
			finalize_stop: INTEGER
		do
			start := to_process.lower
			stop := to_process.upper
			finalize_stop := to_finalize.upper

				-- Search for an appropriate handler for all items to be created
			assign_handlers (to_process)

				-- Command the handlers to retrieve their objects.
				-- (Most of them will place an order for a batch retrieve though)
			from
				i := start
			until
				i > stop
			loop
				object := item (i)

				check not_ignored: not object.is_ignored end
				check initialized: object.is_handler_initialized end

				object.handler.retrieve (object, Current)

				i := i + 1
			variant
				(stop + 1) - i
			end

				-- Do a batch retrieve
			process_batch_retrieve

				-- Create the objects, but don't initialize them yet
			from
				i := start
			until
				i > stop
			loop
				object := item (i)

				check not_ignored: not object.is_ignored end
				check initialized: object.is_handler_initialized end

				if attached object.backend_representation then
					object.handler.create_object (object, Current)
				else
					object.ignore
				end

				i := i + 1
			variant
				(stop + 1) - i
			end


				-- Identify and cache the objects
			if not transaction.is_readonly then

				from
					i := start
				until
					i > stop
				loop
					object := item (i)

					if not object.is_ignored and not transaction.repository.is_expanded (object.type.type) then
							-- Identify the object with the id_manager
						transaction.identifier_table.extend (object.reflector.object)

						identifier := transaction.identifier_table.last_identifier
						object.set_identifier (identifier)

							-- Update the ABEL id -> primary key mapping
						transaction.primary_key_table.extend (object.primary_key, identifier)

							-- Update the root status
						check attached object.backend_representation as br then
							transaction.root_flags.force (br.is_root, identifier)
						end
					end
					i := i + 1
				variant
					(stop + 1) - i
				end
			end

				-- Update the references from the last iteration
			from
				i := to_finalize.lower
			until
				i > finalize_stop
			loop
				object := item (i)
				if not object.is_ignored then
					check initialized: object.is_handler_initialized end
					object.handler.finish_initialize (object, Current)
				end

				i := i + 1
			variant
				(finalize_stop + 1) - i
			end


				-- Do some basic initialization and search for objects
				-- which need to be built in the next iteration
			from
				i := start
			until
				i > stop
			loop
				object := item (i)
				if not object.is_ignored then
					check initialized: object.is_handler_initialized end
					object.handler.initialize (object, Current)
				end

				i := i + 1
			variant
				(stop + 1) - i
			end

		end

feature {NONE} -- Implementation: Batch retrieval

	object_primaries_to_retrieve: ARRAYED_LIST [INTEGER]
			-- The primary keys of all objects to be retrieved.

	object_types_to_retrieve: ARRAYED_LIST [PS_TYPE_METADATA]
			-- The types of all objects to be retrieved.

	collection_primaries_to_retrieve: ARRAYED_LIST [INTEGER]
			-- The primary keys of all collections to be retrieved.

	collection_types_to_retrieve: ARRAYED_LIST [PS_TYPE_METADATA]
			-- The types of all collections to be retrieved.

	process_batch_retrieve
			-- Retrieve all objects and collections listed in the respective `*_to_retrieve' lists.
			-- If the entity is present in the database, update the reference in the corresponding
			-- `PS_OBJECT_DATA.backend_representation'.
		local
			retrieved_objects: READABLE_INDEXABLE [PS_BACKEND_OBJECT]
			retrieved_collections: READABLE_INDEXABLE [PS_BACKEND_COLLECTION]
		do

			if not object_primaries_to_retrieve.is_empty then
				retrieved_objects := connector.specific_retrieve (object_primaries_to_retrieve, object_types_to_retrieve, transaction)

				across
					retrieved_objects as obj
				loop
					item (cache_lookup (obj.item.primary_key, obj.item.type)).set_backend_representation (obj.item)
				end
			end

			if not collection_primaries_to_retrieve.is_empty then
				retrieved_collections := connector.specific_collection_retrieve (collection_primaries_to_retrieve, collection_types_to_retrieve, transaction)

				across
					retrieved_collections as coll
				loop
					item (cache_lookup (coll.item.primary_key, coll.item.type)).set_backend_representation (coll.item)
				end
			end

			collection_primaries_to_retrieve.wipe_out
			collection_types_to_retrieve.wipe_out

			object_primaries_to_retrieve.wipe_out
			object_types_to_retrieve.wipe_out

		ensure
			cleared_collections: collection_primaries_to_retrieve.is_empty and collection_types_to_retrieve.is_empty
			cleared_objects: object_primaries_to_retrieve.is_empty and object_types_to_retrieve.is_empty
		end

invariant
	count_correct: count = storage_array.count - 1

	same_count_to_retrieve: object_primaries_to_retrieve.count = object_types_to_retrieve.count
		and collection_primaries_to_retrieve.count = collection_types_to_retrieve.count
end
