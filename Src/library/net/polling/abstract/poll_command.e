indexing

	description:
		"A poll command for use with a medium poller.";

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

deferred class

	POLL_COMMAND

feature -- Initalization

	make (s: like active_medium) is
		require
			socket_open: s /= Void and then not s.is_closed
		do
			active_medium := s
		ensure
			socket_assigned: s = active_medium
		end

feature -- Access

	active_medium: IO_MEDIUM
			-- Medium which was polled

feature -- Basic operation

	execute (arg: ANY) is
			-- do the work of the command
		deferred
		end

end -- class POLL_COMMAND

--|----------------------------------------------------------------
--| EiffelNet: library of reusable components for ISE Eiffel.
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|	http://www.eiffel.com
--|----------------------------------------------------------------

