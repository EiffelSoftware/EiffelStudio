indexing
	description: "Objects that wraps a process id with its parent process id"
	status: "See notice at end of class."
	legal: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_PROCESS_ID_PAIR

create
	make

feature{NONE} -- Initialization

	make (a_parent_id, a_process_id: INTEGER) is
			--
		do
			parent_id := a_parent_id
			id := a_process_id
		ensure
			parent_id_set: parent_id = a_parent_id
			id_set: id = a_process_id
		end

feature -- Access

	parent_id: INTEGER
			-- Parent process id

	id: INTEGER;
			-- Process id	

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
