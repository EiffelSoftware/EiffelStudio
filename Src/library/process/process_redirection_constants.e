indexing
	description: "Definition of some constants used in process launcher"
	status: "See notice at end of class."
	legal: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	PROCESS_REDIRECTION_CONSTANTS

feature -- Access
	to_stream: INTEGER is 0 
	to_file: INTEGER is 1
	to_agent: INTEGER is 2
	no_redirection: INTEGER is 3
	to_same_as_output: INTEGER is 5;

indexing
	library:   "EiffelProcess: Manipulation of processes with IO redirection."
	copyright: "Copyright (c) 1984-2008, Eiffel Software and others"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			356 Storke Road, Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
