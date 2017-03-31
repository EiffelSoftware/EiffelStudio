note
	description: "Definition of some constants used in process launcher."
	status: "See notice at end of class."
	legal: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	PROCESS_REDIRECTION_CONSTANTS

inherit
	BASE_REDIRECTION

feature -- Access

	to_agent: INTEGER
		obsolete "Use `to_stream' instead. [2017-05-31]"
		do
			Result := to_stream
		end

note
	copyright: "Copyright (c) 1984-2017, Eiffel Software and others"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
