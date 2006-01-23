indexing
	description: "Objects that synchronizes all the threads when exiting."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EXIT_CONTROL

feature -- Access

	exit_mutex: MUTEX is
			-- Lock synchronizing creation and destruction
			-- of EiffelThreads.
		once
			create Result
		ensure
			exit_mutex_not_void: exit_mutex /= Void
		end

	demos_list: LINKED_LIST [DEMO_WIN] is
			-- Record all demo windows running a thread.
			-- Access needs to be protected using `exit_mutex'.
		once
			create Result.make
		ensure
			demos_list_not_void: Result /= Void
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end -- class EXIT_CONTROL

