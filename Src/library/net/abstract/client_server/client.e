indexing

	description:
		"A client for a socket.";

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

deferred class

	CLIENT

inherit

	SOCKET_RESOURCES

feature -- Access

	in_out: SOCKET;
			-- Receive and send socket.

	received : ANY;
			-- message received on `in'

	cleanup is
		deferred
		end;

	send (msg : ANY) is
		do
			in_out.independent_store (msg)
		end;

	receive is
		do
			received ?= in_out.retrieved
		end
	
end -- class CLIENT

--|----------------------------------------------------------------
--| EiffelNet: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1994, Interactive Software
--|   Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|----------------------------------------------------------------

