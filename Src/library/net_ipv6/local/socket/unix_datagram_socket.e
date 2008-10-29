indexing

	description:
		"An unix datagram socket."
	legal: "See notice at end of class.";

	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class

	UNIX_DATAGRAM_SOCKET

inherit

	UNIX_SOCKET
		rename
			bind as socket_bind,
			close as socket_close
		select
			name,
			cleanup,
			address
		end

	DATAGRAM_SOCKET
		rename
			name as socket_name,
			cleanup as socket_cleanup,
			address as socket_address
		end

create

	make, make_bound, make_targeted

feature -- Initialization

	make is
			-- Create an unix datagram socket.
		do
			c_reset_error
			family := af_unix;
			type := sock_dgrm;
			make_socket;
			is_open_write := True
		end;

	make_bound (a_path: STRING) is
			-- Create an unix socket bound to a local well known
			-- address `a_path'.
		local
			an_address: UNIX_SOCKET_ADDRESS
		do
			create an_address.make_from_path (a_path);
			make_bound_to_address (an_address)
		end;

	make_targeted (a_peer_path: STRING) is
			-- Create an unix socket targeted to `a_peer_path'.
		local
			an_address: UNIX_SOCKET_ADDRESS
		do
			create an_address.make_from_path (a_peer_path);
			make_connected_to_peer (an_address)
		end

feature -- Miscellaneous

	target_to (a_peer_path: STRING) is
			-- Target socket to `a_peer_path'.
		require
			socket_exists: exists
		local
			an_address: UNIX_SOCKET_ADDRESS
		do
			create an_address.make_from_path (a_peer_path);
			connect_to_peer (an_address)
		end;

	make_peer_address is
			-- Create a peer address.
		do
			create peer_address.make
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




end -- class UNIX_DATAGRAM_SOCKET

