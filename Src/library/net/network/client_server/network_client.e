indexing

	description:
		"A client for a network socket.";

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class NETWORK_CLIENT inherit

	CLIENT
		redefine
			in_out, send
		end

feature -- Access

	in_out: NETWORK_STREAM_SOCKET;
			-- Receive and send sockets.

	make (a_peer_port: INTEGER; a_peer_name: STRING) is
			-- Make client with port `a_peer_port' and host `a_peer_name'.
		require
			a_valid_port: a_peer_port > 0;
			a_valid_name: a_peer_name /= Void and then not a_peer_name.is_empty
		do
			create in_out.make_client_by_port (a_peer_port, a_peer_name);
			in_out.connect
		end;

	cleanup is
			-- Shut down client.
		do
			in_out.close
		end;

	send (msg : ANY) is
			-- Send `msg' to server.
		do
			in_out.independent_store (msg)
		end

end -- class NETWORK_CLIENT


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

