indexing
	description: "Implementation of PROCESS_INFO"
	status: "See notice at end of class."
	legal: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	PROCESS_INFO_IMP

inherit
	PROCESS_INFO

feature -- Access

	process_id: INTEGER is
			-- Process ID of current process
		local
			l_prc: SYSTEM_DLL_PROCESS
		do
			create l_prc.make
			l_prc := l_prc.get_current_process
			Result := l_prc.id
		end

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
