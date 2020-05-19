note

	description: "Generic sockets"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class

	SOCKET

inherit

	SOCKET_RESOURCES
		redefine
			socket_ok, error
		end

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

feature -- Access

	retrieved: detachable ANY
			-- Retrieved object structure
			-- To access resulting object under correct type,
			-- use assignment attempt.
			-- Will raise an exception (code `Retrieve_exception')
			-- if content is not a stored Eiffel structure.
		local
			was_not_blocking: BOOLEAN
		do
			(create {MISMATCH_CORRECTOR}).mismatch_information.do_nothing
			if not is_blocking then
				was_not_blocking := True
				set_blocking
			end
			Result := eif_net_retrieved (descriptor)
			if was_not_blocking then
				set_non_blocking
			end
		end

feature -- Status report

	was_error: BOOLEAN
			-- Indicates that there was an error during the last operation
		do
			Result := socket_error /= Void
		end

	socket_ok: BOOLEAN
			-- No error
		do
			Result := Precursor and then not was_error
		end

	error: STRING
			-- Output a related error message.
		do
			if attached socket_error as l_error then
				Result := l_error
			else
				Result := Precursor
			end
		end

	support_storable: BOOLEAN
			-- Can medium be used to store an Eiffel structure?
		do
			Result := False
		end

	is_valid_peer_address (addr: attached separate like address): BOOLEAN
			-- Is `addr' a valid peer address?
		require
			address_exists: addr /= Void
		do
			Result := True
		end

	is_valid_family (addr: attached like address): BOOLEAN
			-- Is `addr' the same family as Current?
		require
			address_exists: addr /= Void
		do
			Result := (addr.family = family)
		end

feature -- Element change

	basic_store (object: ANY)
			-- Produce an external representation of the
			-- entire object structure reachable from `object'.
			-- Retrievable within current system only.
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
		do
			eif_net_general_store (descriptor, $object)
		end

	independent_store (object: ANY)
			-- Produce an external representation of the
			-- entire object structure reachable from `object'.
			-- Retrievable from other systems for the same or other
			-- platform (machine architecture).
		do
			eif_net_independent_store (descriptor, $object)
		end

feature -- Basic commands

	bind
			-- Bind socket to local address in `address'.
		require
			socket_exists: exists
			valid_local_address: address /= Void
		deferred
		end

	connect
			-- Connect socket to peer address.
		require
			socket_exists: exists
			valid_peer_address: peer_address /= Void
		deferred
		end

	make_socket
			-- Create socket descriptor.
		require
			valid_family: family >= 0
			valid_type: type >= 0
			valid_protocol: protocol >= 0
		deferred
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
		do
			if is_open_read or is_open_write then
				shutdown
			end
			if exists then
				close_socket
			end
		end

	close_socket
			-- Close socket for current context.
		require
			socket_exists: exists
		deferred
		ensure
			is_closed: is_closed
		end

	is_closed: BOOLEAN
			-- Is socket closed?
		deferred
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

	address: detachable like address_type
			-- Local address of socket

	peer_address: detachable like address
			-- Peer address of socket

	address_type: SOCKET_ADDRESS
			-- Type of `address' and `peer_address'
		require
			not_callable: False
		do
			check False then end
		ensure
			for_typing_only: False
		end

	set_peer_address (addr: separate like address)
			-- Set peer address to `addr'.
		require
			address_exists: addr /= Void
			address_valid: is_valid_peer_address (addr)
		do
				-- We may have to import a separate object, as we can't handle them.
			if attached {like address} addr as l_addr then

					-- Address is non-separate, no need to import it.
				peer_address := l_addr

			elseif attached addr then

					-- Address is a separate object. Create a local copy.
				create peer_address.make_from_separate (addr)

			else
					-- `addr' is Void. This should not happen according to the precondition.
				peer_address := Void
			end
		ensure
			separate_address_object_equal: not attached {like address} addr implies peer_address ~ addr
			nonseparate_address_reference_equal: attached {like address} addr implies peer_address = addr
		end

	set_address (addr: like address)
			-- Set local address to `addr'.
		require
			add_non_void: addr /= Void
			same_type: is_valid_family (addr)
		do
			address := addr
		ensure
			address_set: address = addr
		end

feature -- Miscellaneous

	name: STRING
			-- Socket name
		do
			create Result.make (0)
		end

feature -- Output

	put_new_line, new_line
			-- Write a "new_line" character to socket.
		do
			put_character ('%N')
		end

	put_string, putstring (s: READABLE_STRING_8)
			-- Write string `s' to socket.
		local
			ext: C_STRING
		do
			create ext.make (s)
			put_managed_pointer (ext.managed_data, 0, s.count)
		end

	put_managed_pointer (p: MANAGED_POINTER; start_pos, nb_bytes: INTEGER)
			-- Put data of length `nb_bytes' pointed by `start_pos' index in `p' at
			-- current position.
		do
			put_pointer_content (p.item, start_pos, nb_bytes)
		end

	put_separate_managed_pointer (a_pointer: separate MANAGED_POINTER; start_pos, a_byte_count: INTEGER)
			-- Put data of length `a_byte_count' pointed by `start_pos' index in `a_pointer' at
			-- current position.
		require
			pointer_not_void: a_pointer /= Void
			large_enough: a_pointer.count >= a_byte_count + start_pos
			byte_count_non_negative: a_byte_count >= 0
			extendible: extendible
		do
			put_pointer_content (a_pointer.item, start_pos, a_byte_count)
		end

	put_character, putchar (c: CHARACTER_8)
			-- Write character `c' to socket.
		do
			put_socket_buffer.put_character (c, 0)
			put_managed_pointer (put_socket_buffer, 0, character_8_bytes)
		end

	put_real, putreal, put_real_32 (r: REAL_32)
			-- Write real `r' to socket.
		do
			put_socket_buffer.put_real_32_be (r, 0)
			put_managed_pointer (put_socket_buffer, 0, real_32_bytes)
		end

	put_double, putdouble, put_real_64 (d: REAL_64)
			-- Write double `d' to socket.
		do
			put_socket_buffer.put_real_64_be (d, 0)
			put_managed_pointer (put_socket_buffer, 0, real_64_bytes)
		end

	put_integer, putint, put_integer_32 (i: INTEGER)
			-- Write integer `i' to socket.
		do
			put_socket_buffer.put_integer_32_be (i, 0)
			put_managed_pointer (put_socket_buffer, 0, integer_32_bytes)
		end

	put_integer_8 (i: INTEGER_8)
			-- Write integer `i' to socket.
		do
			put_socket_buffer.put_integer_8_be (i, 0)
			put_managed_pointer (put_socket_buffer, 0, integer_8_bytes)
		end

	put_integer_16 (i: INTEGER_16)
			-- Write integer `i' to socket.
		do
			put_socket_buffer.put_integer_16_be (i, 0)
			put_managed_pointer (put_socket_buffer, 0, integer_16_bytes)
		end

	put_integer_64 (i: INTEGER_64)
			-- Write integer `i' to socket.
		do
			put_socket_buffer.put_integer_64_be (i, 0)
			put_managed_pointer (put_socket_buffer, 0, integer_64_bytes)
		end

	put_natural_8 (i: NATURAL_8)
			-- Write natural `i' to socket.
		do
			put_socket_buffer.put_natural_8_be (i, 0)
			put_managed_pointer (put_socket_buffer, 0, natural_8_bytes)
		end

	put_natural_16 (i: NATURAL_16)
			-- Write natural `i' to socket.
		do
			put_socket_buffer.put_natural_16_be (i, 0)
			put_managed_pointer (put_socket_buffer, 0, natural_16_bytes)
		end

	put_natural, put_natural_32 (i: NATURAL_32)
			-- Write natural `i' to socket.
		do
			put_socket_buffer.put_natural_32_be (i, 0)
			put_managed_pointer (put_socket_buffer, 0, natural_32_bytes)
		end

	put_natural_64 (i: NATURAL_64)
			-- Write natural `i' to socket.
		do
			put_socket_buffer.put_natural_64_be (i, 0)
			put_managed_pointer (put_socket_buffer, 0, natural_64_bytes)
		end

	put_boolean, putbool (b: BOOLEAN)
			-- Write boolean `b' to socket.
		do
			if b then
				put_character ('T')
			else
				put_character ('F')
			end
		end

	write (a_packet: PACKET)
			-- Write packet `a_packet' to socket.
		require
			a_packet_not_void: a_packet /= Void
			socket_exists: exists
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
				return_val := c_write (descriptor, ext_data, count - amount_sent)
				if return_val > 0 then
					ext_data := ext_data + return_val
					amount_sent := amount_sent + return_val
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
				return_val := c_send (descriptor, ext_data, count - amount_sent, flags)
				if return_val > 0 then
					amount_sent := amount_sent + return_val
					ext_data := ext_data + return_val
				end
			end
		end

	exists: BOOLEAN
			-- Does socket exist?
		do
			Result := descriptor_available and then descriptor >= 0
		ensure then
			definition: Result implies descriptor_available
		end

	is_open_write: BOOLEAN
			-- Is socket opened for writing?

	is_open_read: BOOLEAN
			-- Is socket opened for reading?

	is_executable: BOOLEAN
			-- Is socket an executable?
		do
			Result := False
		end

	is_writable: BOOLEAN
			-- Is socket a writable medium?
		do
			Result := True
		end

	is_readable: BOOLEAN
			-- Is there currently any data available on socket?
		do
			Result := readable and then c_select_poll (descriptor) /= 0
		end

	readable: BOOLEAN
		do
			Result := exists and then is_open_read
		end

	extendible: BOOLEAN
			-- May new items be added?
		do
			Result := exists and then is_open_write
		end

feature -- Input

	read_real, readreal, read_real_32
			-- Read a new real.
			-- Make result available in `last_real'.
		do
			read_to_managed_pointer (read_socket_buffer, 0, real_32_bytes)
			if bytes_read /= real_32_bytes then
				socket_error := "Peer closed connection"
			else
				last_real := read_socket_buffer.read_real_32_be (0)
				socket_error := Void
			end
		end

	read_double, readdouble, read_real_64
			-- Read a new double.
			-- Make result available in `last_double'.
		do
			read_to_managed_pointer (read_socket_buffer, 0, real_64_bytes)
			if bytes_read /= real_64_bytes then
				socket_error := "Peer closed connection"
			else
				last_double := read_socket_buffer.read_real_64_be (0)
				socket_error := Void
			end
		end

	read_character, readchar
			-- Read a new character.
			-- Make result available in `last_character'.
		do
			read_to_managed_pointer (read_socket_buffer, 0, character_8_bytes)
			if bytes_read /= character_8_bytes then
				socket_error := "Peer closed connection"
			else
				last_character := read_socket_buffer.read_character (0)
				socket_error := Void
			end
		end

	read_boolean, readbool
			-- Read a new boolean.
			-- Maker result available in `last_boolean'.
		do
			read_character
			if not was_error then
				if last_character = 'T' then
					last_boolean := True
				else
					last_boolean := False
				end
			end
		end

	last_boolean: BOOLEAN
			-- Last boolean read by read_boolean

	read_integer, readint, read_integer_32
			-- Read a new 32-bit integer.
			-- Make result available in `last_integer'.
		do
			read_to_managed_pointer (read_socket_buffer, 0, integer_32_bytes)
			if bytes_read /= integer_32_bytes then
				socket_error := "Peer closed connection"
			else
				last_integer := read_socket_buffer.read_integer_32_be (0)
				socket_error := Void
			end
		end

	read_integer_8
			-- Read a new 8-bit integer.
			-- Make result available in `last_integer_8'.
		do
			read_to_managed_pointer (read_socket_buffer, 0, integer_8_bytes)
			if bytes_read /= integer_8_bytes then
				socket_error := "Peer closed connection"
			else
				last_integer_8 := read_socket_buffer.read_integer_8_be (0)
				socket_error := Void
			end
		end

	read_integer_16
			-- Read a new 16-bit integer.
			-- Make result available in `last_integer_16'.
		do
			read_to_managed_pointer (read_socket_buffer, 0, integer_16_bytes)
			if bytes_read /= integer_16_bytes then
				socket_error := "Peer closed connection"
			else
				last_integer_16 := read_socket_buffer.read_integer_16_be (0)
				socket_error := Void
			end
		end

	read_integer_64
			-- Read a new 64-bit integer.
			-- Make result available in `last_integer_64'.
		do
			read_to_managed_pointer (read_socket_buffer, 0, integer_64_bytes)
			if bytes_read /= integer_64_bytes then
				socket_error := "Peer closed connection"
			else
				last_integer_64 := read_socket_buffer.read_integer_64_be (0)
				socket_error := Void
			end
		end

	read_natural_8
			-- Read a new 8-bit natural.
			-- Make result available in `last_natural_8'.
		do
			read_to_managed_pointer (read_socket_buffer, 0, natural_8_bytes)
			if bytes_read /= natural_8_bytes then
				socket_error := "Peer closed connection"
			else
				last_natural_8 := read_socket_buffer.read_natural_8_be (0)
				socket_error := Void
			end
		end

	read_natural_16
			-- Read a new 16-bit natural.
			-- Make result available in `last_natural_16'.
		do
			read_to_managed_pointer (read_socket_buffer, 0, natural_16_bytes)
			if bytes_read /= natural_16_bytes then
				socket_error := "Peer closed connection"
			else
				last_natural_16 := read_socket_buffer.read_natural_16_be (0)
				socket_error := Void
			end
		end

	read_natural, read_natural_32
			-- Read a new 32-bit natural.
			-- Make result available in `last_natural'.
		do
			read_to_managed_pointer (read_socket_buffer, 0, natural_32_bytes)
			if bytes_read /= natural_32_bytes then
				socket_error := "Peer closed connection"
			else
				last_natural := read_socket_buffer.read_natural_32_be (0)
				socket_error := Void
			end
		end

	read_natural_64
			-- Read a new 64-bit natural.
			-- Make result available in `last_natural_64'.
		do
			read_to_managed_pointer (read_socket_buffer, 0, natural_64_bytes)
			if bytes_read /= natural_64_bytes then
				socket_error := "Peer closed connection"
			else
				last_natural_64 := read_socket_buffer.read_natural_64_be (0)
				socket_error := Void
			end
		end

	read_stream, readstream (nb_char: INTEGER)
			-- Read a string of at most `nb_char' characters.
			-- Make result available in `last_string'.
		local
			ext: C_STRING
			return_val: INTEGER
			s: like last_string
		do
			create ext.make_empty (nb_char + 1)
			return_val := c_read_stream (descriptor, nb_char, ext.item)
			bytes_read := return_val
			if return_val > 0 then
				s := last_string
				s.grow (return_val)
				s.set_count (return_val)
				ext.copy_to_string (s, 1, 1, return_val)
			else
				last_string.wipe_out
			end
		end

	read_to_managed_pointer (p: MANAGED_POINTER; start_pos, nb_bytes: INTEGER)
			-- Read at most `nb_bytes' bound bytes and make result
			-- available in `p' at position `start_pos'.
		do
			read_into_pointer (p.item, start_pos, nb_bytes)
		end

	read_to_separate_managed_pointer (a_pointer: separate MANAGED_POINTER; start_pos, a_byte_count: INTEGER)
			-- Read at most `a_byte_count' bound bytes and make result
			-- available in `a_pointer' at position `start_pos'.
		require
			pointer_not_void: a_pointer /= Void
			large_enough: a_pointer.count >= a_byte_count + start_pos
			byte_count_non_negative: a_byte_count >= 0
			is_readable: readable
		do
			read_into_pointer (a_pointer.item, start_pos, a_byte_count)
		ensure
			bytes_read_updated: 0 <= bytes_read and bytes_read <= a_byte_count
		end

	read_line, readline
			-- Read a line of characters (ended by a new_line).
		local
			l_last_string: like last_string
		do
			create l_last_string.make (512)
			read_character
			from
			until
				last_character = '%N' or else was_error
			loop
				l_last_string.extend (last_character)
				read_character
			end
			last_string := l_last_string
		end

	read_line_until (n: INTEGER)
			-- Read a line of at most `n' characters (ended by a new_line).
			-- If new line not read after `n' characters, set an error.
		require
			is_readable: readable
		local
			i: INTEGER
			l_last_string: like last_string
		do
			from
				create l_last_string.make (512)
				socket_error := Void
			until
				i = n
			loop
				read_character
				if was_error or else last_character = '%N' then
					i := n - 1 -- Jump out of loop
				else
					l_last_string.extend (last_character)
				end
				i := i + 1
			end
			if not was_error and last_character /= '%N' then
				socket_error := {STRING} "End of line not reached after " + n.out + " read characters"
			end
			last_string := l_last_string
		ensure
			last_string_not_void: last_string /= Void
		end

	read (size: INTEGER): detachable PACKET
			-- Read a packet of data of maximum size `size'.
		require
			socket_exists: exists
			opened_for_read: is_open_read
		local
			l_data: detachable MANAGED_POINTER
			recv_packet: MANAGED_POINTER
			amount_read: INTEGER
			return_val: INTEGER
			ext_data: POINTER
		do
			ext_data := ext_data.memory_alloc (size)
			from
				amount_read := 0
				return_val := -1
			until
				amount_read = size or return_val = 0
			loop
				return_val := c_read_stream (descriptor, size - amount_read, ext_data)
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
			ext_data.memory_free
		end

	receive (size, flags: INTEGER): detachable PACKET
			-- Receive a packet of maximum size `size'.
		require
			socket_exists: exists
			opened_for_read: is_open_read
		local
			l_data: detachable MANAGED_POINTER
			recv_packet: MANAGED_POINTER
			amount_read: INTEGER
			return_val: INTEGER
			ext_data: POINTER
		do
			ext_data := ext_data.memory_alloc (size)
			from
				amount_read := 0
			until
				amount_read = size
			loop
				return_val := c_receive (descriptor, ext_data, size - amount_read, flags)
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
			ext_data.memory_free
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
			is_set := c_get_sock_opt_int (descriptor, level_sol_socket, sodebug)
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
			is_set := c_get_sock_opt_int (descriptor, level_sol_socket, so_dont_route)
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
			is_soc_s := c_get_sock_opt_int (descriptor, level_sol_socket, sotype)
			Result := is_soc_s = sock_stream
		end

	set_non_blocking
			-- Set socket to non-blocking mode.
		require
			socket_exists: exists
		do
			c_set_non_blocking (descriptor)
			is_blocking := False
		ensure
			not is_blocking
		end

	set_blocking
			-- Set socket to blocking mode.
		require
			socket_exists: exists
		do
			c_set_blocking (descriptor)
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
			socket_exists: exists
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
			is_grp := c_fcntl (descriptor, c_fgetown, 0)
			Result := is_grp < -1
		end

	is_process_id: BOOLEAN
			-- Is the owner id the socket process id?
		require
			socket_exists: exists
		local
			is_proc: INTEGER
		do
			is_proc := c_fcntl (descriptor, c_fgetown, 0)
			Result := is_proc > 0
		end

	group_id: INTEGER
			-- Group id of socket
		require
			socket_exists: exists
			group_set: is_group_id
		do
			Result := (c_fcntl (descriptor, c_fgetown, 0) * -1)
		end

	process_id: INTEGER
			-- Process id of socket
		require
			socket_exists: exists
			process_set: is_process_id
		do
			Result := c_fcntl (descriptor, c_fgetown, 0)
		end

feature {NONE} -- Implementation

	socket_error: detachable STRING
			-- Error description in case of an error.

	read_into_pointer (p: POINTER; start_pos, nb_bytes: INTEGER_32)
			-- Read at most `nb_bytes' bound bytes and make result
			-- available in `p' at position `start_pos'.
		require
			p_not_void: p /= default_pointer
			nb_bytes_non_negative: nb_bytes >= 0
			is_readable: readable
		local
			l_read: INTEGER_32
			l_last_read: INTEGER_32
		do
			from
				l_last_read := 1
			until
				l_read = nb_bytes or l_last_read <= 0
			loop
				l_last_read := c_read_stream (descriptor, nb_bytes - l_read, p + start_pos + l_read)
				if l_last_read >= 0 then
					l_read := l_read + l_last_read
				end
			end
			bytes_read := l_read
		ensure
			bytes_read_updated: 0 <= bytes_read and bytes_read <= nb_bytes
		end

	put_pointer_content (a_pointer: POINTER; a_offset, a_byte_count: INTEGER)
			-- Write `a_byte_count' bytes to the socket.
			-- The data is taken from the memory area pointed to by `a_pointer', at offset `a_offset'.
		require
			pointer_not_void: a_pointer /= default_pointer
			byte_count_non_negative: a_byte_count >= 0
			extendible: extendible
		do
			c_put_stream (descriptor, a_pointer + a_offset, a_byte_count)
		end

	shutdown
		deferred
		end

feature {NONE} -- Externals

	put_socket_buffer: MANAGED_POINTER
			-- Buffer used to read/write basic types.
		local
			l_buffer: like put_internal_socket_buffer
		do
			l_buffer := put_internal_socket_buffer
			if l_buffer = Void then
				create l_buffer.make (16)
				put_internal_socket_buffer := l_buffer
			end
			Result := l_buffer
		end

	put_internal_socket_buffer: detachable MANAGED_POINTER
			-- Internal integer buffer

	read_socket_buffer: MANAGED_POINTER
			-- Buffer used to read/write basic types.
		local
			l_buffer: like read_internal_socket_buffer
		do
			l_buffer := read_internal_socket_buffer
			if l_buffer = Void then
				create l_buffer.make (16)
				read_internal_socket_buffer := l_buffer
			end
			Result := l_buffer
		end

	read_internal_socket_buffer: detachable MANAGED_POINTER
			-- Internal integer buffer

	c_put_stream_noexception (fd: INTEGER; s: POINTER; length: INTEGER): INTEGER
			-- External routine to write stream pointed by `s' of
			-- length `length' to socket `fd'.
			-- Note: does not raise exception on error, but return error value as Result.
		external
			"C blocking"
		end

	c_put_stream (fd: INTEGER; s: POINTER; length: INTEGER)
			-- External routine to write stream pointed by `s' of
			-- length `length' to socket `fd'
		external
			"C blocking"
		end

	c_read_stream_noexception (a_fd: INTEGER; len: INTEGER; buf: POINTER): INTEGER
			-- External routine to read a `len' number of characters
			-- into buffer `buf' from socket `a_fd'.
			-- Note: does not raise exception on error, but return error value as Result.
		external
			"C blocking"
		end

	c_read_stream (fd: INTEGER; len: INTEGER; buf: POINTER): INTEGER
			-- External routine to read a `len' number of characters
			-- into buffer `buf' from socket `fd'
		external
			"C blocking"
		end

	c_write_noexception (fd: INTEGER; buf: POINTER; len: INTEGER): INTEGER
			-- External routine to write `len' length of data on socket `fd'.
			-- Note: does not raise exception on error, but return error value as Result.
		external
			"C blocking"
		end

	c_write (fd: INTEGER; buf: POINTER; len: INTEGER): INTEGER
			-- External routine to write `len' length of data
			-- on socket `fd'.
		external
			"C blocking"
		end

	c_recv_noexception (a_fd: INTEGER; buf: POINTER; len: INTEGER; flags: INTEGER): INTEGER
			-- External routine to read a `len' number of characters
			-- into buffer `buf' from socket `a_fd' with `flags' options that could be MSG_OOB, MSG_PEEK, MSD_DONTROUTE,...
			-- Note: does not raise exception on error, but return error value as Result.
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

	c_send_noexception (fd: INTEGER; buf: POINTER; len: INTEGER; flags: INTEGER): INTEGER
			-- External routine to send at most `len' number of
			-- bytes from buffer `buf' on socket `fd' with `flags' options.
			-- Note: does not raise exception on error, but return error value as Result.
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

	eif_net_retrieved (file_handle: INTEGER): detachable ANY
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
	copyright:	"Copyright (c) 1984-2020, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
