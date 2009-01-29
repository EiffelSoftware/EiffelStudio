note
	description: "[
		Constants used by interpeter
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ITP_SHARED_CONSTANTS

feature -- Access

	start_request_flag: NATURAL_8 = 1
			-- Flag for "start" request

	quit_request_flag: NATURAL_8 = 2
			-- Flag for "quit" request

	execute_request_flag: NATURAL_8 = 3
			-- Flag for "execute" request

	type_request_flag: NATURAL_8 = 4
			-- Flag for "type" request

	response_starter_flag: NATURAL_8 = 1
			-- Flag to indicate that raw response is followed.
			-- Used in socket IPC.

note
	copyright: "Copyright (c) 1984-2009, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
