indexing

        description:
                "Connexion oriented socket."
	legal: "See notice at end of class.";

        status: "See notice at end of class.";
        date: "$Date$";
        revision: "$Revision$"

class

	STREAM_SOCKET

inherit

	SOCKET
		redefine
			support_storable
		end

create {STREAM_SOCKET}

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
		do
			pass_address := address.twin
			return := c_accept (descriptor, pass_address.socket_address.item, address.count);
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
			"C blocking"
		end;

	c_listen (soc, backlog: INTEGER) is
			-- External c routine to make socket passive and accept
			-- at most `backlog' number of pending connections
		external
			"C blocking"
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class STREAM_SOCKET

