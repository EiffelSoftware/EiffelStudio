indexing

	description:
		"A datagram socket.";

	status: "See notice at end of class";
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
			send,
			put_character, putchar, put_string, putstring,
			put_integer, putint, put_boolean, putbool,
			put_real, putreal, put_double, putdouble
		end

feature -- Creation

	make is
				-- Create a domain typed socket
		deferred
		end;

	make_bound_to_address (a_local_address: like address) is
			-- Create a socket bound to its well-known address
			-- `local_address'.
		do
			make;
			set_address (a_local_address);
			bind
		end;

	make_connected_to_peer (a_peer_address: like address) is
			-- Create a socket targeted to `peer_address'.
		do
			make;
			set_peer_address (a_peer_address);
		end;

feature -- Basic operations

	connect_to_peer (a_peer_address: like address) is
			-- Target socket to `a_peer_address'.
		require
			socket_exists: exists
		do
			set_peer_address (a_peer_address);
		end;

	bind is
			-- Bind socket to a local address.
		do
			socket_bind;
			bound := True
		end;

	close is
			-- Close socket.
		do
			socket_close;
			bound := False
		end

feature -- Status report

	bound: BOOLEAN
			-- Has socket been bound?

feature -- Input

	received (size: INTEGER; flags: INTEGER): DATAGRAM_PACKET is
			-- Receive a packet.
			-- Who from is put into the `peer_address'.
		require
			socket_exists: exists;
			opened_for_read: is_open_read
		local
			return_val: INTEGER;
			ext_data: ANY;
			ext_addr: ANY;
			peer_addr_size: INTEGER
		do
			if peer_address = Void then
				make_peer_address
			end;
			ext_addr := peer_address.socket_address;
			peer_addr_size := peer_address.count;
			create Result.make (size);
			ext_data := Result.data;
			return_val := c_rcv_from (descriptor, $ext_data, Result.count, flags, $ext_addr, $peer_addr_size);
		ensure
			known_address: peer_address /= Void
		end

feature -- Output

	send_to (a_packet: DATAGRAM_PACKET; to_address: SOCKET_ADDRESS; flags: INTEGER) is
			-- Send `a_packet' to address `to_address'
		require 
			socket_exists: exists;
			opened_for_write: is_open_write;
			valid_peer: to_address /= Void;
			valid_packet: a_packet /= Void
		local
			ext_data: ANY;
			ext_addr: ANY;
			return_val: INTEGER
		do
			ext_data := a_packet.data;
			ext_addr := to_address.socket_address;
			return_val := c_send_to (descriptor, $ext_data, a_packet.count, flags, $ext_addr, to_address.count)
		end;

	send (a_packet: PACKET; flags: INTEGER) is
			-- Send `a_packet' to address in `peer_address'.
		local
			ext_data: ANY;
			ext_addr: ANY;
			return_val: INTEGER
		do
			ext_data := a_packet.data;
			ext_addr := peer_address.socket_address;
			return_val := c_send_to (descriptor, $ext_data, a_packet.count, flags, $ext_addr, peer_address.count)
		end;

	put_string, putstring (s: STRING) is
			-- Send string `s' through socket.
		require else
			socket_exists: exists;
			opened_for_write: is_open_write;
			valid_peer: peer_address /= Void
		local
			ext: ANY;
			ext_addr: ANY
		do
			ext := s.to_c;
			ext_addr := peer_address.socket_address;
			c_send_stream_to (descriptor, $ext, s.count, 0, $ext_addr, peer_address.count)
		end;

	put_character, putchar (c: CHARACTER) is
			-- Send character `c' through socket.
		require else
			socket_exists: exists;
			opened_for_write: is_open_write;
			valid_peer: peer_address /= Void
		local
			ext_addr: ANY
		do
			ext_addr := peer_address.socket_address;
			c_send_char_to (descriptor, c, 0, $ext_addr, peer_address.count)
		end;

	put_real, putreal (r: REAL) is
			-- Send real `r' through socket.
		require else
			socket_exists: exists;
			opened_for_write: is_open_write;
			valid_peer: peer_address /= Void
		local
			ext_addr: ANY
		do
			ext_addr := peer_address.socket_address;
			c_send_float_to (descriptor, r, 0, $ext_addr, peer_address.count)
		end;

	put_integer, putint (i: INTEGER) is
			-- Send integer `i' through socket.
		require else
			socket_exists: exists;
			opened_for_write: is_open_write;
			valid_peer: peer_address /= Void
		local
			ext_addr: ANY
		do
			ext_addr := peer_address.socket_address;
			c_send_int_to (descriptor, i, 0, $ext_addr, peer_address.count)
		end;

	put_boolean, putbool (b: BOOLEAN) is
			-- Send boolean `b' through socket.
		require else
			socket_exists: exists;
			opened_for_write: is_open_write;
			valid_peer: peer_address /= Void
		local
			ext_addr: ANY
		do
			ext_addr := peer_address.socket_address;
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
		local
			ext_addr: ANY
		do
			ext_addr := peer_address.socket_address;
			c_send_double_to (descriptor, d, 0, $ext_addr, peer_address.count)
		end;

feature {NONE} -- Implementation

	make_peer_address is
			-- Create a peer address.
		deferred
		ensure
			peer_created: peer_address /= Void
		end

feature {NONE} -- Externals

	c_rcv_from (fd: INTEGER; buf: POINTER; len:INTEGER; flags: INTEGER; addr: POINTER; l: POINTER): INTEGER is
			-- External routine to read `l' length of data
			-- from the socket identified by `fd' connected
			-- to a peer address of `addr'.
		external
			"C"
		end;

	c_send_to (fd: INTEGER; buf: POINTER; len: INTEGER; flags: INTEGER; addr: POINTER; l: INTEGER): INTEGER is
			-- External routine to write `l' length of data
			-- from the socket identified by `fd' connected
			-- to a peer address of `addr'.
		external
			"C"
		end;

	c_send_char_to (fd: INTEGER; c: CHARACTER; flags: INTEGER; addr: POINTER; length: INTEGER) is
			-- External routine to send character `c' to address `addr'
			-- through socket `fd'
		external
			"C"
		end;

	c_send_int_to (fd: INTEGER; i: INTEGER; flags: INTEGER; addr: POINTER; length: INTEGER) is
			-- External routine to send integer `i' to address `addr'
			-- through socket `fd'
		external
			"C"
		end;

	c_send_float_to (fd: INTEGER; r: REAL; flags: INTEGER; addr: POINTER; length: INTEGER) is
			-- External routine to send real `r' to address `addr'
			-- through socket `fd'
		external
			"C"
		end;

	c_send_double_to (fd: INTEGER; d: DOUBLE; flags: INTEGER; addr: POINTER; length: INTEGER) is
			-- External routine to send double `d' to address `addr'
			-- through socket `fd'
		external
			"C"
		end;

	c_send_stream_to (fd: INTEGER; s: POINTER; l: INTEGER; flags: INTEGER; addr: POINTER; length: INTEGER) is
			-- External routine to send stream pointed by `s'
			-- to address `addr' through socket `fd'
		external
			"C"
		end

end -- class DATAGRAM_SOCKET



--|----------------------------------------------------------------
--| EiffelNet: library of reusable components for ISE Eiffel.
--| Copyright (C) 1086-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

