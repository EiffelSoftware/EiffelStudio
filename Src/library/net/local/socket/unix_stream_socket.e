note

	description:
		"A Unix stream socket."
	legal: "See notice at end of class.";

	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class

	UNIX_STREAM_SOCKET

inherit

	STREAM_SOCKET
		undefine
			address_type,
			cleanup,
			name
		end

	UNIX_SOCKET
		undefine
			support_storable
		end

create {UNIX_STREAM_SOCKET}

	create_from_descriptor

create

	make, make_client, make_server

feature -- Initialization

	make
			-- Make a Unix socket stream.
		do
			c_reset_error
			family := af_unix;
			type := sock_stream;
			make_socket
		end;

	make_client (a_peer: STRING)
			-- Create a Unix stream client socket with peer
			-- address set to `a_peer'.
		require
			valid_path: a_peer /= Void
		local
			l_peer_address: like peer_address
		do
			make
			create l_peer_address.make
			peer_address := l_peer_address
			l_peer_address.set_path (a_peer.twin)
		end;

	make_server (a_name: STRING)
			-- Create a Unix stream server socket bound to local
			-- address `a_name'.
		require
			valid_path: a_name /= Void and then not a_name.is_empty
		local
			l_address: like address
		do
			make;
			create l_address.make
			address := l_address
			l_address.set_path (a_name.twin);
			bind
		end

feature

	listen (queue: INTEGER)
			-- Listen on socket for at most `queue' connections.
		do
			c_listen (descriptor, queue)
		end

	accept
			-- Accept a new connection on listen socket.
			-- Accepted service socket available in `accepted'.
		local
			l_pass_address: like address;
			l_accepted: like accepted
			return: INTEGER;
		do
			l_pass_address := address
			if l_pass_address /= Void then
				l_pass_address := l_pass_address.twin
				return := c_accept (descriptor, l_pass_address.socket_address.item, l_pass_address.count);
				if return > 0 then
					create l_accepted.create_from_descriptor (return)
					accepted := l_accepted
					l_accepted.set_peer_address (l_pass_address)
				else
					accepted := Void
				end
			else
				accepted := Void
			end
		end

feature {NONE} -- Externals

	c_accept (soc: INTEGER; addr: POINTER; length: INTEGER): INTEGER
			-- External c routine to accept a socket connection
		external
			"C blocking"
		end;

	c_listen (soc, backlog: INTEGER)
			-- External c routine to make socket passive and accept
			-- at most `backlog' number of pending connections
		external
			"C blocking"
		end

note
	copyright:	"Copyright (c) 1984-2013, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"




end -- class UNIX_STREAM_SOCKET

