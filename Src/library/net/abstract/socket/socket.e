indexing

	description:
		"A socket";

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class
	
	SOCKET

inherit

	SOCKET_R;

	IO_MEDIUM
		rename
			handle as descriptor,
			handle_available as descriptor_available
		end;

creation {SOCKET}

	create_from_descriptor

feature

	create_from_descriptor (fd: INTEGER) is
				-- create a socket object from the socket descriptor
				-- passed as an argument 'fd'
		local
			ext: ANY;
		do
			descriptor := fd;
			!!address.make;
			ext := address.socket_address;
			c_sock_name (descriptor, $ext, address.count);
			family :=  address.family;
			descriptor_available := True;
			is_open_read := True;
			is_open_write := True;
		ensure
			family_valid: family = address.family;
			opened_all: is_open_write and is_open_read;
		end;

	bind is 
				-- bind a socket to the local address
				-- contained in address
		require
			socket_exists: exists;
			valid_local_address: address /= Void;
		local
			ext: ANY;
		do
			ext := address.socket_address
			c_bind (descriptor, $ext, address.count);
			is_open_read := True;
		end


	connect is
				-- connect the socket to the peer address
				-- ie where we are going to send to
		require
			socket_exists: exists;
			valid_peer_address: peer_address /= Void;
		local
			ext: ANY;
		do
			ext := peer_address.socket_address;
			c_connect (descriptor, $ext, peer_address.count);
			is_open_write := True;
			is_open_read := True;
		end


	listen (que: INTEGER) is 
				-- listen on the socket for incoming
				-- messages and queue 'que' number
				-- of messages to be recieved
		require
			socket_exists: exists;
		do
			c_listen (descriptor, que);
		end;

	accept: like Current is
					-- accept a connection to a socket to
					-- recieve waiting messages.
					-- returns a new socket to recieve
					-- the messages on so the current
					-- socket is free to accept
					-- other connections which have 
					-- messages waiting
					-- A listen must have been called
					-- on the current socket before
					-- an accept calls can be made
		require
			socket_exists: exists;
		local
			pass_address: like address
			return: INTEGER;
			ext: ANY
		do
			pass_address := clone (address);
			ext := pass_address.socket_address;
			return := c_accept (descriptor, $ext, address.count);
			if return > 0 then
				!!Result.create_from_descriptor (return);
				Result.set_peer_address (pass_address);
			end;
		end


	make_socket is
				-- Create a socket descriptor
		require
			valid_family: family >= 0;
			valid_type: type >= 0;
			valid_protocol: protocol >= 0;
		do
			descriptor := c_socket (family, type, protocol);
			descriptor_available := True;
		end;

	close is
				-- close the socket
		require else
			socket_exists: exists; 
		do
			c_close_socket (descriptor);
			descriptor := -2;
			descriptor_available := False;
			is_open_read := False;
			is_open_write := False;
		end;

	is_closed: BOOLEAN is
			-- Is socket closed
		do
			Result := descriptor = -2;
		end;

	descriptor_available: BOOLEAN;
			-- Is the descriptor available?


	family: INTEGER;
				-- socket family eg. af_inet, unix

	protocol: INTEGER;
				-- protocol of the socket. default 0
				-- means for the system to chose the default
				-- protocol for the family chosen. eg. 'udp', 'tcp'

	type: INTEGER;
				-- the type of socket. eg stream, datagram

	address: SOCKET_ADDRESS;
				-- the local address of the socket

	peer_address: like address;
				-- the peer address of the socket

	set_peer_address (addr: like address) is
				-- set the peer address to addr
		require
			addr_not_void: addr /= Void;
		do
			peer_address := addr;
		ensure
			address_set: peer_address = addr;
		end;


	set_address (addr: like address) is
				-- set the local address to addr
		require
			same_type: addr.family = family;
		do
			address := addr;
		ensure
			address_set: address = addr;
		end;


	descriptor: INTEGER; 
				-- socket descriptor for the current socket

