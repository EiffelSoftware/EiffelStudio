indexing
	description: "Objects that synchronizes all the threads%
		% when exiting."
	author: "Interactive Software Engineering."
	date: "$Date$"
	revision: "$Revision$"

class
	EXIT_CONTROL


feature -- Access

	exit_mutex: MUTEX is
			-- Lock synchronizing creation and destruction
			-- of EiffelThreads.
		once
			create Result.make
		end

	demos_list: LINKED_LIST [DEMO_WIN] is
			-- Record all demo windows running a thread.
		once
			create Result.make
		end
end -- class EXIT_CONTROL
