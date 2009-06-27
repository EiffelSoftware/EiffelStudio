note
	description: "Summary description for {EDK_TYPE_REGISTRATION}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

frozen class
	EDK_TYPE_REGISTRATION

inherit
	INTERNAL
		redefine
			default_create
		end

feature {NONE} -- Initialization

	default_create
			-- Create and initialize type registration helper
		do
			create registered_window_types.make (10)
		end

feature

	registered_window_types: ARRAYED_LIST [TYPE [EDK_WINDOW]]
		-- Search table for registered types.

	register_window (a_window_type: EDK_WINDOW)
			-- Register type of `Current'
		local
			l_current_type_id, l_current_field_type_id: INTEGER
			i, l_field_count: INTEGER
			l_window_type: detachable TYPE [EDK_WINDOW]
			l_namespace: STRING
		do
			l_window_type ?= type_of (a_window_type)
			check l_window_type /= Void end
			if not registered_window_types.has (l_window_type) then
				registered_window_types.extend (l_window_type)

					-- Create namespace from type
				l_namespace := a_window_type.generating_type.as_lower

				a_window_type.register_messages (Current)
				a_window_type.register_properties (Current)
			end

			l_current_type_id := dynamic_type (a_window_type)
			l_field_count := field_count_of_type (l_current_type_id)
		end

	register_message_with_window (a_event: EDK_MESSAGE; a_window: EDK_WINDOW)
		do

		end

	register_message_data (message_name: STRING_8; data_type: TYPE [ANY]; meta_data_type: TYPE [detachable ANY])
		local
			l_edk_string: EDK_LOW_LEVEL_STRING
			l_message_code: NATURAL_32
		do
			create l_edk_string.make (message_name)
				-- Register interprocess message value.
			l_message_code := c_native_register_message_type (l_edk_string.item)
			print ("Received a message code of " + l_message_code.out + "%N")
		end

	register_property_data (property_name: STRING_8; data_type: TYPE [ANY]; meta_data_type: TYPE [detachable ANY]; a_writable: BOOLEAN)
		do

		end

feature {NONE} -- External

	frozen c_native_register_message_type (a_str_pointer: POINTER): NATURAL_32
		external
			"C inline use <edk.h>"
		alias
			"[
				#if EIF_OS = EIF_WINNT
  					return RegisterWindowMessage ((LPCTSTR) $a_str_pointer);
				#endif

				// For X11 retrieve an atom from the string pointer and convert to uint.
			]"
		end


end
