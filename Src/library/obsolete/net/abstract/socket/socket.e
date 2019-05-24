note

	description: "Generic sockets"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class

	SOCKET

inherit

	SOCKET_RESOURCES

	IO_MEDIUM
		rename
			handle as descriptor,
			handle_available as descriptor_available
		end

	EXCEPTIONS
		export
			{NONE} all
		end

	PLATFORM
		export
			{NONE} all
		end

create {SOCKET}

	create_from_descriptor

feature -- Initialization

	create_from_descriptor (fd: INTEGER)
			-- Create socket from descriptor `fd'.
		local
			retried: BOOLEAN
		do
			if not retried then
				descriptor := fd
				create address.make
				c_sock_name (descriptor, address.socket_address.item, address.count)
				family := address.family
				descriptor_available := True
				is_open_read := True
				is_open_write := True
			end
		ensure
			family_valid: family = address.family;
			opened_all: is_open_write and is_open_read
		rescue
			if not assertion_violation then
				is_open_read := False
				is_open_write := False
				retried := True
				retry
			end
		end

feature -- Access

	retrieved: ANY
			-- Retrieved object structure
			-- To access resulting object under correct type,
			-- use assignment attempt.
			-- Will raise an exception (code `Retrieve_exception')
			-- if content is not a stored Eiffel structure.
		require else
			socket_exists: exists;
			opened_for_read: is_open_read
			support_storable: support_storable
		local
			was_blocking: BOOLEAN
		do
			(create {MISMATCH_CORRECTOR}).mismatch_information.do_nothing
			was_blocking := is_blocking
			set_blocking
			Result := eif_net_retrieved (descriptor)
			if not was_blocking then
				set_non_blocking
			end
		end

feature -- Status report

	support_storable: BOOLEAN
			-- Can medium be used to store an Eiffel structure?
		do
			Result := False
		end

	is_valid_peer_address (addr: SOCKET_ADDRESS): BOOLEAN
			-- Is `addr' a valid peer address?
		require
			address_exists: addr /= Void
		do
			Result := True
		end

feature -- Element change

	basic_store (object: ANY)
			-- Produce an external representation of the
			-- entire object structure reachable from `object'.
			-- Retrievable within current system only.
		require else
			socket_exists: exists
			opened_for_write: is_open_write
			support_storable: support_storable
		do
			eif_net_basic_store (descriptor, $object)
		end

	general_store (object: ANY)
			-- Produce an external representation of the
			-- entire object structure reachable from `object'.
			-- Retrievable from other systems for same platform
			-- (machine architecture).
			--| This feature may use a visible name of a class written
			--| in the `visible' clause of the Ace file. This makes it
			--| possible to overcome class name clashes.
		require else
			socket_exists: exists
			opened_for_write: is_open_write
			support_storable: support_storable
		do
			eif_net_general_store (descriptor, $object)
		end

	independent_store (object: ANY)
			-- Produce an external representation of the
			-- entire object structure reachable from `object'.
			-- Retrievable from other systems for the same or other
			-- platform (machine architecture).
		require else
			socket_exists: exists
			opened_for_write: is_open_write
			support_storable: support_storable
		do
			eif_net_independent_store (descriptor, $object)
		end

feature -- Basic commands

	bind
			-- Bind socket to local address in `address'.
		require
			socket_exists: exists;
			valid_local_address: address /= Void
		local
			retried: BOOLEAN
		do
			if not retried then
				c_bind (descriptor, address.socket_address.item, address.count)
				is_open_read := True
			end
		rescue
			if not assertion_violation then
				is_open_read := False
				retried := True
				retry
			end
		end

	connect
			-- Connect socket to peer address.
		require
			socket_exists: exists
			valid_peer_address: peer_address /= Void
		local
			retried: BOOLEAN
		do
			if not retried then
				c_connect (descriptor, peer_address.socket_address.item, peer_address.count)
				is_open_write := True
				is_open_read := True
			end
		rescue
			if not assertion_violation then
				is_open_read := False
				is_open_write := False
				retried := True
				retry
			end
		end

	make_socket
			-- Create socket descriptor.
		require
			valid_family: family >= 0
			valid_type: type >= 0
			valid_protocol: protocol >= 0
		do
			descriptor := c_socket (family, type, protocol);
			if descriptor > -1 then
				descriptor_available := True
				set_blocking
			end
		end

	cleanup
			-- Cleanup socket.
		do
			if exists then
				close
			end
		end

	close
			-- Close socket for all context.
		require else
			socket_exists: exists
		do
			if is_open_read or is_open_write then
				c_shutdown (descriptor, 2)
			end
			if exists then
				close_socket
			end
		end

	close_socket
			-- Close socket for current context.
		require
			socket_exists: exists
		do
			c_close_socket (descriptor)
			descriptor := -2
			descriptor_available := False
			is_open_read := False
			is_open_write := False
		ensure
			is_closed: is_closed
		end

	is_closed: BOOLEAN
			-- Is socket closed?
		do
			Result := descriptor = -2
		end

	descriptor_available: BOOLEAN
			-- Is descriptor available?


	family: INTEGER
			-- Socket family eg. af_inet, af_unix

	protocol: INTEGER
			-- Protocol of the socket. default 0
			-- means for the system to chose the default
			-- protocol for the family chosen. eg. `udp', `tcp'.

	type: INTEGER
			-- Type of socket. eg stream, datagram

	address: SOCKET_ADDRESS
			-- Local address of socket

	peer_address: like address
			-- Peer address of socket

	set_peer_address (addr: like address)
			-- Set peer address to `addr'.
		require
			address_exists: addr /= Void
			address_valid: is_valid_peer_address (addr)
		do
			peer_address := addr
		ensure
			address_set: peer_address = addr
		end

	set_address (addr: like address)
			-- Set local address to `addr'.
		require
			same_type: addr.family = family
		do
			address := addr
		ensure
			address_set: address = addr
		end

	descriptor: INTEGER
			-- Socket descriptor of current socket

