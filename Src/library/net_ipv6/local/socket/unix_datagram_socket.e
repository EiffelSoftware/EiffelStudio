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
		undefine
			put_character, putchar, put_string, putstring,
			put_integer, putint, put_integer_32,
			put_integer_8, put_integer_16, put_integer_64,
			put_natural_8, put_natural_16, put_natural, put_natural_32, put_natural_64,
			put_boolean, putbool,
			put_real, putreal, put_double, putdouble, put_managed_pointer
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

feature -- Input

	received (size: INTEGER; flags: INTEGER): PACKET is
			-- Receive a packet.
			-- Who from is put into the `peer_address'.
		local
			return_val: INTEGER;
			peer_addr_size: INTEGER
		do
			if peer_address = Void then
				make_peer_address
			end
			peer_addr_size := peer_address.count;
			create Result.make (size);
			return_val := c_rcv_from (descriptor, Result.data.item, Result.count, flags, peer_address.socket_address.item, $peer_addr_size);
		end

feature -- Output

	send_to (a_packet: PACKET; to_address: SOCKET_ADDRESS; flags: INTEGER) is
			-- Send `a_packet' to address `to_address'
		local
			return_val: INTEGER
		do
			return_val := c_send_to (descriptor, a_packet.data.item, a_packet.count, flags, to_address.socket_address.item, to_address.count)
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

	put_string, putstring (s: STRING) is
			-- Send string `s' through socket.
		require else
			socket_exists: exists;
			opened_for_write: is_open_write;
			valid_peer: peer_address /= Void
		local
			ext: C_STRING
		do
			create ext.make (s)
			c_send_stream_to (descriptor, ext.item, s.count, 0,
				peer_address.socket_address.item, peer_address.count)
		end;

	put_managed_pointer (p: MANAGED_POINTER; start_pos, nb_bytes: INTEGER) is
			-- Put data of length `nb_bytes' pointed by `start_pos' index in `p' at
			-- current position.
		require else
			p_not_void: p /= Void
			p_large_enough: p.count >= nb_bytes + start_pos
			socket_exists: exists;
			opened_for_write: is_open_write;
			valid_peer: peer_address /= Void
		do
			c_send_stream_to (descriptor, p.item + start_pos, nb_bytes, 0,
				peer_address.socket_address.item, peer_address.count)
		end

	put_character, putchar (c: CHARACTER) is
			-- Send character `c' through socket.
		require else
			socket_exists: exists;
			opened_for_write: is_open_write;
			valid_peer: peer_address /= Void
		do
			c_send_char_to (descriptor, c, 0, peer_address.socket_address.item, peer_address.count)
		end;

	put_real, putreal (r: REAL) is
			-- Send real `r' through socket.
		require else
			socket_exists: exists;
			opened_for_write: is_open_write;
			valid_peer: peer_address /= Void
		do
			c_send_float_to (descriptor, r, 0, peer_address.socket_address.item, peer_address.count)
		end;

	put_integer, putint, put_integer_32 (i: INTEGER) is
			-- Send integer `i' through socket.
		require else
			socket_exists: exists;
			opened_for_write: is_open_write;
			valid_peer: peer_address /= Void
		do
			c_send_int_to (descriptor, i, 0, peer_address.socket_address.item, peer_address.count)
		end;

	put_integer_8 (i: INTEGER_8) is
			-- Send integer `i' through socket.
		require else
			socket_exists: exists;
			opened_for_write: is_open_write;
			valid_peer: peer_address /= Void
		do
			socket_buffer.put_integer_8_be (i, 0)
			put_managed_pointer (socket_buffer, 0, integer_8_bytes)
		end

	put_integer_16 (i: INTEGER_16) is
			-- Send integer `i' through socket.
		require else
			socket_exists: exists;
			opened_for_write: is_open_write;
			valid_peer: peer_address /= Void
		do
			socket_buffer.put_integer_16_be (i, 0)
			put_managed_pointer (socket_buffer, 0, integer_16_bytes)
		end

	put_integer_64 (i: INTEGER_64) is
			-- Send integer `i' through socket.
		require else
			socket_exists: exists;
			opened_for_write: is_open_write;
			valid_peer: peer_address /= Void
		do
			socket_buffer.put_integer_64_be (i, 0)
			put_managed_pointer (socket_buffer, 0, integer_64_bytes)
		end

	put_natural_8 (i: NATURAL_8) is
			-- Send integer `i' through socket.
		require else
			socket_exists: exists;
			opened_for_write: is_open_write;
			valid_peer: peer_address /= Void
		do
			socket_buffer.put_natural_8_be (i, 0)
			put_managed_pointer (socket_buffer, 0, natural_8_bytes)
		end

	put_natural_16 (i: NATURAL_16) is
			-- Send integer `i' through socket.
		require else
			socket_exists: exists;
			opened_for_write: is_open_write;
			valid_peer: peer_address /= Void
		do
			socket_buffer.put_natural_16_be (i, 0)
			put_managed_pointer (socket_buffer, 0, natural_16_bytes)
		end

	put_natural, put_natural_32 (i: NATURAL_32) is
			-- Send integer `i' through socket.
		require else
			socket_exists: exists;
			opened_for_write: is_open_write;
			valid_peer: peer_address /= Void
		do
			socket_buffer.put_natural_32_be (i, 0)
			put_managed_pointer (socket_buffer, 0, natural_32_bytes)
		end

	put_natural_64 (i: NATURAL_64) is
			-- Send integer `i' through socket.
		require else
			socket_exists: exists;
			opened_for_write: is_open_write;
			valid_peer: peer_address /= Void
		do
			socket_buffer.put_natural_64_be (i, 0)
			put_managed_pointer (socket_buffer, 0, natural_64_bytes)
		end


	put_boolean, putbool (b: BOOLEAN) is
			-- Send boolean `b' through socket.
		require else
			socket_exists: exists;
			opened_for_write: is_open_write;
			valid_peer: peer_address /= Void
		do
			if b then
				put_character ('T')
			else
				put_character ('F')
			end
		end;

	put_double, putdouble (d: DOUBLE) is
			-- Send double `d' through socket.
		require else
			socket_exists: exists;
			opened_for_write: is_open_write;
			valid_peer: peer_address /= Void
		do
			c_send_double_to (descriptor, d, 0, peer_address.socket_address.item, peer_address.count)
		end;

feature {NONE} -- Externals

	c_send_char_to (fd: INTEGER; c: CHARACTER; flags: INTEGER; addr: POINTER; length: INTEGER) is
			-- External routine to send character `c' to address `addr'
			-- through socket `fd'
		external
			"C blocking"
		end;

	c_send_int_to (fd: INTEGER; i: INTEGER; flags: INTEGER; addr: POINTER; length: INTEGER) is
			-- External routine to send integer `i' to address `addr'
			-- through socket `fd'
		external
			"C blocking"
		end;

	c_send_float_to (fd: INTEGER; r: REAL; flags: INTEGER; addr: POINTER; length: INTEGER) is
			-- External routine to send real `r' to address `addr'
			-- through socket `fd'
		external
			"C blocking"
		end;

	c_send_double_to (fd: INTEGER; d: DOUBLE; flags: INTEGER; addr: POINTER; length: INTEGER) is
			-- External routine to send double `d' to address `addr'
			-- through socket `fd'
		external
			"C blocking"
		end;

	c_send_stream_to (fd: INTEGER; s: POINTER; l: INTEGER; flags: INTEGER; addr: POINTER; length: INTEGER) is
			-- External routine to send stream pointed by `s'
			-- to address `addr' through socket `fd'
		external
			"C blocking"
		end

	c_rcv_from (fd: INTEGER; buf: POINTER; len:INTEGER; flags: INTEGER; addr: POINTER; l: POINTER): INTEGER is
			-- External routine to read `l' length of data
			-- from the socket identified by `fd' connected
			-- to a peer address of `addr'.
		external
			"C blocking"
		end;

	c_send_to (fd: INTEGER; buf: POINTER; len: INTEGER; flags: INTEGER; addr: POINTER; l: INTEGER): INTEGER is
			-- External routine to write `l' length of data
			-- from the socket identified by `fd' connected
			-- to a peer address of `addr'.
		external
			"C blocking"
		end;


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

