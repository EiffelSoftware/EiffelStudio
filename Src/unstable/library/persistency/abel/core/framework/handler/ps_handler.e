note
	description: "[
	Provides the handler interface. 
	The descendants each take care of a specific object type and are used by the read-write mechanism"
	]"
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	PS_HANDLER

inherit

	PS_ABEL_EXPORT
		redefine
			default_create
		end

	PS_TYPE_TABLE
		undefine
			default_create
		end

feature {NONE} -- Initialization

	default_create
			-- Initialization for `Current'
		do
			create internal_lib
			none_string := "NONE"
		end

	make (a_write_manager: PS_WRITE_MANAGER)
			-- Initialization for `Current'
		do
			create internal_lib
			none_string := "NONE"
			internal_write_manager := a_write_manager
		end

feature {PS_ABEL_EXPORT} -- Initialization

	set_write_manager (a_write_manager: PS_WRITE_MANAGER)
			-- Set `write_manager' to `a_write_manager'.
		do
			internal_write_manager := a_write_manager
		end

feature {PS_ABEL_EXPORT} -- Access

	write_manager: PS_WRITE_MANAGER
			-- The write manager.
		do
			check attached internal_write_manager as wm then
				Result := wm
			end
		end

	internal_lib: INTERNAL
			-- An {INTERNAL} library instance.

	none_string: IMMUTABLE_STRING_8
			-- The type string for {NONE}.

feature {PS_ABEL_EXPORT} -- Status report


	can_handle (object: PS_OBJECT_DATA): BOOLEAN
			-- Can `Current' handle the object `object'?
		do
			Result := internal_can_handle_type (object.type)
			-- Note: In case you redefine this function because your handler cannot decide based on a type only,
			-- also redefine internal_can_handle_type to return always False.
		end

	frozen can_handle_type (type: PS_TYPE_METADATA): BOOLEAN
			-- Can `Current' handle objects of type `type'?
		do
			Result := internal_can_handle_type (type)
		end

	is_mapping_to_object: BOOLEAN
			-- Does `Current' map objects to a {PS_BACKEND_OBJECT}?
		deferred
		end

	is_mapping_to_collection: BOOLEAN
			-- Does `Current' map objects to a {PS_BACKEND_COLLECTION}?
		deferred
		end

	is_mapping_to_value_type: BOOLEAN
			-- Does `Current' map objects to a value type (i.e. {STRING_8})?
		deferred
		end

feature {PS_ABEL_EXPORT} -- Read functions

	retrieve (object: PS_OBJECT_READ_DATA; read_manager: PS_READ_MANAGER)
			-- Retrieve `object' from the database.
		require
			has_primary: object.primary_key > 0
			can_handle: can_handle (object)
			not_ignored: not object.is_ignored
			not_value_type_or_first: not is_mapping_to_value_type or object.index = 1
		deferred
		end

	create_object (object: PS_OBJECT_READ_DATA; read_manager: PS_READ_MANAGER)
			-- Create a new, uninitialized Eiffel object instance for `object'.
		require
			can_handle: can_handle (object)
			not_ignored: not object.is_ignored
			not_value_type_or_first: not is_mapping_to_value_type or object.index = 1
			object_retrieved: is_mapping_to_object implies attached {PS_BACKEND_OBJECT} object.backend_representation
			collection_retrieved: is_mapping_to_collection implies attached {PS_BACKEND_COLLECTION} object.backend_representation
		local
			new_instance: detachable ANY
			reflector: REFLECTED_REFERENCE_OBJECT
		do
				-- Create object
			new_instance := internal_lib.new_instance_of (object.type.type.type_id)
			object.set_object (new_instance)
		ensure
			built: object.is_reflector_initialized
		end

	initialize (object: PS_OBJECT_READ_DATA; read_manager: PS_READ_MANAGER)
			-- Try to initialize the `object' as much as possible.
			-- For any referenced object not yet loaded, tell the `read_manager'
			-- to retrieve it in the next iteration.
		require
			can_handle: can_handle (object)
			not_ignored: not object.is_ignored
			not_value_type_or_first: not is_mapping_to_value_type or object.index = 1
			object_retrieved: is_mapping_to_object implies attached {PS_BACKEND_OBJECT} object.backend_representation
			collection_retrieved: is_mapping_to_collection implies attached {PS_BACKEND_COLLECTION} object.backend_representation
			created: object.is_reflector_initialized
		deferred
		end

	finish_initialize (object: PS_OBJECT_READ_DATA; read_manager: PS_READ_MANAGER)
			-- Finish initialization of `object'.
		require
			can_handle: can_handle (object)
			not_ignored: not object.is_ignored
			not_value_type_or_first: not is_mapping_to_value_type or object.index = 1
			object_retrieved: is_mapping_to_object implies attached {PS_BACKEND_OBJECT} object.backend_representation
			collection_retrieved: is_mapping_to_collection implies attached {PS_BACKEND_COLLECTION} object.backend_representation
			created: object.is_reflector_initialized
		deferred
		end

