note
	description: "[
			Until 16.05, the EiffelNet socket interface DOES NOT have recv_timeout and send_timeout.
		]"

deferred class
	TCP_STREAM_SOCKET_EXT

feature -- Access

	descriptor: INTEGER
			-- Socket descriptor of current socket
		deferred
		end

feature -- Socket Recv and Send timeout.

--	recv_timeout: INTEGER
--			-- Receive timeout in seconds on Current socket.
--		do
--			Result := c_get_sock_recv_timeout (descriptor, level_sol_socket)
--		ensure
--			result_not_negative: Result >= 0
--		end
--
--	send_timeout: INTEGER
--			-- Send timeout in seconds on Current socket.
--		do
--			Result := c_get_sock_send_timeout (descriptor, level_sol_socket)
--		ensure
--			result_not_negative: Result >= 0
--		end

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
			"C inline"
		alias
			"[
#ifdef EIF_WINDOWS
	int arg = (int) 1000 * $a_timeout_seconds; /* Timeout in milliseconds */
	setsockopt((SOCKET) $a_fd, (int) $a_level, (int) SO_RCVTIMEO, (char *) &arg, sizeof(arg));
#else
	struct timeval tv;
	tv.tv_sec = $a_timeout_seconds;  /* Timeout in seconds */

	setsockopt((int) $a_fd, (int) $a_level, (int) SO_RCVTIMEO, (struct timeval *)&tv, sizeof(struct timeval));
#endif
			]"
		end

	c_set_sock_send_timeout (a_fd, a_level: INTEGER; a_timeout_seconds: INTEGER)
			-- C routine to set socket option `SO_SNDTIMEO' with `a_timeout_seconds' seconds.
		external
			"C inline"
		alias
			"[
#ifdef EIF_WINDOWS
	int arg = (int) 1000 * $a_timeout_seconds; /* Timeout in milliseconds */
	setsockopt((SOCKET) $a_fd, (int) $a_level, (int) SO_SNDTIMEO, (char *) &arg, sizeof(arg));
#else
	struct timeval tv;
	tv.tv_sec = $a_timeout_seconds;  /* Timeout in seconds */

	setsockopt((int) $a_fd, (int) $a_level, (int) SO_SNDTIMEO, (struct timeval *)&tv, sizeof(struct timeval));
#endif
			]"
		end

end
