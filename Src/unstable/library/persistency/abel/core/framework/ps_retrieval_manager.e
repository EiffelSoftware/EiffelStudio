note
	description: "Responsible for correct retrieval of objects."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

class
	PS_RETRIEVAL_MANAGER

inherit

	PS_EIFFELSTORE_EXPORT

inherit {NONE}

	REFACTORING_HELPER

create
	make

feature {PS_EIFFELSTORE_EXPORT} -- Query execution

	setup_query (query: PS_OBJECT_QUERY [ANY]; transaction: PS_TRANSACTION)
			-- Set up query `query' and retrieve the first result.
		do
			initialize_query (query, create {LINKED_LIST [STRING]}.make, transaction)
			retrieve_until_criteria_match (query, transaction)
		end

	next_entry (query: PS_OBJECT_QUERY [ANY])
			-- Retrieve the next entry of query `query'.
		do
			attach (query_to_cursor_map [query.backend_identifier]).forth
			retrieve_until_criteria_match (query, query.transaction)
		end

	setup_tuple_query (query: PS_TUPLE_QUERY[ANY]; transaction: PS_TRANSACTION)
			-- Set up the query and retrieve the first result
		local
			collector: PS_CRITERION_ATTRIBUTE_COLLECTOR
			thrash:INTEGER
		do
			create collector.make
			thrash := collector.visit (query.criteria)
			collector.attributes.compare_objects
			across query.projection as proj
			loop
				if not collector.attributes.has (proj.item) then
					collector.attributes.extend (proj.item)
				end
			end
			initialize_query (query, collector.attributes, transaction)
			--initialize_query (query, create {LINKED_LIST [STRING]}.make, transaction)
			retrieve_tuples_until_criteria_match (query, transaction)
		end

	next_tuple_entry (query: PS_TUPLE_QUERY [ANY])
			-- Retrieve the next entry of query `query'.
		do
			attach (query_to_cursor_map [query.backend_identifier]).forth
			retrieve_tuples_until_criteria_match (query, query.transaction)
		end

feature {NONE} -- Implementation - Retrieval

	retrieve_until_criteria_match (query: PS_OBJECT_QUERY [ANY]; transaction: PS_TRANSACTION)
			-- Retrieve objects until the criteria in `query.criteria' are satisfied.
		local
			new_object: ANY
			found: BOOLEAN
			type: PS_TYPE_METADATA
			bookkeeping: HASH_TABLE [ANY, INTEGER]
		do
				-- Get the type of objects that the query operates on.
			type := metadata_manager.create_metadata_from_type (query.generic_type)
			bookkeeping := attach (bookkeeping_manager [query.backend_identifier])
				-- Check if we have a query on normal objects or on collections
			if attached {ITERATION_CURSOR [PS_RETRIEVED_OBJECT]} query_to_cursor_map [query.backend_identifier] as results then
					-- Normal objects: Retrieve until criteria match
				from
					found := False
				until
					found or results.after
				loop
					new_object := build_object (type, results.item, transaction, bookkeeping, true)
					if query.criteria.is_satisfied_by (new_object) then
						query.result_cursor.set_entry (new_object)
						found := True
					else
						results.forth
					end
				end
				if results.after then
					query.result_cursor.set_entry (Void)
				end
			else
					-- Collection: Retrieve the next one, as we don't have criteria on collections.
				check attached {ITERATION_CURSOR [PS_RETRIEVED_OBJECT_COLLECTION]} query_to_cursor_map [query.backend_identifier] as direct_collection then
					if direct_collection.after then
						query.result_cursor.set_entry (Void)
					else
						new_object := build_object_collection (type, direct_collection.item, get_handler (type), transaction, bookkeeping)
						query.result_cursor.set_entry (new_object)
					end
				end
			end
		end

	retrieve_tuples_until_criteria_match (query: PS_TUPLE_QUERY [ANY]; transaction: PS_TRANSACTION)
			-- Retrieve objects until the criteria in `query.criteria' are satisfied.

			local
				new_object: ANY
				found: BOOLEAN
				type: PS_TYPE_METADATA
				bookkeeping: HASH_TABLE [ANY, INTEGER]
				tuple: TUPLE
				index, i: INTEGER
			do
					-- Get the type of objects that the query operates on.
				type := metadata_manager.create_metadata_from_type (query.generic_type)
				bookkeeping := attach (bookkeeping_manager [query.backend_identifier])
					-- Check if we have a query on normal objects or on collections
				if attached {ITERATION_CURSOR [PS_RETRIEVED_OBJECT]} query_to_cursor_map [query.backend_identifier] as results then
						-- Normal objects: Retrieve until criteria match
					from
						found := False
					until
						found or results.after
					loop
						fixme ("don't cheat...")
						new_object := build_object (type, results.item, transaction, bookkeeping, false)
						if query.criteria.is_satisfied_by (new_object) then
							-- extract the required information

							check attached {TUPLE} type.reflection.new_instance_of (metadata_manager.generate_tuple_type (type.type, query.projection)) as t then
								tuple := t
							end

							across query.projection as attr_cursor
							from i := 1
							loop
								index := type.field_index (attr_cursor.item)
								tuple.put (type.reflection.field (index, new_object), i)
								i:= i+1
							end

							query.result_cursor.set_entry (tuple)
							found := True
						else
							results.forth
						end
					end
					if results.after then
						query.result_cursor.set_entry (Void)
					end
				end
			end


feature {NONE} -- Implementation: Build functions for PS_RETRIEVED_* objects

	build_object (type: PS_TYPE_METADATA; obj: PS_RETRIEVED_OBJECT; transaction: PS_TRANSACTION; bookkeeping: HASH_TABLE [ANY, INTEGER]; identify:BOOLEAN): ANY
			-- Build the object `obj'.
		require
			obj.class_metadata.name.is_equal (type.base_class.name)
		local
			reflection: INTERNAL
			field_value: ANY
			field_val: detachable ANY
			field_type: PS_TYPE_METADATA
			field_type_name: STRING
			keys: LINKED_LIST [INTEGER]
			referenced_obj: LIST [PS_RETRIEVED_OBJECT]
			collection_result: PS_RETRIEVED_OBJECT_COLLECTION
		do
			if bookkeeping.has (obj.primary_key + obj.class_metadata.name.hash_code) then
				Result := attach (bookkeeping [obj.primary_key + obj.class_metadata.name.hash_code])
			else
				create reflection
				Result := reflection.new_instance_of (type.type.type_id)
				if identify then
					bookkeeping.extend (Result, obj.primary_key + obj.class_metadata.name.hash_code)
					id_manager.identify (Result, transaction)
					backend.add_mapping (id_manager.identifier_wrapper (Result, transaction), obj.primary_key, transaction)
				end
				across
					obj.attributes as attr_cursor
				loop
					-- Sometimes there are attributes in the retrieved data which are not present in the actual object,
					-- e.g. values inserted by plugins. Be tolerant with that.

					if type.has_attribute (attr_cursor.item) then
							-- Set all the attributes
							-- See if it is a basic attribute
						if not try_basic_attribute (Result, obj.attribute_value (attr_cursor.item).value, type.field_index (attr_cursor.item)) then
								-- If not it is either a referenced object or a collection. In either case, use the `Current.build' function.


							--field_type := type.attribute_type (attr_cursor.item)
							-- Important: Use type as stored in the database!
							field_type_name := obj.attribute_value (attr_cursor.item).attribute_class_name
							if not field_type_name.is_equal ("NONE") then
								field_type := metadata_manager.create_metadata_from_type (
									type.reflection.type_of_type (
										type.reflection.dynamic_type_from_string (field_type_name)))


								field_val := build (field_type, obj.attribute_value (attr_cursor.item), transaction, bookkeeping)
								if attached field_val then
										--print (reflection.field_name (type.field_index (attr_cursor.item), Result).out + "%N")
										--print (type.type.out + field_type.type.out + "%N")
									reflection.set_reference_field (type.field_index (attr_cursor.item), Result, field_val)
								end
							end
						end
					end
				end
			end
		ensure
			type_correct: Result.generating_type.type_id = type.type.type_id
		end

	build_relational_collection (type: PS_TYPE_METADATA; relational_collection: PS_RETRIEVED_RELATIONAL_COLLECTION; handler: PS_COLLECTION_HANDLER [ITERABLE [detachable ANY]]; transaction: PS_TRANSACTION; bookkeeping: HASH_TABLE [ANY, INTEGER]): ANY
			-- Build a new collection object from the retrieved collection `relational_collection'.
		do
			Result := handler.build_relational_collection (type, build_collection_items (type, relational_collection, transaction, bookkeeping))
			id_manager.identify (Result, transaction)
		end

	build_object_collection (type: PS_TYPE_METADATA; object_collection: PS_RETRIEVED_OBJECT_COLLECTION; handler: PS_COLLECTION_HANDLER [ITERABLE [detachable ANY]]; transaction: PS_TRANSACTION; bookkeeping: HASH_TABLE [ANY, INTEGER]): ANY
			-- Build a new collection object from the retrieved collection `object_collection'.
		do
			Result := handler.build_collection (type, build_collection_items (type, object_collection, transaction, bookkeeping), object_collection)
			id_manager.identify (Result, transaction)
		end

feature {NONE} -- Implementation - Build support functions.

	build (type: PS_TYPE_METADATA; value: PS_PAIR [STRING, STRING]; transaction: PS_TRANSACTION; bookkeeping: HASH_TABLE [ANY, INTEGER]): detachable ANY
			-- Build an object based on the type.
		local
			object_result: detachable PS_RETRIEVED_OBJECT
			collection_result: detachable PS_RETRIEVED_OBJECT_COLLECTION
			managed: MANAGED_POINTER
		do
			if type.is_basic_type then
					-- Create a basic type
				if type.type.name.is_equal ("STRING_8") then
					Result := value.first
				elseif type.type.name.is_equal ("STRING_32") then
					Result := value.first.as_string_32
				elseif type.type.name.is_equal ("INTEGER_8") then
					Result := value.first.to_integer_8
				elseif type.type.name.is_equal ("INTEGER_16") then
					Result := value.first.to_integer_16
				elseif type.type.name.is_equal ("INTEGER_32") then
					Result := value.first.to_integer_32
				elseif type.type.name.is_equal ("INTEGER_64") then
					Result := value.first.to_integer_64
				elseif type.type.name.is_equal ("NATURAL_8") then
					Result := value.first.to_natural_8
				elseif type.type.name.is_equal ("NATURAL_16") then
					Result := value.first.to_natural_16
				elseif type.type.name.is_equal ("NATURAL_32") then
					Result := value.first.to_natural_32
				elseif type.type.name.is_equal ("NATURAL_64") then
					Result := value.first.to_natural_64
				elseif type.type.name.is_equal ("REAL_32") then
--					Result := value.first.to_real
					create managed.make ({PLATFORM}.real_32_bytes)
					managed.put_integer_32_be (value.first.to_integer_32, 0)
					Result := managed.read_real_32_be (0)
				elseif type.type.name.is_equal ("REAL_64") then
--					Result := value.first.to_double
					create managed.make ({PLATFORM}.real_64_bytes)
					managed.put_integer_64_be ( value.first.to_integer_64, 0)
					Result := managed.read_real_64_be (0)
				elseif type.type.name.is_equal ("BOOLEAN") then
					Result := value.first.to_boolean
				elseif type.type.name.is_equal ("CHARACTER_8") then
					Result := value.first.to_natural_8.to_character_8
				elseif type.type.name.is_equal ("CHARACTER_32") then
					Result := value.first.to_natural_32.to_character_32
				elseif type.type.name.is_equal ("NONE") then
					Result := Void
				else
					check
						unknown_basic_type: False
					end
					Result := 0
				end
			elseif has_handler (type) then
				if backend.is_generic_collection_supported then
						-- Build a collection
					collection_result := backend.retrieve_collection (type, value.first.to_integer, transaction)
					if attached collection_result then
						Result := build_object_collection (type, collection_result, get_handler (type), transaction, bookkeeping)
					end
				else
					fixme ("TODO: error")
					check not_implemented: false end
				end
			else
					-- Build a new object
				if not value.first.is_empty then
					object_result := backend.retrieve_by_primary (type, value.first.to_integer, type.attributes.deep_twin, transaction)
					if attached object_result then
						Result := build_object (type, object_result, transaction, bookkeeping, true)
					end
				end
			end
		end

	build_collection_items (type: PS_TYPE_METADATA; collection: PS_RETRIEVED_COLLECTION; transaction: PS_TRANSACTION; bookkeeping: HASH_TABLE [ANY, INTEGER]): LINKED_LIST [detachable ANY]
			-- Build a list with all collection items correctly loaded.
		local
			collection_items: LINKED_LIST [detachable ANY]
			retrieved_item: LIST [PS_RETRIEVED_OBJECT]
			item: detachable ANY
		do
				-- Build every object of the list and store it in collection_items
			create Result.make
			across
				collection.collection_items as items
			loop
				item := build (type.actual_generic_parameter (1), items.item, transaction, bookkeeping)
				Result.extend (item)
			end
		end

	try_basic_attribute (obj: ANY; value: STRING; index: INTEGER): BOOLEAN
			-- See if field at `index' is of basic type, and if so, initialize it.
		local
			type: INTEGER
			reflection: INTERNAL
			type_name: STRING
		do
			create reflection
			type := reflection.field_type (index, obj)
			if type /= reflection.reference_type and type /= reflection.pointer_type then -- check if it is a basic type (except strings)
				set_expanded_attribute (obj, value, index)
				Result := True
			else
					-- check if it's a string
				type_name := reflection.class_name_of_type (reflection.field_static_type_of_type (index, reflection.dynamic_type (obj)))
				if type_name.is_case_insensitive_equal ("STRING_32") then
					reflection.set_reference_field (index, obj, value.to_string_32)
					Result := True
				elseif type_name.is_case_insensitive_equal ("STRING_8") then
					reflection.set_reference_field (index, obj, value.twin)
					Result := True
				else
						-- Not of a basic type - return false
					Result := False
				end
			end
		end

	set_expanded_attribute (obj: ANY; value: STRING; index: INTEGER)
			-- Set the attribute `index' of type `type' of object obj to value `generic_value'.
		local
			type: INTEGER
			reflection: INTERNAL
			managed: MANAGED_POINTER
		do
			create reflection
			type := reflection.field_type (index, obj)
				-- Integers
			if type = reflection.integer_8_type and value.is_integer_8 then
				reflection.set_integer_8_field (index, obj, value.to_integer_8)
			elseif type = reflection.integer_16_type and value.is_integer_16 then
				reflection.set_integer_16_field (index, obj, value.to_integer_16)
			elseif type = reflection.integer_32_type and value.is_integer_32 then
				reflection.set_integer_32_field (index, obj, value.to_integer_32)
			elseif type = reflection.integer_64_type and value.is_integer_64 then
				reflection.set_integer_64_field (index, obj, value.to_integer_64)
					-- Naturals
			elseif type = reflection.natural_8_type and value.is_natural_8 then
				reflection.set_natural_8_field (index, obj, value.to_natural_8)
			elseif type = reflection.natural_16_type and value.is_natural_16 then
				reflection.set_natural_16_field (index, obj, value.to_natural_16)
			elseif type = reflection.natural_32_type and value.is_natural_32 then
				reflection.set_natural_32_field (index, obj, value.to_natural_32)
			elseif type = reflection.natural_64_type and value.is_natural_64 then
				reflection.set_natural_64_field (index, obj, value.to_natural_64)

					-- Reals
			elseif type = reflection.real_32_type and value.is_integer_32 then

				create managed.make ({PLATFORM}.real_32_bytes)
				managed.put_integer_32_be (value.to_integer_32, 0)
				reflection.set_real_32_field (index, obj, managed.read_real_32_be (0))

			elseif type = reflection.double_type and value.is_integer_64 then
				create managed.make ({PLATFORM}.real_64_bytes)
				managed.put_integer_64_be ( value.to_integer_64, 0)
				reflection.set_double_field (index, obj, managed.read_real_64_be (0))

					-- Characters
			elseif type = reflection.character_8_type and value.is_natural_8 then
				reflection.set_character_8_field (index, obj, value.to_natural_8.to_character_8)
			elseif type = reflection.character_32_type and value.is_natural_32 then
				reflection.set_character_32_field (index, obj, value.to_natural_32.to_character_32)
					-- Boolean
			elseif type = reflection.boolean_type and value.is_boolean then
				reflection.set_boolean_field (index, obj, value.to_boolean)
			else
				fixme ("TODO: throw error")
			end
		end

