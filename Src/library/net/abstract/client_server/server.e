indexing

	description:
		"A server for a socket.";

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

deferred class SERVER inherit

	SOCKET_RESOURCES

feature -- Access

	in : SOCKET;
			-- Listen socket

	outflow : like in;
			-- Service socket

	received: ANY;
			-- Last message from socket

	execute is
			-- Execute transfer loop.
		do
			from
			until
				False
			loop
				receive;
				process_message;
				respond;
				close
			end
		end;

	queued: INTEGER;

	resend (msg: ANY) is
			-- Resend `msg'.
		do
			outflow.independent_store (msg)
		end;

	set_queued (n: INTEGER) is
			-- Set `queued' to `n'.
		require
			valid_queue_number: n > 0 and n < 6
		do
			queued := n
		ensure 
			assigned_queued: queued = n
		end;

	cleanup is
			-- Cleanup server.
		deferred
		end;

	close is
			-- Close sockets.
		deferred
		end;

	process_message is 
			-- Process the received message.
		deferred
		end;

	respond is
			-- Respond to client.
		do
		end;

	receive is
			-- Receive message.
		deferred
		end

end -- class SERVER


--|----------------------------------------------------------------
--| EiffelNet: library of reusable components for ISE Eiffel.
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

