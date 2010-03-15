note

	description:
		"A datagram socket."
	legal: "See notice at end of class.";

	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

deferred class

	DATAGRAM_SOCKET

inherit

	SOCKET
		rename
			bind as socket_bind,
			close as socket_close
		redefine
			send
		end

feature -- Creation

	make
				-- Create a domain typed socket
		deferred
		end

	make_bound_to_address (a_local_address: like address)
			-- Create a socket bound to its well-known address
			-- `local_address'.
		do
			make
			create last_string.make_empty
			set_address (a_local_address)
			bind
		end

	make_connected_to_peer (a_peer_address: like address)
			-- Create a socket targeted to `peer_address'.
		do
			make
			create last_string.make_empty
			connect_to_peer (a_peer_address)
		end

feature -- Basic operations

	connect_to_peer (a_peer_address: like address)
			-- Target socket to `a_peer_address'.
		require
			socket_exists: exists
			a_peer_address_attached: a_peer_address /= Void
			a_peer_address_valid: is_valid_peer_address (a_peer_address)
		do
			set_peer_address (a_peer_address);
		end

	bind
			-- Bind socket to a local address.
		do
			socket_bind
			bound := True
		end

	close
			-- Close socket.
		do
			socket_close
			bound := False
		end

feature -- Status report

	bound: BOOLEAN
			-- Has socket been bound?

feature -- Input

	received (size: INTEGER; flags: INTEGER): PACKET
			-- Receive a packet.
			-- Who from is put into the `peer_address'.
		require
			socket_exists: exists;
			opened_for_read: is_open_read
		deferred
		ensure
			known_address: peer_address /= Void
		end

feature -- Output

	send_to (a_packet: PACKET; to_address: SOCKET_ADDRESS; flags: INTEGER)
			-- Send `a_packet' to address `to_address'
		require
			socket_exists: exists;
			opened_for_write: is_open_write;
			valid_peer: to_address /= Void;
			valid_packet: a_packet /= Void
		deferred
		end

	send (a_packet: PACKET; flags: INTEGER)
			-- Send `a_packet' to address in `peer_address'.
		local
			l_peer_address: like peer_address
		do
			l_peer_address := peer_address
			check l_peer_address_not_void: l_peer_address /= Void end
			send_to (a_packet, l_peer_address, flags)
		end

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end -- class DATAGRAM_SOCKET