feature -- Miscellaneous

	name: STRING
			-- Socket name
		require else
			socket_exists: exists
		do
			create Result.make (0)
		end

feature -- Output

	put_new_line, new_line
			-- Write a "new_line" character to socket.
		require else
			socket_exists: exists;
			opened_for_write: is_open_write
		do
			put_character ('%N')
		end

	put_string, putstring (s: STRING)
			-- Write string `s' to socket.
		require else
			socket_exists: exists;
			opened_for_write: is_open_write
		local
			ext: C_STRING
		do
			create ext.make (s)
			c_put_stream (descriptor, ext.item, s.count)
		end

	put_managed_pointer (p: MANAGED_POINTER; start_pos, nb_bytes: INTEGER)
			-- Put data of length `nb_bytes' pointed by `start_pos' index in `p' at
			-- current position.
		require else
			p_not_void: p /= Void
			p_large_enough: p.count >= nb_bytes + start_pos
			nb_bytes_non_negative: nb_bytes >= 0
			socket_exists: exists
			opened_for_write: is_open_write
		do
			c_put_stream (descriptor, p.item + start_pos, nb_bytes)
		end

	put_character, putchar (c: CHARACTER)
			-- Write character `c' to socket.
		require else
			socket_exists: exists;
			opened_for_write: is_open_write
		do
			c_put_char (descriptor, c)
		end

	put_real, putreal, put_real_32 (r: REAL_32)
			-- Write real `r' to socket.
		require else
			socket_exists: exists;
			opened_for_write: is_open_write
		do
			c_put_float (descriptor, r)
		end

	put_integer, putint, put_integer_32 (i: INTEGER)
			-- Write integer `i' to socket.
		require else
			socket_exists: exists;
			opened_for_write: is_open_write
		do
			c_put_int (descriptor, i)
		end

	put_integer_8 (i: INTEGER_8)
			-- Write integer `i' to socket.
		require else
			socket_exists: exists
			opened_for_write: is_open_write
		do
			socket_buffer.put_integer_8_be (i, 0)
			put_managed_pointer (socket_buffer, 0, integer_8_bytes)
		end

	put_integer_16 (i: INTEGER_16)
			-- Write integer `i' to socket.
		require else
			socket_exists: exists
			opened_for_write: is_open_write
		do
			socket_buffer.put_integer_16_be (i, 0)
			put_managed_pointer (socket_buffer, 0, integer_16_bytes)
		end

	put_integer_64 (i: INTEGER_64)
			-- Write integer `i' to socket.
		require else
			socket_exists: exists
			opened_for_write: is_open_write
		do
			socket_buffer.put_integer_64_be (i, 0)
			put_managed_pointer (socket_buffer, 0, integer_64_bytes)
		end

	put_natural_8 (i: NATURAL_8)
			-- Write natural `i' to socket.
		require else
			socket_exists: exists
			opened_for_write: is_open_write
		do
			socket_buffer.put_natural_8_be (i, 0)
			put_managed_pointer (socket_buffer, 0, natural_8_bytes)
		end

	put_natural_16 (i: NATURAL_16)
			-- Write natural `i' to socket.
		require else
			socket_exists: exists
			opened_for_write: is_open_write
		do
			socket_buffer.put_natural_16_be (i, 0)
			put_managed_pointer (socket_buffer, 0, natural_16_bytes)
		end

	put_natural, put_natural_32 (i: NATURAL_32)
			-- Write natural `i' to socket.
		require else
			socket_exists: exists
			opened_for_write: is_open_write
		do
			socket_buffer.put_natural_32_be (i, 0)
			put_managed_pointer (socket_buffer, 0, natural_32_bytes)
		end

	put_natural_64 (i: NATURAL_64)
			-- Write natural `i' to socket.
		require else
			socket_exists: exists
			opened_for_write: is_open_write
		do
			socket_buffer.put_natural_64_be (i, 0)
			put_managed_pointer (socket_buffer, 0, natural_64_bytes)
		end

	put_boolean, putbool (b: BOOLEAN)
			-- Write boolean `b' to socket.
		require else
			socket_exists: exists;
			opened_for_write: is_open_write
		do
			if b then
				put_character ('T')
			else
				put_character ('F')
			end
		end

	put_double, putdouble, put_real_64 (d: REAL_64)
			-- Write double `d' to socket.
		require else
			socket_exists: exists;
			opened_for_write: is_open_write
		do
			c_put_double (descriptor, d)
		end

	write (a_packet: PACKET)
			-- Write packet `a_packet' to socket.
		require
			socket_exists: exists;
			opened_for_write: is_open_write
		local
			amount_sent: INTEGER
			ext_data: POINTER
			return_val: INTEGER
			count: INTEGER
		do
			from
				ext_data := a_packet.data.item;
				count := a_packet.count
			until
				count = amount_sent
			loop
				return_val := c_write (descriptor, ext_data, count - amount_sent);
				if return_val > 0 then
					ext_data := ext_data + return_val
					amount_sent := amount_sent + return_val;
				end
			end
		end

	send (a_packet: PACKET; flags: INTEGER)
			-- Send a packet `a_packet' of data to socket.
		require
			socket_exists: exists
			opened_for_write: is_open_write
			valid_packet: a_packet /= Void
		local
			amount_sent: INTEGER
			ext_data: POINTER
			return_val: INTEGER
			count: INTEGER
		do
			from
				ext_data := a_packet.data.item
				count := a_packet.count
			until
				count = amount_sent
			loop
				return_val := c_send (descriptor, ext_data, count - amount_sent, flags);
				if return_val > 0 then
					amount_sent := amount_sent + return_val
					ext_data := ext_data + return_val
				end
			end
		end

	exists: BOOLEAN
			-- Does socket exist?
		do
			Result := descriptor >= 0
		end;

	is_open_write: BOOLEAN
			-- Is socket opened for writing?

	is_open_read: BOOLEAN
			-- Is socket opened for reading?

	is_readable: BOOLEAN
			-- Is socket a readable medium?
		do
			Result := True
		end

	is_executable: BOOLEAN
			-- Is socket an executable?
		do
			Result := False
		end

	is_writable: BOOLEAN
			-- Is socket a writable medium?
		do
			Result := True
		end;

	readable: BOOLEAN
			-- Is there currently any data available on socket?
		do
			Result := c_select_poll (descriptor) /= 0
		end

	extendible: BOOLEAN
			-- May new items be added?
		do
			Result := True
		end

feature -- Input

	read_real, readreal, read_real_32
			-- Read a new real.
			-- Make result available in `last_real'.
		require else
			socket_exists: exists;
			opened_for_read: is_open_read
		do
			read_to_managed_pointer (socket_buffer, 0, real_32_bytes)
			last_real := socket_buffer.read_real_32_be (0)
		end

	read_double, readdouble, read_real_64
			-- Read a new double.
			-- Make result available in `last_double'.
		require else
			socket_exists: exists;
			opened_for_read: is_open_read
		do
			read_to_managed_pointer (socket_buffer, 0, real_64_bytes)
			last_double := socket_buffer.read_real_64_be (0)
		end

	read_character, readchar
			-- Read a new character.
			-- Make result available in `last_character'.
		require else
			socket_exists: exists;
			opened_for_read: is_open_read
		do
			read_to_managed_pointer (socket_buffer, 0, character_8_bytes)
			last_character := socket_buffer.read_character (0)
		end

	read_boolean, readbool
			-- Read a new boolean.
			-- Maker result available in `last_boolean'.
		require else
			socket_exists: exists;
			opened_for_read: is_open_read
		do
			read_character;
			if last_character = 'T' then
				last_boolean := True
			else
				last_boolean := False
			end
		end

	last_boolean: BOOLEAN
			-- Last boolean read by read_boolean

	read_integer, readint, read_integer_32
			-- Read a new 32-bit integer.
			-- Make result available in `last_integer'.
		require else
			socket_exists: exists;
			opened_for_read: is_open_read
		do
			read_to_managed_pointer (socket_buffer, 0, integer_32_bytes)
			last_integer := socket_buffer.read_integer_32_be (0)
		end;

	read_integer_8
			-- Read a new 8-bit integer.
			-- Make result available in `last_integer_8'.
		require else
			socket_exists: exists
			opened_for_read: is_open_read
		do
			read_to_managed_pointer (socket_buffer, 0, integer_8_bytes)
			last_integer_8 := socket_buffer.read_integer_8_be (0)
		end

	read_integer_16
			-- Read a new 16-bit integer.
			-- Make result available in `last_integer_16'.
		require else
			socket_exists: exists
			opened_for_read: is_open_read
		do
			read_to_managed_pointer (socket_buffer, 0, integer_16_bytes)
			last_integer_16 := socket_buffer.read_integer_16_be (0)
		end

	read_integer_64
			-- Read a new 64-bit integer.
			-- Make result available in `last_integer_64'.
		require else
			socket_exists: exists
			opened_for_read: is_open_read
		do
			read_to_managed_pointer (socket_buffer, 0, integer_64_bytes)
			last_integer_64 := socket_buffer.read_integer_64_be (0)
		end

	read_natural_8
			-- Read a new 8-bit natural.
			-- Make result available in `last_natural_8'.
		require else
			socket_exists: exists
			opened_for_read: is_open_read
		do
			read_to_managed_pointer (socket_buffer, 0, natural_8_bytes)
			last_natural_8 := socket_buffer.read_natural_8_be (0)
		end

	read_natural_16
			-- Read a new 16-bit natural.
			-- Make result available in `last_natural_16'.
		require else
			socket_exists: exists
			opened_for_read: is_open_read
		do
			read_to_managed_pointer (socket_buffer, 0, natural_16_bytes)
			last_natural_16 := socket_buffer.read_natural_16_be (0)
		end

	read_natural, read_natural_32
			-- Read a new 32-bit natural.
			-- Make result available in `last_natural'.
		require else
			socket_exists: exists
			opened_for_read: is_open_read
		do
			read_to_managed_pointer (socket_buffer, 0, natural_32_bytes)
			last_natural := socket_buffer.read_natural_32_be (0)
		end

	read_natural_64
			-- Read a new 64-bit natural.
			-- Make result available in `last_natural_64'.
		require else
			socket_exists: exists
			opened_for_read: is_open_read
		do
			read_to_managed_pointer (socket_buffer, 0, natural_64_bytes)
			last_natural_64 := socket_buffer.read_natural_64_be (0)
		end

	read_stream, readstream (nb_char: INTEGER)
			-- Read a string of at most `nb_char' characters.
			-- Make result available in `last_string'.
		require else
			socket_exists: exists;
			opened_for_read: is_open_read
		local
			ext: C_STRING
			return_val: INTEGER
		do
			create ext.make_empty (nb_char + 1)
			return_val := c_read_stream (descriptor, nb_char, ext.item);
			bytes_read := return_val
			if return_val >= 0 then
				ext.set_count (return_val)
				last_string := ext.substring (1, return_val)
			else
					-- All errors except EWOULDBLOCK will raise an I/O
					-- exception
				create last_string.make (0)
			end
		end

	read_to_managed_pointer (p: MANAGED_POINTER; start_pos, nb_bytes: INTEGER)
			-- Read at most `nb_bytes' bound bytes and make result
			-- available in `p' at position `start_pos'.
		require else
			p_not_void: p /= Void
			p_large_enough: p.count >= nb_bytes + start_pos
			nb_bytes_non_negative: nb_bytes >= 0
			socket_exists: exists
			opened_for_read: is_open_read
		local
			l_read: INTEGER
			l_last_read: INTEGER
		do
			from
				l_last_read := -1
			until
				l_read = nb_bytes or l_last_read = 0
			loop
				l_last_read := c_read_stream (descriptor, nb_bytes - l_read,
					p.item + start_pos + l_read);
				l_read := l_read + l_last_read
			end
			bytes_read := l_read
		end

	read_line, readline
			-- Read a line of characters (ended by a new_line).
		require else
			socket_exists: exists;
			opened_for_read: is_open_read
		do
			create last_string.make (512);
			read_character;
			from
			until
				last_character = '%N'
			loop
				last_string.extend (last_character)
				read_character
			end
		end

	read (size: INTEGER): PACKET
			-- Read a packet of data of maximum size `size'.
		require
			socket_exists: exists;
			opened_for_read: is_open_read
		local
			l_data, recv_packet: MANAGED_POINTER;
			amount_read: INTEGER;
			return_val: INTEGER;
			ext_data: POINTER;
		do
			ext_data := ext_data.memory_alloc (size)
			from
				amount_read := 0
				return_val := -1
			until
				amount_read = size or return_val = 0
			loop
				return_val := c_read_stream (descriptor, size - amount_read, ext_data);
				if return_val > 0 then
					create recv_packet.make_from_pointer (ext_data, return_val)
					if l_data = Void then
						l_data := recv_packet.twin
					else
						l_data.append (recv_packet)
					end
					amount_read := amount_read + return_val
				end
			end
			if l_data /= Void then
				create Result.make_from_managed_pointer (l_data)
			end
			bytes_read := amount_read
		end

	receive (size, flags: INTEGER): PACKET
			-- Receive a packet of maximum size `size'.
		require
			socket_exists: exists;
			opened_for_read: is_open_read
		local
			l_data, recv_packet: MANAGED_POINTER
			amount_read: INTEGER;
			return_val: INTEGER;
			ext_data: POINTER;
		do
			ext_data := ext_data.memory_alloc (size)
			from
				amount_read := 0
			until
				amount_read = size
			loop
				return_val := c_receive (descriptor, ext_data, size - amount_read, flags);
				if return_val > 0 then
					create recv_packet.make_from_pointer (ext_data, return_val)
					if l_data = Void then
						l_data := recv_packet.twin
					else
						l_data.append (recv_packet)
					end
					amount_read := amount_read + return_val
				else
					if amount_read = 0 then
						l_data := Void
					end
				end
			end
			if l_data /= Void then
				create Result.make_from_managed_pointer (l_data)
			end
		end