feature {NONE} -- Implementation: Collection handlers

	collection_handlers: LINKED_LIST [PS_COLLECTION_HANDLER [ITERABLE [detachable ANY]]]
			-- All registered collection handlers.

	has_handler (type: PS_TYPE_METADATA): BOOLEAN
			-- Is `type' a collection that has a handler?
		do
			Result := across collection_handlers as handler some handler.item.can_handle_type (type) end
		end

	get_handler (type: PS_TYPE_METADATA): PS_COLLECTION_HANDLER [ITERABLE [detachable ANY]]
			-- Get the handler for collections of type `type'.
		require
			has_handler (type)
		local
			res: detachable PS_COLLECTION_HANDLER [ITERABLE [detachable ANY]]
		do
			across
				collection_handlers as handler
			loop
				if handler.item.can_handle_type (type) then
					res := handler.item
				end
			end
			Result := attach (res)
		end

feature {NONE} -- Implementation: Query initialization

	initialize_query (query: PS_QUERY [ANY]; some_attributes: LIST [STRING]; transaction: PS_TRANSACTION)
			-- Initialize query - Set an identifier, initialize with bookkeeping manager and execute against backend.
		local
			results: ITERATION_CURSOR [ANY]
			bookkeeping_table: HASH_TABLE [ANY, INTEGER]
			type: PS_TYPE_METADATA
			attributes: LIST [STRING]
		do
			query.set_identifier (new_query_identifier)
			query.register_as_executed (transaction)
			type := metadata_manager.create_metadata_from_type (query.generic_type)

			if some_attributes.is_empty then
				attributes := type.attributes.twin
			else
				attributes := some_attributes
			end

			if has_handler (type) then
				if backend.is_generic_collection_supported then
					results := backend.retrieve_all_collections (type, transaction)
				else
					fixme ("TODO: error")
					check not_implemented:false then results := attributes.new_cursor end
				end
			else
				results := backend.retrieve (type, query.criteria, attributes, transaction)
			end
			query_to_cursor_map.extend (results, query.backend_identifier)
			create bookkeeping_table.make (100)
			bookkeeping_manager.extend (bookkeeping_table, query.backend_identifier)
		end

	new_query_identifier: INTEGER
			-- Get a new identifier for a query.
		do
			Result := next_query_identifier
			next_query_identifier := next_query_identifier + 1
		end

	next_query_identifier: INTEGER
			-- The next identifier number

