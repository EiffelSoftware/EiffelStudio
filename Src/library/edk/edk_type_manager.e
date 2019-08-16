note
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
			l_type_registration: EDK_TYPE_REGISTRATION
		do
			if attached {TYPE [EDK_WINDOW]} type_of (a_window_type) as l_window_type then
				l_current_type_id := dynamic_type (a_window_type)
				if not registered_window_types.has (l_window_type) then
					registered_window_types.extend (l_window_type)

					create l_type_registration.make (l_window_type)
					a_window_type.register_messages (l_type_registration)
					a_window_type.register_properties (l_type_registration)

					a_window_type.set_property_structure (l_type_registration.default_data_structure)
				end
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

note
	copyright: "Copyright (c) 1984-2019, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
