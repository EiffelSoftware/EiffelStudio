indexing

	description:
		"A client for a socket.";

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

deferred class CLIENT inherit

	SOCKET_RESOURCES

feature -- Access

	in_out: SOCKET;
			-- Receive and send socket.

	received : ANY;
			-- message received on `in'

	cleanup is
			-- Cleanup client.
		deferred
		end;

	send (msg : ANY) is
			-- Send `msg'.
		do
			in_out.independent_store (msg)
		end;

	receive is
			-- Receive message.
		do
			received ?= in_out.retrieved
		end
	
end -- class CLIENT

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

