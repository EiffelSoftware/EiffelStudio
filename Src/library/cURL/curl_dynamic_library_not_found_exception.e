indexing
	description: "[
					Exception which means cURL dynamic library (*.dll on Windows,
					*.so on Linux and ...) not found.
																			]"
	status: "See notice at end of class."
	legal: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CURL_DYNAMIC_LIBRARY_NOT_FOUND_EXCEPTION

inherit
	DEVELOPER_EXCEPTION

create
	make

feature {NONE} -- Initialization

	make is
			-- Creation method.
		do
			set_message ("cURL dynamic library not found.")
		end

indexing
	library:   "cURL: Library of reusable components for Eiffel."
	copyright: "Copyright (c) 1984-2006, Eiffel Software and others"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			356 Storke Road, Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
