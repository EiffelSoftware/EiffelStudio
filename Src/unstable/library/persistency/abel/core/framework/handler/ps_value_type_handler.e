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
			build_from_string, as_string
		redefine
			set_is_persistent, create_object
		end

feature {PS_ABEL_EXPORT} -- Status report

	is_mapping_to_value_type: BOOLEAN = True
			-- <Precursor>

feature {PS_ABEL_EXPORT} -- Read functions

	create_object (object: PS_OBJECT_READ_DATA; read_manager: PS_READ_MANAGER)
			-- <Precursor>
		local
			pair: TUPLE [value: STRING; type: IMMUTABLE_STRING_8]
			type: PS_TYPE_METADATA
			reflector: REFLECTED_REFERENCE_OBJECT
		do
			pair := object.backend_object.attribute_value ({PS_BACKEND_OBJECT}.value_type_item)
			type := type_from_string (pair.type)
			if attached build_from_string (pair.value, type) as obj then
				create reflector.make (obj)
				object.set_reflector (reflector)
			end
		end

	initialize (object: PS_OBJECT_READ_DATA; read_manager: PS_READ_MANAGER)
			-- <Precursor>
		do
		end

	finish_initialize (object: PS_OBJECT_READ_DATA; read_manager: PS_READ_MANAGER)
			-- <Precursor>
		do
		end

feature {PS_ABEL_EXPORT} -- Write functions

	set_is_persistent (object: PS_OBJECT_WRITE_DATA)
			-- <Precursor>
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

	initialize_backend_representation (object: PS_OBJECT_WRITE_DATA)
			-- <Precursor>
		local
			value: STRING
		do
			value := as_string (object)
			object.backend_object.add_attribute ({PS_BACKEND_OBJECT}.value_type_item, value, object.type.name)
		end

feature {PS_ABEL_EXPORT} -- String conversion

	as_string (object: PS_OBJECT_DATA): STRING
			-- <Precursor>
		require else
			can_handle: can_handle_type (object.type)
			value_type_handler: is_mapping_to_value_type
		deferred
		end

end
