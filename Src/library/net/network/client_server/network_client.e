indexing

	description:
		"A client for a network socket.";

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class

	NETWORK_CLIENT

inherit

	CLIENT
		redefine
			in_out, send
		end

feature -- Access

	in_out: NETWORK_STREAM_SOCKET;
			-- Receive and send sockets.

	make (a_peer_port: INTEGER; a_peer_name: STRING) is
		require
			a_valid_port: a_peer_port > 0;
			a_valid_name: a_peer_name /= Void and then not a_peer_name.empty
		do
			!!in_out.make_client_by_port (a_peer_port, a_peer_name);
			in_out.connect
		end;

	cleanup is
		do
			in_out.close
		end;

	send (msg : ANY) is
		do
			in_out.independent_store (msg)
		end

end -- class NETWORK_CLIENT


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