feature 


	name: STRING is
			-- socket name
		require else
			socket_exists: exists
		do
			!!Result.make (0);
		end;


	new_line is
			-- Write a new line character to medium
		require else
			socket_exists: exists;
			opened_for_write: is_open_write;
		do
			putchar ('%N');
		end;

	putstring (s: STRING) is
			-- Write `s' to medium
		require else
			socket_exists: exists;
			opened_for_write: is_open_write;
		local
			ext: ANY;
		do
				ext := s.to_c;
				c_put_string (descriptor, $ext);
		end;

	putchar (c: CHARACTER) is
			-- Write `c' to medium
		require else
			socket_exists: exists;
			opened_for_write: is_open_write;
		do
			c_put_char (descriptor, c);
		end;

	putreal (r: REAL) is
			-- Write ASCII value of `r' to medium
		require else
			socket_exists: exists;
			opened_for_write: is_open_write;
		do
			c_put_float (descriptor, r);
		end;

	putint (i: INTEGER) is
			-- Write ASCII value of `i' to medium.
		require else
			socket_exists: exists;
			opened_for_write: is_open_write;
		do
			c_put_int (descriptor, i);
		end;
	
	putbool (b: BOOLEAN) is
			-- Write ASCII value of `b' to medium.
		require else
			socket_exists: exists;
			opened_for_write: is_open_write;
		do
			if b then
				putstring ("True");
			else
				putstring ("FALSE");
			end;
		end;
	
	putdouble (d: DOUBLE) is
			-- Write ASCII value of `d' to medium.
		require else
			socket_exists: exists;
			opened_for_write: is_open_write;
		do
			c_put_double (descriptor, d);
		end;

	write (a_packet: PACKET) is
			-- write packet 'a_packet'
		require 
			socket_exists: exists;
			opened_for_write: is_open_write;
		local
			send_packet: PACKET;
			amount_sent: INTEGER;
			ext_data: ANY;
			return_val: INTEGER;
			count: INTEGER;
		do
			ext_data := a_packet.data;
			from 
			until
				a_packet.count = amount_sent 
			loop
				return_val := c_write (descriptor, $ext_data, a_packet.count - amount_sent);

				if return_val > 0 then
					amount_sent := amount_sent + return_val;
					if amount_sent < a_packet.count then
						if send_packet = Void then
							!!send_packet.make (a_packet.count - amount_sent);
							ext_data := send_packet.data;
						end;
						from
							count := 0
						until
							count = (a_packet.count - amount_sent)
						loop
							send_packet.put_element (a_packet.element (amount_sent + count), count);
							count := count + 1;
						end;
					end;
				end;

			end;
		end;

	send (a_packet: PACKET; flags: INTEGER) is
			-- Send a packet 'a_packet' of data
		require 
			socket_exists: exists;
			opened_for_write: is_open_write;
		local
			send_packet: PACKET;
			amount_sent: INTEGER;
			ext_data: ANY;
			return_val: INTEGER;
			count: INTEGER;
		do
			ext_data := a_packet.data;
			from 
			until
				a_packet.count = amount_sent 
			loop
				return_val := c_send (descriptor, $ext_data, a_packet.count - amount_sent, flags);

				if return_val > 0 then
					amount_sent := amount_sent + return_val;
					if amount_sent < a_packet.count then
						if send_packet = Void then
							!!send_packet.make (a_packet.count - amount_sent);
							ext_data := send_packet.data;
						end;
						from
							count := 0
						until
							count = (a_packet.count - amount_sent)
						loop
							send_packet.put_element (a_packet.element (amount_sent + count), count);
							count := count + 1;
						end;
					end;
				end;

			end;
		end;


	

	exists: BOOLEAN is
			-- Does socket exist?
		do
			Result := descriptor >= 0;
		end;

	is_open_write: BOOLEAN;
			-- Is socket opened for writting?

	is_open_read: BOOLEAN;
			-- Is socket opened for reading?


	is_readable: BOOLEAN is
			-- Is socket a readable medium?
		do
			Result := True;
		end;

	is_executable: BOOLEAN is
			-- Is socket executable?
		do
			Result := False;
		end;

	is_writable: BOOLEAN is
			-- Is socket writable?
		do
			Result := True;
		end;

	readable: BOOLEAN is
			-- is socket a readable medium
		do
			Result := True
		end;

	extendible: BOOLEAN is
			-- May new items be added?
		do
			Result := True;
		end;



