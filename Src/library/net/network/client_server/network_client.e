indexing

	description:
		"A client for a network socket.";

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class INET_CLIENT

inherit
	CLIENT
		redefine
			in_out
		end

feature -- Access

	in_out: NETWORK_SOCKET_STREAM
		-- Receive and send sockets.

	make (a : SOCKET_ADDRESS_NETWORK) is
		do
			!!in_out.make 
			in_out.set_peer_address (clone (a))
			in_out.connect;
		end

	close is
		do
			in_out.close
		end

end -- class INET_CLIENT

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

