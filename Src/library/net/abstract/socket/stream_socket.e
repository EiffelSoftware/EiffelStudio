indexing

        description:
                "Connexion oriented socket.";

        status: "See notice at end of class";
        date: "$Date$";
        revision: "$Revision$"

class

	STREAM_SOCKET

inherit

	SOCKET
		redefine
			support_storable
		end

creation {STREAM_SOCKET}

	create_from_descriptor

feature -- Status report

	support_storable: BOOLEAN is True
			-- Can medium be used to store an Eiffel structure?

feature

	listen (queue: INTEGER) is
			-- Listen on socket for at most `queue' connections.
		require
			socket_exists: exists
		do
			c_listen (descriptor, queue)
		end

	accepted: like Current
			-- Last accepted socket.

	accept is
			-- Accept a new connection on listen socket.
			-- Accepted service socket available in `accepted'.
		require
			socket_exists: exists
		local
			pass_address: like address;
			return: INTEGER;
			ext: ANY
		do
			pass_address := clone (address);
			ext := pass_address.socket_address;
			return := c_accept (descriptor, $ext, address.count);
			if return > 0 then
				create accepted.create_from_descriptor (return);
				accepted.set_peer_address (pass_address)
			else
				accepted := Void
			end
		end;

feature {NONE} -- Externals

	c_accept (soc: INTEGER; addr: POINTER; length: INTEGER): INTEGER is
			-- External c routine to accept a socket connection
		external
			"C"
		end;

	c_listen (soc, backlog: INTEGER) is
			-- External c routine to make socket passive and accept
			-- at most `backlog' number of pending connections
		external
			"C"
		end

end -- class STREAM_SOCKET




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

