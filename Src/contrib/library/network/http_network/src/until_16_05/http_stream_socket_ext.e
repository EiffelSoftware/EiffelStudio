note
	description: "[
			Until 16.05, the EiffelNet socket interface DOES NOT have 
				- make_server_by_address_and_port
				- recv_timeout 
				- send_timeout.
				
			TO BE REMOVED IN THE FUTURE, WHEN 16.05 IS OLD.
		]"

deferred class
	HTTP_STREAM_SOCKET_EXT

inherit
	PLATFORM

feature -- Initialization

	make
		deferred
		end

	make_server_by_address_and_port (a_address: INET_ADDRESS; a_port: INTEGER)
			-- Create server socket on `a_address' and `a_port'.
		require
			valid_port: a_port >= 0
		do
			make
			socket.set_address (create {like socket.address_type}.make_from_address_and_port (a_address, a_port))
			socket.bind
		end

feature -- Extension

	socket: HTTP_STREAM_SOCKET
			-- Associated socket.
			-- Used to extend HTTP_STREAM_SOCKET with Current interface.
		deferred
		end

feature {NONE} -- Externals: socket option levels

	level_sol_socket: INTEGER_32
			-- SOL_SOCKET level of options
		deferred
		end

feature -- Socket Recv and Send timeout.

	set_recv_timeout (a_timeout_seconds: INTEGER)
			-- Set the receive timeout in seconds on Current socket.
			-- if `0' the related operations will never timeout.
		require
			positive_timeout: a_timeout_seconds >= 0
		do
			c_set_sock_recv_timeout (socket.descriptor, level_sol_socket, a_timeout_seconds)
		end

	set_send_timeout (a_timeout_seconds: INTEGER)
			-- Set the send timeout in milliseconds on Current socket.
			-- if `0' the related operations will never timeout.
		require
			positive_timeout: a_timeout_seconds >= 0
		do
			c_set_sock_send_timeout (socket.descriptor, level_sol_socket, a_timeout_seconds)
		end

feature -- Output

	put_file_content_with_timeout (a_file: FILE; a_offset: INTEGER; a_byte_count: INTEGER; a_timeout_ms: INTEGER)
			-- Send `a_count' bytes from the content of file `a_file' starting at offset `a_offset'.
			-- When relevant, use the `a_timeout_ms` to wait on completion (if a_timeout < 0, ignored)
		require
			a_file_closed_or_openread: a_file.exists and then (a_file.is_access_readable or a_file.is_closed)
			byte_count_positive: a_byte_count > 0
			extendible: socket.extendible
		local
			l_close_needed: BOOLEAN
			l_remain: INTEGER
			l_done: BOOLEAN
			s: STRING
			l_bytes_sent: INTEGER
		do
			if a_file.exists and then a_file.is_access_readable then
				if a_file.is_open_read then
					l_close_needed := False
				else
					l_close_needed := True
					a_file.open_read
				end
				if a_offset > 0 then
					a_file.move (a_offset)
				end
				from
					l_remain := a_byte_count
					l_done := False
				until
					a_file.exhausted or l_done
				loop
					a_file.read_stream (l_remain.min (4_096))
					s := a_file.last_string
					if s.is_empty then
							-- File error?
						l_done := True
					else
						socket.put_string_8_noexception (s)
						l_bytes_sent := l_bytes_sent + socket.bytes_sent
						l_remain := l_remain - s.count
						check l_remain >= 0 end
						l_done := l_remain = 0
					end
				end
				socket.set_bytes_sent (l_bytes_sent)
				if l_close_needed then
					a_file.close
				end
			end
		ensure
			bytes_sent_updated: not socket.was_error implies (0 <= socket.bytes_sent and socket.bytes_sent <= a_byte_count)
		end

	put_file_content (a_file: FILE; a_offset: INTEGER; a_byte_count: INTEGER)
			-- Send `a_count' bytes from the content of file `a_file' starting at offset `a_offset'.
		require
			a_file_closed_or_openread: a_file.exists and then (a_file.is_access_readable or a_file.is_closed)
			byte_count_positive: a_byte_count > 0
			extendible: socket.extendible
		do
			put_file_content_with_timeout (a_file, a_offset, a_byte_count, -1)
		ensure
			bytes_sent_updated: not socket.was_error implies (0 <= socket.bytes_sent and socket.bytes_sent <= a_byte_count)
		end

feature {NONE} -- Externals

	c_set_sock_recv_timeout (a_fd, a_level: INTEGER; a_timeout_seconds: INTEGER)
			-- C routine to set socket option `SO_RCVTIMEO' with `a_timeout_seconds' seconds.
		external
			"C inline use %"ew_network.h%""
		alias
			"[
#ifdef SO_RCVTIMEO 
	int flag = SO_RCVTIMEO;
#else
	int flag = 0x1006;
#endif

#ifdef EIF_WINDOWS
	int arg = (int) 1000 * $a_timeout_seconds; /* Timeout in milliseconds */
	setsockopt((int) $a_fd, (int) $a_level, flag, (char *) &arg, sizeof(arg));
#else
	struct timeval tv;
	tv.tv_sec = $a_timeout_seconds;  /* Timeout in seconds */
	tv.tv_usec = 0;
	setsockopt((int) $a_fd, (int) $a_level, flag, (struct timeval *)&tv, sizeof(struct timeval));
#endif
			]"
		end

	c_set_sock_send_timeout (a_fd, a_level: INTEGER; a_timeout_seconds: INTEGER)
			-- C routine to set socket option `SO_SNDTIMEO' with `a_timeout_seconds' seconds.
		external
			"C inline use %"ew_network.h%""
		alias
			"[
#ifdef SO_RCVTIMEO 
	int flag = SO_SNDTIMEO;
#else
	int flag = 0x1005;
#endif			
#ifdef EIF_WINDOWS
	int arg = (int) 1000 * $a_timeout_seconds; /* Timeout in milliseconds */
	setsockopt((int) $a_fd, (int) $a_level, flag, (char *) &arg, sizeof(arg));
#else
	struct timeval tv;
	tv.tv_sec = $a_timeout_seconds;  /* Timeout in seconds */
	tv.tv_usec = 0;
	setsockopt((int) $a_fd, (int) $a_level, flag, (struct timeval *)&tv, sizeof(struct timeval));
#endif
			]"
		end

feature {NONE} -- No-Exception network operation

	c_recv_noexception (a_fd: INTEGER; buf: POINTER; len: INTEGER; flags: INTEGER): INTEGER
			-- External routine to read a `len' number of characters
			-- into buffer `buf' from socket `a_fd' with options `flags'.
		external
			"C inline use %"ew_network.h%""
		alias
			"[
				recv((int) $a_fd, (char *) $buf, (int) $len, (int) $flags)
			]"
		end

	c_read_stream_noexception (a_fd: INTEGER; len: INTEGER; buf: POINTER): INTEGER
			-- External routine to read a `len' number of characters
			-- into buffer `buf' from socket `a_fd'.
		do
			Result := c_recv_noexception (a_fd, buf, len, 0)
		end

	c_put_stream_noexception (a_fd: INTEGER; buf: POINTER; len: INTEGER): INTEGER
			-- External routine to write stream pointed by `s' of
			-- length `length' to socket `fd'.
			-- Note: does not raise exception on error, but return error value as Result.
		external
			"C inline use %"ew_network.h%""
		alias
			"[
				send((int) $a_fd, (char *) $buf, (int) $len, (int) 0)
			]"
		end

note
	copyright: "2011-2016, Jocelyn Fiat, Javier Velilla, Olivier Ligot, Colin Adams, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
