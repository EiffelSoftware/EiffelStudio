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
--| Copyright (C) 1086-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

