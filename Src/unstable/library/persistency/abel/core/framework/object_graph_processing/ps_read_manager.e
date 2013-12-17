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

feature {NONE} -- Initialization

	make (
			a_metadata_factory: like metadata_factory;
			an_id_manager: like id_manager;
			a_primary_key_mapper: like primary_key_mapper;
			a_backend: like backend;
			a_transaction: like transaction)
			-- Initialization for `Current'
		do
			initialize (a_metadata_factory, an_id_manager, a_primary_key_mapper)
			backend := a_backend
			internal_transaction := a_transaction

			create object_storage.make (default_size)
			create cache.make (small_size)

			create objects_to_retrieve.make (small_size)
			create collections_to_retrieve.make (small_size)

			to_process_next := new_interval
			to_process := new_interval
			to_finalize := new_interval
		end


	cache: HASH_TABLE [HASH_TABLE [INTEGER, INTEGER], PS_TYPE_METADATA]
			-- A cache to map a [type, primary_key] tuple to an index in `object_storage'.


feature {PS_ABEL_EXPORT} -- Access

	backend: PS_READ_ONLY_BACKEND
			-- The database backend.


	cache_lookup (primary_key: INTEGER; type: PS_TYPE_METADATA):INTEGER
			-- See if an object of type `type' and with primary key `primary_key' is already loaded.
			-- The result is 0 if no such object exists.
		do
			if attached cache [type] as inner then
				Result := inner [primary_key]
			end
		end

feature {PS_ABEL_EXPORT} -- Element change

	add_object (object: PS_OBJECT_READ_DATA; cached: BOOLEAN)
			-- Add `object' to the object_storage and register it in cache, if `cached' is True.
		require
			correct_index: object.index = count + 1
		local
			new_inner_cache: HASH_TABLE [INTEGER, INTEGER]
		do
			object_storage.extend (object)

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

feature {PS_ABEL_EXPORT} -- Smart retrieval

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
					Result := backend.retrieve (type, criterion, create {PS_IMMUTABLE_STRUCTURE [STRING]}.make (<<{PS_BACKEND_OBJECT}.value_type_item>>), a_transaction)
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
						Result := backend.collection_retrieve (type, a_transaction)
					end
				end
			end

			check handler_found: found end
		end


feature {PS_ABEL_EXPORT} -- Object building

	build (index_set: INDEXABLE [INTEGER, INTEGER]; a_max_level: INTEGER)
			-- Build all items in `index_set'.
		do
			from
				max_level := a_max_level

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


feature {NONE}  -- Object building: loop control variables

	max_level: INTEGER
			-- The maximum object initialization depth.

	current_level: INTEGER
			-- The current object initialization depth.

	to_process_next: INDEXABLE [INTEGER, INTEGER]
			-- The objects to retrieve and build in the next iteration.

	to_process: INDEXABLE [INTEGER, INTEGER]
			-- The objects to retrieve and (partially) build in this iteration.

	to_finalize: INDEXABLE [INTEGER, INTEGER]
			-- The objects from the last iteration which need to be finalized.

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
		require
			not_none: not type.type.name.ends_with ("NONE")
		local
--			referee_index: INTEGER
--			referee: PS_OBJECT_DATA
		do
--			Result := basic_expanded_types.has (type.type.type_id)
--				or else (across value_type_handlers as cursor some cursor.item.can_handle_type (type) end)

--			if not Result then
--				check value_is_primary_key: value.is_integer end

--				referee_index := cache_lookup (value.to_integer, type)

--				if referee_index > 0 then
--					referee := item (referee_index)
--					Result := referee.is_ignored or referee.is_object_initialized
--				end
--			end

			Result := (type.type.is_expanded and then basic_expanded_types.has (type.type.type_id))
				or else (across value_type_handlers as cursor some cursor.item.can_handle_type (type) end)
				or else (attached cache [type] as second_lvl
					and then second_lvl [value.to_integer] > 0
					and then (item (second_lvl [value.to_integer]).is_object_initialized
						or item (second_lvl [value.to_integer]).is_ignored))
		end

	processed_object (value: STRING; type: PS_TYPE_METADATA; referer: PS_OBJECT_READ_DATA): detachable ANY
			-- Get the object identified by the [`value', `type'] tuple.
			-- The object may be served from cache or built on the fly in case of a value type.
			-- The `referer' denotes the object issuing the request.
		require
			buildable: is_processable (value, type)
			not_none: not type.type.name.ends_with ("NONE")
		local
			managed: MANAGED_POINTER
			referee_index: INTEGER
			referee: PS_OBJECT_READ_DATA
		do

			if type.type.is_expanded and then basic_expanded_types.has (type.type.type_id) then
				fixme ("No string comparisons")
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

			elseif attached search_value_type_handler (type) as safe_handler then
				Result := safe_handler.build_from_string (value, type)

			else
				check value_is_primary: value.is_integer end

				referee_index := cache_lookup (value.to_integer, type)

				if referee_index > 0 then
					referee := item (referee_index)
					if not referee.is_ignored then
						Result := referee.reflector.object

							-- The following two lines require about 25% of the total execution time of this function.
							-- They are usually only needed when dealing with relations...
--						referer.references.extend (referee_index)
						referee.set_referer (referer.index)
					end
				end
			end
		end

	process_next (key: INTEGER; type: PS_TYPE_METADATA; referer: PS_OBJECT_READ_DATA)
			-- Retrieve the object with primary key `key' and type `type' in the next iteration.
			-- The `referer' denotes the object issuing the request.
		local
			i: INTEGER
			found: BOOLEAN
		do
				-- First check if the item is not already registered for retrieval
			i := cache_lookup (key, type)
			if i > 0 and then item (i).primary_key = key then
				check
					equal_algorithm:
						to_process_next.has (i)
						and item (i).primary_key = key
						and item (i).type ~ type
				end
				found := True
					-- Update the referers and references tables

					-- The following two lines require about 25% of the total execution time of this function.
					-- They are usually only needed when dealing with relations...

--				referer.references.extend (i)
				item (i).set_referer (referer.index)
			end

				-- Extend the objects list for retrieval
			if not found then
				add_object (create {PS_OBJECT_READ_DATA}.make_with_primary_key (count + 1, key, type, current_level + 1), True)
				to_process_next.extend (count)
					-- Update the referers and references tables

					-- The following two lines require about 25% of the total execution time of this function.
					-- They are usually only needed when dealing with relations...

--				referer.references.extend (count)
				item (count).set_referer (referer.index)
			end
		end


feature {PS_ABEL_EXPORT} -- Handler support: Batch Retrieval


	add_to_object_batch_retrieve (object: PS_OBJECT_READ_DATA)
			-- Register `object' to be added to the next batch retrieval request.
		do
			if not attached object.backend_representation then
				objects_to_retrieve.extend ([object.type, object.primary_key, object.index])
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
			objects_to_retrieve.is_empty
		local
			i: INTEGER
			identifier: PS_OBJECT_IDENTIFIER_WRAPPER
			object: PS_OBJECT_READ_DATA
		do
				-- Search for an appropriate handler for all items to be created
			assign_handlers (to_process)

				-- Command the handlers to retrieve their objects.
				-- (Most of them will place an order for a batch retrieve though)

