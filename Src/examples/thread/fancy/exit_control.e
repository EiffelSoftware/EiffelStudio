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

--|----------------------------------------------------------------
--| EiffelThread: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

