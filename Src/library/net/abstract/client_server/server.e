indexing

	description:
		"A server for a socket.";

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

deferred class SERVER

inherit
	SOCKET_R
	SOCKET_STORABLE

feature -- Access

	in : SOCKET
		-- Receive socket.

	outflow : like in
		-- Send socket

	received: SOCKET_STORABLE
		-- Last message from socket

	make (a : SOCKET_ADDRESS; queueing : INTEGER) is
		deferred
		end

	execute is
		do
			from
			until
				false
			loop
				receive;
				process_message;
				respond;
				clean_up;
			end
		end

	close is
		deferred
		end

	process_message is 
		deferred
		end

	respond is
		do
		end;

	receive is
		deferred
		end;

	clean_up is
		deferred
		end;

end -- class SERVER

--|----------------------------------------------------------------
--| EiffelBase: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1986, 1990, 1993, 1994, Interactive Software
--|   Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <eiffel@eiffel.com>
--|----------------------------------------------------------------

