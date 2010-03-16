note
	description: "Summary description for {EDK_PROPERTY_ATTRIBUTES}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EDK_PROPERTY_ATTRIBUTES


create
	make

feature {NONE} -- Initialization

	make (a_name: STRING_8; a_is_property: BOOLEAN; a_read_only: BOOLEAN; a_type: like type; a_meta_data_type: like meta_data_type)
		do
			is_property := a_is_property
			read_only := a_read_only
			name := a_name
			type := a_type
			meta_data_type := a_meta_data_type
		end

feature -- Access

	is_property: BOOLEAN
		-- Does `Current' represent a property?
		-- If False it represents a message.

	name: STRING_8
		-- Name of property/message.

	type: TYPE [detachable ANY]
		-- Type used as value for property.

	meta_data_type: TYPE [detachable ANY]
		-- Type of meta-data used for property.

	read_only: BOOLEAN
		-- Is property 'read_only'

feature {NONE} -- Session code

	session_code: NATURAL_32
			-- Code used for sending data to and from `Current'
		do
			if session_code_internal = default_pointer then
				session_code_internal := session_code_internal + session_code_from_name (name)
			end
			Result := session_code_internal.to_integer_32.as_natural_32
		end

	session_code_from_name (a_name: STRING_8): INTEGER_32
			-- Retrieve a session code for `a_name'
			-- Used for intra/inter process communication.
		local
			l_edk_string: EDK_LOW_LEVEL_STRING
		do
			create l_edk_string.make (a_name)
				-- Register interprocess message value.
			Result := {EDK_TYPE_MANAGER}.c_native_register_message_type (l_edk_string.item).as_integer_32
		end

	session_code_internal: POINTER
		-- Pointer used to store session code

end
