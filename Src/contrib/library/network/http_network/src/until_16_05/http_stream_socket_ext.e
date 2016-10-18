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
			set_address (create {like address_type}.make_from_address_and_port (a_address, a_port))
			bind
		end

feature -- Basic operation

	bind
		deferred
		end

feature -- Access

	set_address (addr: detachable like address_type)
		deferred
		end

	address_type: NETWORK_SOCKET_ADDRESS
		deferred
		end

	descriptor: INTEGER
			-- Socket descriptor of current socket
		deferred
		end

feature -- Socket Recv and Send timeout.

	set_recv_timeout (a_timeout_seconds: INTEGER)
			-- Set the receive timeout in seconds on Current socket.
			-- if `0' the related operations will never timeout.
		require
			positive_timeout: a_timeout_seconds >= 0
		do
			c_set_sock_recv_timeout (descriptor, level_sol_socket, a_timeout_seconds)
		end

	set_send_timeout (a_timeout_seconds: INTEGER)
			-- Set the send timeout in milliseconds on Current socket.
			-- if `0' the related operations will never timeout.
		require
			positive_timeout: a_timeout_seconds >= 0
		do
			c_set_sock_send_timeout (descriptor, level_sol_socket, a_timeout_seconds)
		end

feature {NONE} -- Externals

	level_sol_socket: INTEGER
			-- SOL_SOCKET level of options
		deferred
		end

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

end