feature -- Input

	readreal is
			-- Read a new real.
			-- Make result available in `lastreal'.
		require else
			socket_exists: exists;
			opened_for_read: is_open_read;
		do
			lastreal := c_read_float (descriptor);
		end;

	readdouble is
			-- Read a new double.
			-- Make result available in `lastdouble'.
		require else
			socket_exists: exists;
			opened_for_read: is_open_read;
		do
			lastdouble := c_read_double (descriptor);
		end;

	readchar is
			-- Read a new character.
			-- Make result available in `lastchar'.
		require else
			socket_exists: exists;
			opened_for_read: is_open_read;
		do
			lastchar := c_read_char (descriptor);
		end;

	readint is
			-- Read a new integer.
			-- Make result available in `lastint'.
		require else
			socket_exists: exists;
			opened_for_read: is_open_read;
		do
			lastint := c_read_int (descriptor);
		end;

	readstream (nb_char: INTEGER) is
			-- Read a string of at most  `nb_char'  characters
			-- Make result available in `laststring'.
		require else
			socket_exists: exists;
			opened_for_read: is_open_read;
		local
			ext: ANY;
			return_val: INTEGER;
		do
			
			if laststring = Void or else laststring.capacity <= nb_char then
				!!laststring.make (nb_char + 1);
			end
			ext := laststring.to_c;
			return_val := c_read_stream (descriptor, nb_char, $ext);
			laststring.set_count (return_val);
		end;

	readline is
			-- read a line of characters until a new line
		require else
			socket_exists: exists;
			opened_for_read: is_open_read;
		do
			if laststring = Void then
				!!laststring.make (512);
			end;
			readchar;
			from
			until lastchar = '%N'
			loop
				laststring.extend (lastchar);
				readchar;
			end;
		end;

	read (size: INTEGER): PACKET is
			-- Read a packet of data of size 'size'
		require 
			socket_exists: exists;
			opened_for_read: is_open_read;
		local
			recv_packet: PACKET;
			amount_read: INTEGER;
			return_val: INTEGER;
			ext_data: ANY;
			count: INTEGER;
		do	
			!!Result.make (size);
			!!recv_packet.make (size);
			ext_data := recv_packet.data;
			from
				amount_read := 0
			until
				amount_read = size 
			loop
				return_val := c_read (descriptor, $ext_data, size - amount_read);
				if return_val > 0 then
					from
						count := 0
					until
						count = return_val
					loop
						Result.put_element (recv_packet.element (count), count + amount_read)
						count := count + 1;
					end;
					amount_read := amount_read + return_val;
				else
					if amount_read = 0 then
						Result := Void;
					end;
				end;
			end;

		end;

	receive (size, flags: INTEGER): PACKET is
				-- receive a packet of size 'size'
		require 
			socket_exists: exists;
			opened_for_read: is_open_read;
		local
			recv_packet: PACKET;
			amount_read: INTEGER;
			return_val: INTEGER;
			ext_data: ANY;
			count: INTEGER;
		do	
			!!Result.make (size);
			!!recv_packet.make (size);
			ext_data := recv_packet.data;
			from
				amount_read := 0
			until
				amount_read = size
			loop
				return_val := c_receive (descriptor, $ext_data, size - amount_read, flags);
				if return_val > 0 then
					from
						count := 0
					until
						count = return_val
					loop
						Result.put_element (recv_packet.element (count), count + amount_read)
						count := count + 1;
					end;
					amount_read := amount_read + return_val;
				else
					if amount_read = 0 then
						Result := Void;
					end;
				end;
			end;

		end;



			
