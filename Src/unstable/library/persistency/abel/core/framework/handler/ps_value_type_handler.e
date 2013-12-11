note
	description: "A handler which can map objects to a value (represented as a string)."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	PS_VALUE_TYPE_HANDLER

inherit
	PS_OBJECT_HANDLER
		undefine
			build_from_string, as_string_pair
		redefine
			set_is_persistent, create_object
		end

feature {PS_ABEL_EXPORT} -- Status report

	is_mapping_to_value_type: BOOLEAN = True
			-- Does `Current' map objects to a value type (i.e. STRING)?


feature {PS_ABEL_EXPORT} -- Read functions


	create_object (object: PS_OBJECT_DATA; read_manager: PS_READ_MANAGER)
			-- Try to initialize the `object' as much as possible.
			-- For any referenced object not yet loaded, tell the `read_manager'
			-- to retrieve it in the next iteration.
		local
			pair: TUPLE [value: STRING; type: IMMUTABLE_STRING_8]
			type: PS_TYPE_METADATA
			reflector: REFLECTED_REFERENCE_OBJECT
		do
			pair := object.backend_object.attribute_value (value_type_item)
			type := type_from_string (pair.type)
			if attached build_from_string (pair.value, type) as obj then
				create reflector.make (obj)
				object.set_object (reflector)
			end
		end

	initialize (object: PS_OBJECT_DATA; read_manager: PS_READ_MANAGER)
			-- Try to initialize the `object' as much as possible.
			-- For any referenced object not yet loaded, tell the `read_manager'
			-- to retrieve it in the next iteration.
		do
		end

	finish_initialize (object: PS_OBJECT_DATA; read_manager: PS_READ_MANAGER)
			-- Finish initialization of `object'.
		do
		end

feature {PS_ABEL_EXPORT} -- Write functions

	set_is_persistent (object: PS_OBJECT_DATA)
			-- Set the `is_identified' attribute of `object'.
		local
			i: INTEGER
		do
			if object.index = 1 then
				from
					Precursor (object)
					i := 2
				until
					i > write_manager.count
				loop
					write_manager.item (i).ignore
					i := i + 1
				end
			else
				write_manager.cascading_ignore (object)
			end
		end

	initialize_backend_representation (object: PS_OBJECT_DATA)
			-- Initialize all attributes or items in `object.backend_representation'
		local
			pair: TUPLE [value: STRING; type: IMMUTABLE_STRING_8]
		do
			pair := as_string_pair (object)
			object.backend_object.add_attribute (value_type_item, pair.value, pair.type)
		end

feature {PS_ABEL_EXPORT} -- String pair conversion

	as_string_pair (object: PS_OBJECT_DATA): TUPLE [value: STRING; type: IMMUTABLE_STRING_8]
			-- The `object' as a string pair, i.e. when referenced by another object.
		require else
			can_handle: can_handle_type (object.type)
			value_type_handler: is_mapping_to_value_type
		deferred
		end

end