feature {NONE} -- Implementation - Core data structures

	metadata_manager: PS_METADATA_FACTORY
			-- Creates metadata for types.

	id_manager: PS_OBJECT_IDENTIFICATION_MANAGER
			-- A reference to the main object identification manager.

	query_to_cursor_map: HASH_TABLE [ITERATION_CURSOR [ANY], INTEGER]
			-- Has a result cursor (as returned from the storage backend) for every executed query.

	bookkeeping_manager: HASH_TABLE [HASH_TABLE [ANY, INTEGER], INTEGER]
			-- Keeps track of already loaded object for each query.

feature {NONE} -- Initialization

	make (a_backend: PS_NEW_BACKEND; an_id_manager: PS_OBJECT_IDENTIFICATION_MANAGER)
			-- Initialize `Current'.
		do
			backend := a_backend
			id_manager := an_id_manager
			create query_to_cursor_map.make (100)
			create bookkeeping_manager.make (100)
			create collection_handlers.make
			create metadata_manager.make
		end

	backend: PS_NEW_BACKEND
			-- The storage backend.

feature {PS_REPOSITORY} -- Initialization - Collection handlers

	add_handler (a_handler: PS_COLLECTION_HANDLER [ITERABLE [detachable ANY]])
			-- Add a collection handler to `Current'.
		do
			collection_handlers.extend (a_handler)
		end

end
