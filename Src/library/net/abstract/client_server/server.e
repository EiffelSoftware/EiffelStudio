indexing

	description:
		"A server for a socket.";

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

deferred class

	SERVER

inherit

	SOCKET_RESOURCES

feature -- Access

	in : SOCKET;
			-- Listen socket.

	outflow : like in;
			-- Service socket

	received: ANY;
			-- Last message from socket

	execute is
		do
			from
			until
				false
			loop
				receive;
				process_message;
				respond;
				close
			end
		end;

	queued: INTEGER;

	resend (msg: ANY) is
		do
			outflow.independent_store (msg)
		end;

	set_queued (n:INTEGER) is
		require
			valid_queue_number: n > 0 and n < 6
		do
			queued := n
		ensure 
			assigned_queued: queued = n
		end;

	cleanup is
		deferred
		end;

	close is
		deferred
		end;

	process_message is 
		deferred
		end;

	respond is
		do
		end;

	receive is
		deferred
		end

end -- class SERVER


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

