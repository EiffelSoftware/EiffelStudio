note
	description: "SSL tcp stream socket."
	date: "$Date$"
	revision: "$Revision$"

class
	HTTPD_STREAM_SSL_SOCKET

inherit
	HTTPD_STREAM_SOCKET
		undefine
			make_empty, make_from_descriptor_and_address,
			error_number,
			readstream, read_stream,
			read_into_pointer,
			read_to_managed_pointer,
			put_pointer_content,
			write, send,
			close_socket,
			connect, shutdown,
			do_accept
		redefine
			put_managed_pointer,
			read_stream_noexception,
			read_into_pointer_noexception,
			put_pointer_content_noexception
		end

	SSL_NETWORK_STREAM_SOCKET
		redefine
			put_managed_pointer -- Redefine to allow support of compiler before 16.11.
		end

	HTTPD_STREAM_SSL_SOCKET_EXT

create
	make, make_empty,
	make_client_by_port, make_client_by_address_and_port,
	make_server_by_port, make_server_by_address_and_port, make_loopback_server_by_port

create {SSL_NETWORK_STREAM_SOCKET}
	make_from_descriptor_and_address

feature -- Input

	read_stream_noexception (nb_char: INTEGER)
			-- Read a string of at most `nb_char' characters.
			-- Make result available in `last_string'.
		local
			ext: C_STRING
			return_val: INTEGER
		do
			if
				attached context as l_context and then
				attached l_context.last_ssl as l_ssl
			then
				create ext.make_empty (nb_char + 1)
				return_val := l_ssl.read (ext.item , nb_char)
				bytes_read := return_val
				if return_val >= 0 then
					ext.set_count (return_val)
					last_string := ext.substring (1, return_val)
				else
					socket_error := "Peer error [0x" + return_val.to_hex_string + "]"
					last_string.wipe_out
				end
			else
				check has_context: False end
			end
		end

feature {NONE} -- Input

	read_into_pointer_noexception (p: POINTER; start_pos, nb_bytes: INTEGER_32)
			-- Read at most `nb_bytes' bound bytes and make result
			-- available in `p' at position `start_pos'.
			-- No exception raised!
		local
			l_read: INTEGER
			l_last_read: INTEGER
		do
			if
				attached context as l_context and then
				attached l_context.last_ssl as l_ssl
			then
				from
					l_last_read := 1
				until
					l_read = nb_bytes or l_last_read <= 0
				loop
					l_last_read := l_ssl.read (p + start_pos + l_read, nb_bytes - l_read)
					if l_last_read >= 0 then
						l_read := l_read + l_last_read
					end
				end
				bytes_read := l_read
			else
				check has_context: False end
			end
		end

feature -- Output

	put_managed_pointer (p: MANAGED_POINTER; start_pos, nb_bytes: INTEGER)
			-- Put data of length `nb_bytes' pointed by `start_pos' index in `p' at
			-- current position.
		do
			Precursor {HTTPD_STREAM_SOCKET} (p, start_pos, nb_bytes)
		end

	put_pointer_content_noexception (a_pointer: POINTER; a_offset, a_byte_count: INTEGER)
			-- Write `a_byte_count' bytes to the socket.
			-- The data is taken from the memory area pointed to by `a_pointer', at offset `a_offset'.
			-- Update `bytes_sent'.
			-- No exception raised!
		local
			l_bytes_sent: INTEGER
		do
			if
				attached context as l_context and then
				attached l_context.last_ssl as l_ssl
			then
				l_bytes_sent := ssl_write (l_ssl, a_pointer + a_offset, a_byte_count)
				if l_bytes_sent < a_byte_count then
					socket_error := "No all bytes sent!"
				end
				bytes_sent := l_bytes_sent
			else
				check has_last_ssl: False end
			end
		end

feature -- Element change	

	set_certificate_filenames (a_crt_filename, a_key_filename: detachable READABLE_STRING_GENERAL)
		do
			if a_crt_filename /= Void then
				set_certificate_file_name (a_crt_filename)
			end
			if a_key_filename /= Void then
				set_key_file_name (a_key_filename)
			end
		end

note
	copyright: "2011-2013, Javier Velilla, Jocelyn Fiat and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"

end