feature -- socket options

	enable_debug is
			-- enable socket system debugging
		require
			socket_exists: exists;
		do
			c_set_sock_opt_int (descriptor, level_sol_socket, sodebug, 1);
		end;

	disable_debug is
			-- disable socket system debugging
		require
			socket_exists: exists;
		do
			c_set_sock_opt_int (descriptor, level_sol_socket, sodebug, 0);
		end;

	debug_enabled: BOOLEAN is
			-- is socket system debugging enabled
		require
			socket_exists: exists;
		local
			is_set: INTEGER;
		do
			is_set := c_get_sock_opt_int (descriptor, level_sol_socket, sodebug);
			Result := is_set /= 0;
		end;
			
	do_not_route is
			-- Set socket to non-routing
		require
			socket_exists: exists;
		do
			c_set_sock_opt_int (descriptor, level_sol_socket, so_dont_route, 1);
		end;
	
	route is
		require
			socket_exists: exists;
		do
			c_set_sock_opt_int (descriptor, level_sol_socket, so_dont_route, 0);
		end;

	route_enabled: BOOLEAN is
			-- Is routing enabled
		require
			socket_exists: exists;
		local
			is_set: INTEGER;
		do
			is_set := c_get_sock_opt_int (descriptor, level_sol_socket, so_dont_route);
			Result := is_set /= 0;
		end;
	
	set_receive_buf_size (s: INTEGER) is
		require
			socket_exists: exists;
		do
			c_set_sock_opt_int (descriptor, level_sol_socket, so_rcv_buf, s);
		ensure
			size_set: s = receive_buf_size;
		end;

	receive_buf_size: INTEGER is
			-- Size of the receive buffer
		require
			socket_exists: exists;
		do
			Result := c_get_sock_opt_int (descriptor, level_sol_socket, so_rcv_buf);
		end;
	
	set_send_buf_size (s: INTEGER) is
			-- Set the send buffer to size 's'
		require
			socket_exists: exists;
		do
			c_set_sock_opt_int (descriptor, level_sol_socket, so_snd_buf, s);
		ensure
			size_set: s = send_buf_size;
		end;

	send_buf_size: INTEGER is
			-- Size of the send buffer
		require
			socket_exists: exists;
		do
			Result := c_get_sock_opt_int (descriptor, level_sol_socket, so_snd_buf);
		end;

	is_socket_stream: BOOLEAN is
			-- Is the socket a stream
		require
			socket_exists: exists;
		local
			is_soc_s: INTEGER;
		do
			is_soc_s := c_get_sock_opt_int (descriptor, level_sol_socket, sotype);
			Result := is_soc_s = sock_stream;
		end;

	set_non_blocking is
			-- set socket to non-blocking mode
		require
			socket_exists: exists;
		do
			c_set_non_blocking (descriptor);
		end;

	set_blocking is
			-- Set socket blocking mode
		require
			socket_exists: exists;
		do
			c_set_blocking (descriptor);
		end;


	is_non_blocking: BOOLEAN is
			-- is the socket non-blocking 
		require
			socket_exists: exists;
		local
			is_bl: INTEGER;
		do
			is_bl := c_fcntl (descriptor, c_fgetfl, c_fndelay);
			Result := is_bl /= 0;
		end;

		
	set_owner (own: INTEGER) is
			-- negative value sets group process id
			-- positive value sets process id
		require
			socket_exists: exists;
			valid_owner: own /= 0 and own /= -1;
		local
			return_val: INTEGER
		do
			return_val := c_fcntl (descriptor, c_fsetown, own);
		ensure
			set_id: own < -1 implies own = group_id or else
				own > 0 implies own = process_id;
		end;

	is_group_id: BOOLEAN is
			-- is the owner id of the socket a group id
		require
			socket_exists: exists;
		local
			is_grp: INTEGER;
		do
			is_grp := c_fcntl (descriptor, c_fgetown, 0);
			Result := is_grp < -1;
		end;

	is_process_id: BOOLEAN is
			-- is the owner id of the socket a process id
		require
			socket_exists: exists;
		local
			is_proc: INTEGER;
		do
			is_proc := c_fcntl (descriptor, c_fgetown, 0);
			Result := is_proc > 0;
		end;


	group_id: INTEGER is
			-- group id for socket
		require
			socket_exists: exists;
			group_set: is_group_id;
		do
			Result := (c_fcntl (descriptor, c_fgetown, 0) * -1);
		end;



	process_id: INTEGER is
			-- process id for socket
		require
			socket_exists: exists;
			process_set: is_process_id;
		do
			Result := c_fcntl (descriptor, c_fgetown, 0);
		end;

