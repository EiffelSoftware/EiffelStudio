note
	description: "Objec representing {STATIC_MODULE}."
	date: "$Date$"
	revision: "$Revision$"

class
	STATIC_MODULE
inherit
	MODULE_LOADER

feature -- Query

	api_pointer (a_api_name: READABLE_STRING_8): POINTER
			-- Retrieve an API function/variable pointer given an API name.
		do
				-- default pointer in Static Mode.
			Result := default_pointer
		end

feature -- Clean up

	unload
			-- Unloads the Current loaded library.
		do
			-- Empty for static.
		end

feature -- Status report

	is_interface_usable: BOOLEAN
			-- Indicates if the static API interface can be used.
		do
			Result := True
		end

note
	copyright: "Copyright (c) 1984-2017, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
