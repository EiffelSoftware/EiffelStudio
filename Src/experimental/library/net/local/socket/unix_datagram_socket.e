note

	description:
		"A Unix datagram socket."
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
		undefine
			send
		redefine
			put_pointer_content
		end

	DATAGRAM_SOCKET
		undefine
			address_type, cleanup, name
		redefine
			put_pointer_content
		end

create

	make, make_bound, make_targeted

feature -- Initialization

	make
			-- Create a Unix datagram socket.
		do
			c_reset_error
			family := af_unix;
			type := sock_dgrm;
			make_socket;
			is_open_write := True
		end;

	make_bound (a_path: STRING)
			-- Create a Unix socket bound to a local well known
			-- address `a_path'.
		local
			an_address: UNIX_SOCKET_ADDRESS
		do
			create an_address.make_from_path (a_path);
			make_bound_to_address (an_address)
		end;

	make_targeted (a_peer_path: STRING)
			-- Create a Unix socket targeted to `a_peer_path'.
		local
			an_address: UNIX_SOCKET_ADDRESS
		do
			create an_address.make_from_path (a_peer_path);
			make_connected_to_peer (an_address)
		end

feature -- Input

	received (size: INTEGER; flags: INTEGER): PACKET
			-- Receive a packet.
			-- Who from is put into the `peer_address'.
		local
			return_val: INTEGER;
			peer_addr_size: INTEGER
			l_peer_address: like peer_address
		do
			l_peer_address := peer_address
			if l_peer_address = Void then
				create l_peer_address.make
				peer_address := l_peer_address
			end
			peer_addr_size := l_peer_address.count;
			create Result.make (size);
			return_val := c_rcv_from (descriptor, Result.data.item, Result.count, flags, l_peer_address.socket_address.item, $peer_addr_size);
		end

feature -- Output

	send_to (a_packet: PACKET; to_address: SOCKET_ADDRESS; flags: INTEGER)
			-- Send `a_packet' to address `to_address'
		local
			return_val: INTEGER
		do
			return_val := c_send_to (descriptor, a_packet.data.item, a_packet.count, flags, to_address.socket_address.item, to_address.count)
		end

feature -- Miscellaneous

	target_to (a_peer_path: STRING)
			-- Target socket to `a_peer_path'.
		require
			socket_exists: exists
		local
			an_address: UNIX_SOCKET_ADDRESS
		do
			create an_address.make_from_path (a_peer_path);
			connect_to_peer (an_address)
		end;

	make_peer_address
			-- Create a peer address.
		obsolete
			"Automatically created when calling `received'."
		do
			create peer_address.make
		ensure
			peer_address_attached: peer_address /= Void
		end

feature {NONE} -- Implementation

	put_pointer_content (a_pointer: POINTER; a_offset, a_byte_count: INTEGER)
			-- <Precursor>
		local
			l_peer_address: like peer_address
		do
			l_peer_address := peer_address
				-- If we haven't set a `peer_address' yet, we don't send anything.
			if l_peer_address /= Void then
				c_send_stream_to (descriptor, a_pointer + a_offset, a_byte_count, 0,
					l_peer_address.socket_address.item, l_peer_address.count)
			end
		end

feature {NONE} -- Externals

	c_send_stream_to (fd: INTEGER; s: POINTER; l: INTEGER; flags: INTEGER; addr: POINTER; length: INTEGER)
			-- External routine to send stream pointed by `s'
			-- to address `addr' through socket `fd'
		external
			"C blocking"
		end

	c_rcv_from (fd: INTEGER; buf: POINTER; len:INTEGER; flags: INTEGER; addr: POINTER; l: POINTER): INTEGER
			-- External routine to read `l' length of data
			-- from the socket identified by `fd' connected
			-- to a peer address of `addr'.
		external
			"C blocking"
		end;

	c_send_to (fd: INTEGER; buf: POINTER; len: INTEGER; flags: INTEGER; addr: POINTER; l: INTEGER): INTEGER
			-- External routine to write `l' length of data
			-- from the socket identified by `fd' connected
			-- to a peer address of `addr'.
		external
			"C blocking"
		end;

note
	copyright:	"Copyright (c) 1984-2015, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"




end -- class UNIX_DATAGRAM_SOCKET

