indexing

	description:
		"An unix stream socket."
	legal: "See notice at end of class.";

	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class

	UNIX_STREAM_SOCKET

inherit

	STREAM_SOCKET
		rename
			address as old_socket_address,
			cleanup as old_socket_cleanup,
			name as old_socket_name
		end

	UNIX_SOCKET
		undefine
			support_storable
		select
			address,
			cleanup,
			name
		end

create {UNIX_STREAM_SOCKET}

	create_from_descriptor

create

	make, make_client, make_server

feature -- Initialization

	make is
			-- Make an unix socket stream.
		do
			c_reset_error
			family := af_unix;
			type := sock_stream;
			make_socket
		end;

	make_client (a_peer: STRING) is
			-- Create an unix stream client socket with peer
			-- address set to `a_peer'.
		require
			valid_path: a_peer /= Void
		do
			make;
			create peer_address.make;
			peer_address.set_path (a_peer.twin)
		end;

	make_server (a_name: STRING) is
			-- Create an unix stream server socket bound to local
			-- address `a_name'.
		require
			valid_path: a_name /= Void and then not a_name.is_empty
		do
			make;
			create address.make;
			address.set_path (a_name.twin);
			bind
		end

feature

	listen (queue: INTEGER) is
			-- Listen on socket for at most `queue' connections.
		do
			c_listen (descriptor, queue)
		end

	accept is
			-- Accept a new connection on listen socket.
			-- Accepted service socket available in `accepted'.
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
		end

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




end -- class UNIX_STREAM_SOCKET

