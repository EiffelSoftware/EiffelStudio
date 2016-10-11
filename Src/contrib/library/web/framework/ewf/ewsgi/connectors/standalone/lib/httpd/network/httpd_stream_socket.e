note
	description: "Summary description for {HTTPD_STREAM_SOCKET}."
	date: "$Date$"
	revision: "$Revision$"

class
	HTTPD_STREAM_SOCKET

inherit
	NETWORK_STREAM_SOCKET

	HTTPD_STREAM_SOCKET_EXT

create
	make, make_empty,
	make_client_by_port, make_client_by_address_and_port,
	make_server_by_port, make_server_by_address_and_port, make_loopback_server_by_port

create {NETWORK_STREAM_SOCKET}
	make_from_descriptor_and_address

feature -- Input	

	read_character_noexception
			-- Read a new character.
			-- Make result available in `last_character'.
			-- No exception raised!
		do
			read_to_managed_pointer_noexception (socket_buffer, 0, character_8_bytes)
			if bytes_read /= character_8_bytes then
				socket_error := "Peer closed connection"
			else
				last_character := socket_buffer.read_character (0)
				socket_error := Void
			end
		end

	read_stream_noexception (nb_char: INTEGER)
			-- Read a string of at most `nb_char' characters.
			-- Make result available in `last_string'.
		local
			ext: C_STRING
			return_val: INTEGER
		do
			create ext.make_empty (nb_char + 1)
			return_val := c_read_stream_noexception (descriptor, nb_char, ext.item)
			bytes_read := return_val
			if return_val >= 0 then
				ext.set_count (return_val)
				last_string := ext.substring (1, return_val)
			else
				socket_error := "Peer error [0x" + return_val.to_hex_string + "]"
				last_string.wipe_out
			end
		end

	read_to_managed_pointer_noexception (p: MANAGED_POINTER; start_pos, nb_bytes: INTEGER)
			-- Read at most `nb_bytes' bound bytes and make result
			-- available in `p' at position `start_pos'.
			-- No exception raised!
		do
			read_into_pointer_noexception (p.item, start_pos, nb_bytes)
		end

	read_line_noexception
			-- Read a line of characters (ended by a new_line).
			-- No exception raised!
		local
			l_last_string: like last_string
		do
			create l_last_string.make (512)
			read_character_noexception
			from
			until
				last_character = '%N' or else was_error
			loop
				l_last_string.extend (last_character)
				read_character_noexception
			end
			last_string := l_last_string
		end

	peek_stream_noexception (nb_char: INTEGER)
			-- Read a string of at most `nb_char' characters without removing the data from the queue.
			-- Make result available in last_string.
			-- No exception raised!			
		require
			readable: readable
			socket_exists: exists
		local
			ext: C_STRING
			retval: INTEGER
			l: like last_string
		do
			create ext.make_empty (nb_char + 1)
			retval := c_recv_noexception (descriptor, ext.item, nb_char, c_peekmsg)
			if retval = 0 then
				last_string.wipe_out
				socket_error := Void
			elseif retval > 0 then
				ext.set_count (retval)
				l := last_string
				l.wipe_out
				l.grow (retval)
				l.set_count (retval)
				ext.read_substring_into (l, 1, retval)
				socket_error := Void
			else
				last_string.wipe_out
				socket_error := "Socket error (MSG_PEEK)"
			end
		ensure
			last_string_not_void: last_string /= Void
		end

feature {NONE} -- Input

	read_into_pointer_noexception (p: POINTER; start_pos, nb_bytes: INTEGER_32)
			-- Read at most `nb_bytes' bound bytes and make result
			-- available in `p' at position `start_pos'.
			-- No exception raised!
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
				l_last_read := c_read_stream_noexception (descriptor, nb_bytes - l_read, p + start_pos + l_read)
				if l_last_read >= 0 then
					l_read := l_read + l_last_read
				end
			end
			bytes_read := l_read
		ensure
			bytes_read_updated: 0 <= bytes_read and bytes_read <= nb_bytes
		end

feature -- Output

	bytes_sent: INTEGER
			-- Last number of bytes sent by `put_managed_pointer_noexception' (i.e `put_pointer_content_noexception').

	put_managed_pointer_noexception (p: MANAGED_POINTER; start_pos, nb_bytes: INTEGER_32)
			-- Put data of length `nb_bytes' pointed by `start_pos' index in `p' at
			-- current position.
			-- Update `bytes_sent'.
			-- No exception raised!
		require
			p_not_void: p /= Void
			p_large_enough: p.count >= nb_bytes + start_pos
			nb_bytes_non_negative: nb_bytes >= 0
			extendible: extendible
		do
			put_pointer_content_noexception (p.item, start_pos, nb_bytes)
		end

	put_pointer_content_noexception (a_pointer: POINTER; a_offset, a_byte_count: INTEGER)
			-- Write `a_byte_count' bytes to the socket.
			-- The data is taken from the memory area pointed to by `a_pointer', at offset `a_offset'.
			-- Update `bytes_sent'.
			-- No exception raised!
		require
			pointer_not_void: a_pointer /= default_pointer
			byte_count_non_negative: a_byte_count >= 0
			extendible: extendible
		local
			l_sent: INTEGER_32
			l_last_sent: INTEGER_32
		do
			from
				l_last_sent := 1
			until
				l_sent = a_byte_count or l_last_sent <= 0
			loop
				l_last_sent := c_put_stream_noexception (descriptor, a_pointer + a_offset + l_sent, a_byte_count - l_sent)
				if l_last_sent >= 0 then
					l_sent := l_sent + l_last_sent
				elseif l_sent < a_byte_count then
					socket_error := "No all bytes sent!"
				end
			end
			bytes_sent := l_sent
		ensure
			bytes_sent_updated: not was_error implies (0 <= bytes_sent and bytes_sent <= a_byte_count)
		end

	put_character_noexception (c: CHARACTER)
			-- Write character `c' to socket.
		do
			socket_buffer.put_character (c, 0)
			put_managed_pointer_noexception (socket_buffer, 0, character_8_bytes)
		end

	put_readable_string_8_noexception (s: READABLE_STRING_8)
			-- Write readable string `s' to socket.
			-- No exception raised!			
		local
			ext: C_STRING
		do
			create ext.make (s)
			put_managed_pointer_noexception (ext.managed_data, 0, s.count)
		end

	put_readable_string_8 (s: READABLE_STRING_8)
			-- Write readable string `s' to socket.
		local
			ext: C_STRING
		do
			create ext.make (s)
			put_managed_pointer (ext.managed_data, 0, s.count)
		end

feature -- Status report

	has_incoming_data: BOOLEAN
			-- Check if Current has available data to be read.
			-- note: no data will not be removed from the queue.
		require
			socket_exists: exists
		do
			peek_stream_noexception (1)
			Result := last_string.count = 1
		end

note
	copyright: "2011-2015, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
