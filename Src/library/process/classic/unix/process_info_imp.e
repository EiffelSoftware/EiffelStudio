note
	description: "Unix implementation of PROCESS_INFO"
	status: "See notice at end of class."
	legal: "See notice at end of class."
	author: ""
	date: ""
	revision: ""

class
	PROCESS_INFO_IMP

inherit
	PROCESS_INFO

feature -- Access

	process_id: INTEGER
			-- Process ID of current process
		external
			"C inline"
		alias
			"getpid()"
		end


note
	copyright: "Copyright (c) 1984-2009, Eiffel Software and others"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 5949 Hollister Ave., Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"
end