feature {PS_ABEL_EXPORT} -- Write functions

	set_is_persistent (object: PS_OBJECT_WRITE_DATA)
			-- Set the `is_identified' attribute of `object'.
		require
			can_handle: can_handle (object)
			not_ignored: not object.is_ignored
		do
			object.set_is_persistent (write_manager.transaction.identifier_table [object.reflector.object] /= 0)
		end

	set_identifier (object: PS_OBJECT_WRITE_DATA)
			-- Set the {PS_OBJECT_WRITE_DATA}.identifier of `object'.
		require
			can_handle: can_handle (object)
			not_ignored: not object.is_ignored
			not_value_type_or_first: not is_mapping_to_value_type or object.index = 1
		do
			if not write_manager.transaction.repository.is_expanded (object.type.type) then
				if not object.is_persistent then
					write_manager.transaction.identifier_table.extend (object.reflector.object)
				end
				object.set_identifier (write_manager.transaction.identifier_table [object.reflector.object])
			else
				object.set_identifier (write_manager.transaction.identifier_table.new_identifier)
			end
		ensure
			identifier_set: object.identifier > 0
		end

	generate_primary_key (object: PS_OBJECT_WRITE_DATA)
			-- Generate a primary key for `object'.
			-- If the object is not yet persistent, create a new primary key in the backend.
		require
			can_handle: can_handle (object)
			not_ignored: not object.is_ignored
			not_value_type_or_first: not is_mapping_to_value_type or object.index = 1
			identifier_set: object.identifier > 0
		deferred
		end

	generate_backend_representation (object: PS_OBJECT_WRITE_DATA)
			-- Create a new, uninitialized `backend_representation' for `object'.
		require
			can_handle: can_handle (object)
			not_ignored: not object.is_ignored
			not_value_type_or_first: not is_mapping_to_value_type or object.index = 1
			identifier_set: object.identifier > 0
		deferred
		ensure
			object_generated: is_mapping_to_object implies attached {PS_BACKEND_OBJECT} object.backend_representation
			collection_generated: is_mapping_to_collection implies attached {PS_BACKEND_COLLECTION} object.backend_representation
			attached_anyway: attached object.backend_representation as rep
			type_set: rep.type = object.type
			primary_key_set: rep.primary_key > 0
			empty_object: is_mapping_to_object implies object.backend_object.attributes.is_empty
			empty_collection: is_mapping_to_collection implies object.backend_collection.is_empty
		end

	initialize_backend_representation (object: PS_OBJECT_WRITE_DATA)
			-- Initialize all attributes or items in `object.backend_representation'
		require
			can_handle: can_handle (object)
			not_ignored: not object.is_ignored
			not_value_type_or_first: not is_mapping_to_value_type or object.index = 1
			identifier_set: object.identifier > 0
			object_generated: is_mapping_to_object implies attached {PS_BACKEND_OBJECT} object.backend_representation
			collection_generated: is_mapping_to_collection implies attached {PS_BACKEND_COLLECTION} object.backend_representation
			attached_anyway: attached object.backend_representation as rep
			type_set: rep.type = object.type
			primary_key_set: rep.primary_key > 0
			empty_object: is_mapping_to_object implies object.backend_object.attributes.is_empty
			empty_collection: is_mapping_to_collection implies object.backend_collection.is_empty
		deferred
		end

	write_backend_representation (object: PS_OBJECT_WRITE_DATA)
			-- Write `object.backend_representation' to the database.
		require
			can_handle: can_handle (object)
			not_ignored: not object.is_ignored
			not_value_type_or_first: not is_mapping_to_value_type or object.index = 1
			identifier_set: object.identifier > 0
			object_generated: is_mapping_to_object implies attached {PS_BACKEND_OBJECT} object.backend_representation
			collection_generated: is_mapping_to_collection implies attached {PS_BACKEND_COLLECTION} object.backend_representation
			attached_anyway: attached object.backend_representation as rep
			type_set: rep.type = object.type
			primary_key_set: rep.primary_key > 0
		deferred
		end

feature {PS_ABEL_EXPORT} -- String conversion

	as_string (object: PS_OBJECT_DATA): STRING
			-- The `object' as a string pair, i.e. when referenced by another object.
		require
			can_handle: can_handle (object)
			not_ignored: not object.is_ignored
			backend_rep_initialized: attached object.backend_representation as rep
			type_set: rep.type = object.type
			primary_key_set: rep.primary_key > 0
		do
			check from_precondition: attached object.backend_representation as rep then
				Result := rep.primary_key.out
			end
		end

	build_from_string (value: STRING; type: PS_TYPE_METADATA): detachable ANY
			-- Create an object from a value type.
		require
			is_value_type_handler: is_mapping_to_value_type
			can_handle: can_handle_type (type)
		do
		end

feature {NONE} -- Implementation

	basic_attribute_value (represented_object: ANY): STRING
			-- The value of the basic attribute as a string.
		local
			managed: MANAGED_POINTER
		do
			if attached {CHARACTER_8} represented_object as char then
				Result := char.natural_32_code.out
			elseif attached {CHARACTER_32} represented_object as char then
				Result := char.natural_32_code.out
			elseif attached {REAL_32} represented_object as real then
				create managed.make ({PLATFORM}.real_32_bytes)
				managed.put_real_32_be (real, 0)
				Result := managed.read_integer_32_be (0).out

--				Reversed:
--				managed.put_integer_32_be (Result.to_integer, 0)
--				real := managed.read_real_32_be (0)

			elseif attached {REAL_64} represented_object as real then
				create managed.make ({PLATFORM}.real_64_bytes)
				managed.put_real_64_be (real, 0)
				Result := managed.read_integer_64_be (0).out
			else
				Result := represented_object.out
			end
		end

	type_from_string (type_string: STRING): PS_TYPE_METADATA
			-- Return a {PS_TYPE_METADATA} for the type denoted by `type_string'.
		local
			type_id: INTEGER
		do
			type_id := internal_lib.dynamic_type_from_string (type_string)
			Result := write_manager.type_factory.create_metadata_from_type_id (type_id)
		end

feature {NONE} -- Impementation

	internal_can_handle_type (type: PS_TYPE_METADATA): BOOLEAN
			-- Can `Current' handle objects of type `type'?
		deferred
		end

	internal_write_manager: detachable PS_WRITE_MANAGER
			-- A write manager.
		note
			option: stable
		attribute
		end

end