--			do_all_in_set (agent {PS_HANDLER}.retrieve (?, Current), to_process)
			across
				to_process as idx
			loop
				object := item (idx.item)
				if not object.is_ignored then
					check initialized: object.is_handler_initialized end
					object.handler.retrieve (object, Current)
				end
			end

				-- Do a batch retrieve
			process_batch_retrieve

				-- Create the objects, but don't initialize them yet
--			do_all_in_set (agent {PS_HANDLER}.create_object (?, Current), to_process)
			across
				to_process as idx
			loop
				object := item (idx.item)
				if not object.is_ignored then
					check initialized: object.is_handler_initialized end
					object.handler.create_object (object, Current)
				end
			end


				-- Identify and cache the objects
			if not transaction.is_readonly then

			across
				to_process as idx_cursor
			loop
--				i := idx_cursor.item
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
--			do_all_in_set (agent {PS_HANDLER}.finish_initialize (?, Current), to_finalize)
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
--			do_all_in_set (agent {PS_HANDLER}.initialize (?, Current), to_process)
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

	objects_to_retrieve: ARRAYED_LIST [TUPLE [type:PS_TYPE_METADATA; primary:INTEGER; index:INTEGER]]
			-- All objects to be retrieved in the next batch retrieval operation.

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

			if not objects_to_retrieve.is_empty then
				retrieved_objects := backend.specific_retrieve (objects_to_retrieve, transaction)

				across
					retrieved_objects as obj
				loop
					item (cache_lookup (obj.item.primary_key, obj.item.metadata)).set_backend_representation (obj.item)
				end

				across
					objects_to_retrieve as cursor
				loop
					if not attached item (cursor.item.index).backend_representation then
						item (cursor.item.index).ignore
					end
				end

			end

			if not collections_to_retrieve.is_empty then
				retrieved_collections := backend.specific_collection_retrieve (collections_to_retrieve, transaction)

				across
					retrieved_collections as coll
				loop
					item (cache_lookup (coll.item.primary_key, coll.item.metadata)).set_backend_representation (coll.item)
				end

				across
					collections_to_retrieve as cursor
				loop
					if not attached item (cursor.item.index).backend_representation then
						item (cursor.item.index).ignore
					end
				end

			end

			collections_to_retrieve.wipe_out
			objects_to_retrieve.wipe_out
		ensure
			cleared_arrays: collections_to_retrieve.is_empty and objects_to_retrieve.is_empty
		end

end