feature -- socket options

	enable_debug
			-- Enable socket system debugging.
		require
			socket_exists: exists
		do
			c_set_sock_opt_int (descriptor, level_sol_socket, sodebug, 1)
		end

	disable_debug
			-- Disable socket system debugging.
		require
			socket_exists: exists
		do
			c_set_sock_opt_int (descriptor, level_sol_socket, sodebug, 0)
		end

	debug_enabled: BOOLEAN
			-- Is socket system debugging enabled?
		require
			socket_exists: exists
		local
			is_set: INTEGER
		do
			is_set := c_get_sock_opt_int (descriptor, level_sol_socket, sodebug);
			Result := is_set /= 0
		end

	do_not_route
			-- Set socket to non-routing.
		require
			socket_exists: exists
		do
			c_set_sock_opt_int (descriptor, level_sol_socket, so_dont_route, 1)
		end

	route
			-- Set socket to routing.
		require
			socket_exists: exists
		do
			c_set_sock_opt_int (descriptor, level_sol_socket, so_dont_route, 0)
		end

	route_enabled: BOOLEAN
			-- Is routing enabled?
		require
			socket_exists: exists
		local
			is_set: INTEGER
		do
			is_set := c_get_sock_opt_int (descriptor, level_sol_socket, so_dont_route);
			Result := is_set /= 0
		end

	set_receive_buf_size (s: INTEGER)
			-- Set receive buffer size.
		require
			socket_exists: exists
		do
			c_set_sock_opt_int (descriptor, level_sol_socket, so_rcv_buf, s)
		ensure
			size_set: s = receive_buf_size
		end

	receive_buf_size: INTEGER
			-- Size of receive buffer.
		require
			socket_exists: exists
		do
			Result := c_get_sock_opt_int (descriptor, level_sol_socket, so_rcv_buf)
		end

	set_send_buf_size (s: INTEGER)
			-- Set the send buffer to size `s'.
		require
			socket_exists: exists
		do
			c_set_sock_opt_int (descriptor, level_sol_socket, so_snd_buf, s)
		ensure
			size_set: s = send_buf_size
		end

	send_buf_size: INTEGER
			-- Size of send buffer.
		require
			socket_exists: exists
		do
			Result := c_get_sock_opt_int (descriptor, level_sol_socket, so_snd_buf)
		end

	is_socket_stream: BOOLEAN
			-- Is the socket a stream?
		require
			socket_exists: exists
		local
			is_soc_s: INTEGER
		do
			is_soc_s := c_get_sock_opt_int (descriptor, level_sol_socket, sotype);
			Result := is_soc_s = sock_stream
		end

	set_non_blocking
			-- Set socket to non-blocking mode.
		require
			socket_exists: exists
		do
			c_set_non_blocking (descriptor);
			is_blocking := False
		ensure
			not is_blocking
		end

	set_blocking
			-- Set socket to blocking mode.
		require
			socket_exists: exists
		do
			c_set_blocking (descriptor);
			is_blocking := True
		ensure
			is_blocking
		end

	is_blocking: BOOLEAN
			-- Is the socket blocking?

	set_owner (own: INTEGER)
			-- Negative value sets group process id.
			-- positive value sets process id.
		require
			socket_exists: exists;
			valid_owner: own /= 0 and own /= -1
		local
			return_val: INTEGER
		do
			return_val := c_fcntl (descriptor, c_fsetown, own)
		ensure
			set_id: own < -1 implies own = group_id or else
				own > 0 implies own = process_id
		end

	is_group_id: BOOLEAN
			-- Is the owner id the socket group id?
		require
			socket_exists: exists
		local
			is_grp: INTEGER
		do
			is_grp := c_fcntl (descriptor, c_fgetown, 0);
			Result := is_grp < -1
		end

	is_process_id: BOOLEAN
			-- Is the owner id the socket process id?
		require
			socket_exists: exists
		local
			is_proc: INTEGER
		do
			is_proc := c_fcntl (descriptor, c_fgetown, 0);
			Result := is_proc > 0
		end

	group_id: INTEGER
			-- Group id of socket
		require
			socket_exists: exists;
			group_set: is_group_id
		do
			Result := (c_fcntl (descriptor, c_fgetown, 0) * -1)
		end

	process_id: INTEGER
			-- Process id of socket
		require
			socket_exists: exists;
			process_set: is_process_id
		do
			Result := c_fcntl (descriptor, c_fgetown, 0)
		end

feature {NONE} -- Externals

	socket_buffer: MANAGED_POINTER
			-- Buffer used to read/write basic types.
		do
			if internal_socket_buffer = Void then
				create internal_socket_buffer.make (16)
			end
			Result := internal_socket_buffer
		end

	internal_socket_buffer: MANAGED_POINTER
			-- Internal integer buffer

	c_socket (add_family, a_type, protoc: INTEGER): INTEGER
			-- External c routine to create the socket descriptor
		external
			"C"
		end

	c_bind (soc: INTEGER; addr: POINTER; length: INTEGER)
			-- External c routine to bind the socket descriptor
			-- to a local address
		external
			"C"
		end

	c_connect (soc: INTEGER; addr: POINTER; length: INTEGER)
			-- External c routine that connect the socket
			-- to the peer address
		external
			"C blocking"
		end

	c_shutdown (s: INTEGER; how: INTEGER)
			-- Shut down socket `s' with `how' modality
			-- (0 no more receive, 1 no more send, 2 no more both)
		external
			"C blocking"
		end

	c_close_socket (s: INTEGER)
			-- External c routine to close the socket identified
			-- by the descriptor `s'
		external
			"C"
		end

	c_sock_name (soc: INTEGER; addr: POINTER; length: INTEGER)
			-- External c routine that returns the socket name.
		external
			"C"
		end

	c_peer_name (soc: INTEGER; addr: POINTER; length: INTEGER): INTEGER
			-- External routine that returns the peers socket name
		external
			"C"
		end

	c_put_char (fd: INTEGER; c: CHARACTER)
			-- External routine to write character `c' to socket `fd'
		external
			"C blocking"
		end

	c_put_int (fd: INTEGER; i: INTEGER)
			-- External routine to write integer `i' to socket `fd'
		external
			"C blocking"
		end

	c_put_float (fd: INTEGER; r: REAL)
			-- External routine to write real `r' to socket `fd'
		external
			"C blocking"
		end

	c_put_double (fd: INTEGER; d: DOUBLE)
			-- External routine to write double `d' to socket `fd'
		external
			"C blocking"
		end

	c_put_stream (fd: INTEGER; s: POINTER; length: INTEGER)
			-- External routine to write stream pointed by `s' of
			-- length `length' to socket `fd'
		external
			"C blocking"
		end

	c_read_char (fd: INTEGER; a_bytes_read: TYPED_POINTER [INTEGER]): CHARACTER
			-- External routine to read a character from socket `fd'
		external
			"C blocking"
		end

	c_read_int (fd: INTEGER; a_bytes_read: TYPED_POINTER [INTEGER]): INTEGER
			-- External routine to read an integer from socket `fd'
		external
			"C blocking"
		end

	c_read_float (fd: INTEGER; a_bytes_read: TYPED_POINTER [INTEGER]): REAL
			-- external routine to read a real from socket `fd'
		external
			"C blocking"
		end

	c_read_double (fd: INTEGER; a_bytes_read: TYPED_POINTER [INTEGER]): DOUBLE
			-- External routine to read a double from socket `fd'
		external
			"C blocking"
		end

	c_read_stream (fd: INTEGER; l: INTEGER; buf: POINTER): INTEGER
			-- External routine to read a `l' number of characters
			-- into buffer `buf' from socket `fd'
		external
			"C blocking"
		end

	c_write (fd: INTEGER; buf: POINTER; l: INTEGER): INTEGER
			-- External routine to write `l' length of data
			-- on socket `fd'.
		external
			"C blocking"
		end

	c_receive (fd: INTEGER; buf: POINTER; len: INTEGER; flags: INTEGER): INTEGER
			-- External routine to receive at most `len' number of
			-- bytes into buffer `buf' from socket `fd' with `flags'
			-- options
		external
			"C blocking"
		end

	c_send (fd: INTEGER; buf: POINTER; len: INTEGER; flags: INTEGER): INTEGER
			-- External routine to send at most `len' number of
			-- bytes from buffer `buf' on socket `fd' with `flags'
			-- options
		external
			"C blocking"
		end

	c_set_sock_opt_int (fd, level, opt, val: INTEGER)
			-- C routine to set socket options of integer type
		external
			"C"
		end

	c_get_sock_opt_int (fd, level, opt: INTEGER): INTEGER
			-- C routine to get socket options of integer type
		external
			"C"
		end

	c_fcntl (fd, cmd, arg: INTEGER): INTEGER
			-- C wrapper to fcntl() routine
		external
			"C"
		end

	c_set_non_blocking (fd: INTEGER)
			-- C routine to set the socket as non-blocking
		external
			"C"
		end

	c_set_blocking (fd: INTEGER)
			-- C routine to set the socket as blocking
		external
			"C"
		end

	c_syncpoll (fd: INTEGER): INTEGER
			-- C routine to synchonously poll socket
			-- (using `msg_peek' flag)
		external
			"C blocking"
		end

	c_select_poll (fd: INTEGER): INTEGER
			-- C routine to synchronously poll socket
			-- (using `select')
		external
			"C blocking"
		end

	eif_net_retrieved (file_handle: INTEGER): ANY
			-- Object structured retrieved from file of pointer
			-- `file_handle'
		external
			"C"
		end

	eif_net_basic_store (file_handle: INTEGER; object: POINTER)
			-- Store object structure reachable form current object
			-- in file pointer `file_ptr'.
		external
			"C"
		end

	eif_net_general_store (file_handle: INTEGER; object: POINTER)
			-- Store object structure reachable form current object
			-- in file pointer `file_ptr'.
		external
			"C"
		end

	eif_net_independent_store (file_handle: INTEGER; object: POINTER)
			-- Store object structure reachable form current object
			-- in file pointer `file_ptr'.
		external
			"C"
		end

note
	copyright:	"Copyright (c) 1984-2019, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
