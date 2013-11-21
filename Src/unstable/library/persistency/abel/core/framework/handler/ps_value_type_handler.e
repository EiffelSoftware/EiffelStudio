note
	description: "A handler which can map objects to a value (represented as a string)."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	PS_VALUE_TYPE_HANDLER

inherit
	PS_HANDLER
		undefine
			build_from_string, as_string_pair
		redefine
			set_is_persistent
		end

feature {PS_ABEL_EXPORT} -- Status report

	is_mapping_to_object: BOOLEAN = False
			-- Does `Current' map objects to a {PS_RETRIEVED_OBJECT}?

	is_mapping_to_collection: BOOLEAN = False
			-- Does `Current' map objects to a {PS_RETRIEVED_OBJECT_COLLECTION}?

	is_mapping_to_value_type: BOOLEAN = True
			-- Does `Current' map objects to a value type (i.e. STRING)?


feature {PS_ABEL_EXPORT} -- Read functions


	retrieve (object: PS_OBJECT_DATA; read_manager: PS_READ_MANAGER)
			-- Retrieve `object' from the database.
		do
			check internal_error: False end
		end

	initialize (object: PS_OBJECT_DATA; read_manager: PS_READ_MANAGER)
			-- Try to initialize the `object' as much as possible.
			-- For any referenced object not yet loaded, tell the `read_manager'
			-- to retrieve it in the next iteration.
		do
			check internal_error: False end
		end

	finish_initialize (object: PS_OBJECT_DATA; read_manager: PS_READ_MANAGER)
			-- Finish initialization of `object'.
		do
			check internal_error: False end
		end

feature {PS_ABEL_EXPORT} -- Write functions

	set_is_persistent (object: PS_OBJECT_DATA)
			-- Set the `is_identified' attribute of `object'.
		do
			write_manager.cascading_ignore (object)
		end

	generate_primary_key (object: PS_OBJECT_DATA)
			-- Generate a primary key for `object'.
			-- If the object is not yet persistent, create a new primary key in the backend.
		do
			check internal_error: False end
		end

	generate_backend_representation (object: PS_OBJECT_DATA)
			-- Create a new, uninitialized `backend_representation' for `object'.
		do
			check internal_error: False end
		end

	initialize_backend_representation (object: PS_OBJECT_DATA)
			-- Initialize all attributes or items in `object.backend_representation'
		do
			check internal_error: False end
		end

	write_backend_representation (object: PS_OBJECT_DATA)
			-- Write `object.backend_representation' to the database.
		do
			check internal_error: False end
		end

feature {PS_ABEL_EXPORT} -- String pair conversion

	as_string_pair (object: PS_OBJECT_DATA): TUPLE[value: STRING; type: IMMUTABLE_STRING_8]
			-- The `object' as a string pair, i.e. when referenced by another object.
		require else
			can_handle: can_handle_type (object.type)
			value_type_handler: is_mapping_to_value_type
		deferred
		end

end
