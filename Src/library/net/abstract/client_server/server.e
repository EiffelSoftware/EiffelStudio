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
--| EiffelNet: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1986, 1990, 1993, 1994, Interactive Software
--|   Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|----------------------------------------------------------------