feature {NONE}

	c_socket (add_family, a_type, protoc: INTEGER): INTEGER is
					-- external c routine to create the socket descriptor
		external
			"C"
		end;


	c_bind (soc: INTEGER; addr: ANY; length: INTEGER) is
					-- external c routine to bind the socket descriptor
					-- to a local address
		external
			"C"
		end;


	c_accept (soc: INTEGER; addr: ANY; length: INTEGER): INTEGER is
					-- external c routine to accept a socket connect
					-- by returning a new socket descriptor to the
					-- socket we are going to recieve messages from
		external
			"C"
		end;


	c_listen (soc, backlog: INTEGER) is
					-- external c routine that tells
					-- the socket to listen for connections
					-- so we can use accept to provide
					-- a connection to recieve messages
		external
			"C"
		end;


	c_connect (soc: INTEGER; addr: ANY; length: INTEGER) is
					-- external c routine that connect the socket
					-- to the peer address
		external
			"C"
		end;
	
	c_close_socket (s: INTEGER) is
					-- external c routine to close the socket identified
					-- by the descriptor s
		external
			"C"
		end;

	c_unlink (nam: ANY) is
					-- external c routine to remove a socket from the
					-- system
		external
			"C"
		end;

	c_sock_name (soc: INTEGER; addr: ANY; length: INTEGER) is
					-- external c routine that returns the socket name
		external
			"C"
		end;

	c_peer_name (soc: INTEGER; addr: ANY; length: INTEGER): INTEGER is
					-- external routine that returns the peers socket name
		external
			"C"
		end;

	c_put_bool (fd: INTEGER; b: BOOLEAN) is
					-- external routine to write a boolean to a socket
					-- identified by fd
		external
			"C"
		end;


	c_put_char (fd: INTEGER; c: CHARACTER) is
					-- external routine to write a character to a socket
					-- identified by fd
		external
			"C"
		end;


	c_put_int (fd: INTEGER; i: INTEGER) is
					-- external routine to write a integer to a socket
					-- identified by fd
		external
			"C"
		end;


	c_put_float (fd: INTEGER; f: REAL) is
					-- external routine to write a real to a socket
					-- identified by fd
		external
			"C"
		end;


	c_put_double (fd: INTEGER; d: DOUBLE) is
					-- external routine to write a double to a socket
					-- identified by fd
		external
			"C"
		end;


	c_put_string (fd: INTEGER; s: ANY) is
					-- external routine to write a string to a socket
					-- identified by fd
		external
			"C"
		end;


	c_read_char (fd: INTEGER): CHARACTER is
					-- external routine to read a character from a socket
					-- identified by fd
		external
			"C"
		end;


	c_read_int (fd: INTEGER): INTEGER is
					-- external routine to read a integer from a socket
					-- identified by fd
		external
			"C"
		end;


	c_read_float (fd: INTEGER): REAL is
					-- external routine to read a real from a socket
					-- identified by fd
		external
			"C"
		end;


	c_read_double (fd: INTEGER): DOUBLE is
					-- external routine to read a double from a socket
					-- identified by fd
		external
			"C"
		end;


	c_read_stream (fd: INTEGER; l: INTEGER; buf: ANY): INTEGER is
					-- external routine to read a 'l' number of characters
					-- from a socket identified by fd
		external
			"C"
		end;

	c_read (fd: INTEGER; buf:ANY; l: INTEGER): INTEGER is
				   -- external routine to read 'l' length of
					-- data from the socket identified by
		external
			"C"
		end;


	c_write (fd: INTEGER; buf: ANY; l: INTEGER): INTEGER is
					-- external routine to write 'l' length of data
					-- from the socket identified by fd 
		external
			"C"
		end;


	c_receive (fd: INTEGER; buf: ANY; len: INTEGER; flags: INTEGER): INTEGER is
			-- Socket receive data routine
		external
			"C"
		end;

	c_send (fd: INTEGER; buf: ANY; len: INTEGER; flags: INTEGER): INTEGER is
			-- Socket send data routine
		external
			"C"
		end;


	c_set_sock_opt_int (fd, level, opt, val: INTEGER) is
			-- C routine to set socket options of integer type
		external
			"C"
		end;

	c_get_sock_opt_int (fd, level, opt: INTEGER): INTEGER is
			-- C routine to get socket options of integer type
		external
			"C"
		end;

	c_fcntl (fd, cmd, arg: INTEGER): INTEGER is
			-- c wrapper to fcntl() routine
		external
			"C"
		end;

	c_set_non_blocking (fd: INTEGER) is
			-- C routine to set the socket as non-blocking
		external
			"C"
		end;

	c_set_blocking (fd: INTEGER) is
			-- C routine to set the socket as blocking
		external
			"C"
		end;

end 	-- Class socket

--|----------------------------------------------------------------
--| Eiffelnet: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1994, Interactive Software
--|   Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <eiffel@eiffel.com>
--|----------------------------------------------------------------

