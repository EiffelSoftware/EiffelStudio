indexing

	description:
		"A client for a socket.";

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

deferred class 
	
	CLIENT

inherit
	SOCKET_R;

	STORABLE;

feature -- Access

	in_out: SOCKET
		-- Receive and send sockets.

	received : SOCKET_STORABLE
		-- message received on `in'

	make (a : SOCKET_ADDRESS) is
		require
			socket_address_non_void: a /= Void
		deferred
		end

	close is
		deferred
		end

	send (msg : SOCKET_STORABLE) is
		do
			msg.general_store (in_out)
		end

	receive is
		do
			received ?= socket_retrieved (in_out)
		end
	
end -- class CLIENT

--|----------------------------------------------------------------
--| Eiffelnet: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1994, Interactive Software
--|   Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <eiffel@eiffel.com>
--|----------------------------------------------------------------

