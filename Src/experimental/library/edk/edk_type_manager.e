note
	description: "Summary description for {EDK_TYPE_REGISTRATION}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

frozen class
	EDK_TYPE_MANAGER

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
			registered_window_types.compare_objects
		end

feature {EDK_WINDOW}

	register_window (a_window_type: EDK_WINDOW)
			-- Register type of `Current'
		local
			l_current_type_id: INTEGER
			l_window_type: detachable TYPE [EDK_WINDOW]
			l_namespace: STRING
			l_type_registration: EDK_TYPE_REGISTRATION
		do
			l_window_type ?= type_of (a_window_type)
			check l_window_type /= Void end
			l_current_type_id := dynamic_type (a_window_type)
			if not registered_window_types.has (l_window_type) then
				registered_window_types.extend (l_window_type)

					-- Create namespace from type
				l_namespace := a_window_type.generating_type.as_lower

				create l_type_registration.make (l_window_type)
				a_window_type.register_messages (l_type_registration)
				a_window_type.register_properties (l_type_registration)

				a_window_type.set_property_structure (l_type_registration.default_data_structure)
			end
		end

feature {NONE} -- Implementation

	registered_window_types: ARRAYED_LIST [TYPE [EDK_WINDOW]]
		-- Search table for registered types.
		--| FIXME IEK Change to hash/search table when TYPE is hashable and access is reentrant.

feature {EDK_TYPE_REGISTRATION, EDK_PROPERTY_ATTRIBUTES} -- External

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
