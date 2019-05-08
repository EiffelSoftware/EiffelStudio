note

	description: "A network socket."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class NETWORK_SOCKET inherit

	SOCKET
		undefine
			send, put_character, putchar, put_string, putstring,
			put_integer, putint, put_integer_32,
			put_integer_8, put_integer_16, put_integer_64,
			put_natural_8, put_natural_16, put_natural, put_natural_32, put_natural_64,
			put_boolean, putbool,
			put_real, putreal, put_double, putdouble, put_managed_pointer,
			set_blocking, set_non_blocking
		redefine
			exists, address_type, is_valid_peer_address, is_valid_family
		end

	SOCKET_TIMEOUT_UTILITIES

feature

	exists: BOOLEAN
			-- Does socket exist?
		do
			Result := descriptor_available and then (fd > 0 or else fd1 > 0)
		ensure then
			definition: Result implies descriptor_available
		end

	close_socket
			-- Close the underlying C socket.
		do
			if not is_closed and then is_created then
				c_close (fd, fd1)
			end
			set_closed
		end

	descriptor: INTEGER
			-- Socket descriptor of current socket
		do
			Result := fd
		end

	connect
		local
			retried: BOOLEAN
		do
			if not retried then
				do_connect (peer_address)
				is_connected := True
				is_open_write := True;
				is_open_read := True
			end
		rescue
			if not assertion_violation then
				is_connected := False
				is_open_read := False
				is_open_write := False
				retried := True
				retry
			end
		end

	bind
		local
			retried: BOOLEAN
		do
			if not retried then
				do_bind (address)
				is_open_read := True
				is_bound := True
			end
		rescue
			if not assertion_violation then
				is_bound := False
				is_open_read := False
				retried := True
				retry
			end
		end

feature -- Status report

	address_type: NETWORK_SOCKET_ADDRESS
			-- <Precursor>
		do
			check False then end
		end

	is_closed: BOOLEAN

	is_created: BOOLEAN

	is_connected: BOOLEAN

	is_bound: BOOLEAN

	port: INTEGER
			-- Port socket is bound to.
		do
			if not is_bound then
				Result := -1
			else
				Result := internal_port
			end
		end

	reuse_address: BOOLEAN
			-- Is reuse_address option set?
		require
			socket_exists: exists
		local
			reuse: INTEGER
		do
			reuse := c_get_sock_opt_int (descriptor, level_sol_socket, so_reuse_addr);
			Result := reuse /= 0
		end

	is_valid_peer_address (addr: attached separate like address): BOOLEAN
		do
			Result := addr.family = af_inet or else addr.family = af_inet6
		end

	is_valid_family (addr: attached like address): BOOLEAN
		do
			Result := addr.family = af_inet or else addr.family = af_inet6
		end

	ready_for_reading: BOOLEAN
			-- Is data available for reading from the socket within
			-- `timeout' seconds?
		require
			socket_exists: exists
		local
			retval: INTEGER
		do
			retval := c_select_poll_with_timeout (descriptor, True, timeout_ns)
			Result := retval > 0
		end

	ready_for_writing: BOOLEAN
			-- Can data be written to the socket within `timeout' seconds?
		require
			socket_exists: exists
		local
			retval: INTEGER
		do
			retval := c_select_poll_with_timeout (descriptor, False, timeout_ns)
			Result := retval > 0
		end

	has_exception_state: BOOLEAN
			-- Is socket in exception state within `timeout' seconds?
		require
			socket_exists: exists
		local
			retval: INTEGER
		do
			retval := c_check_exception_with_timeout (descriptor, timeout_ns)
			Result := retval > 0
		end

	is_default_timeout: BOOLEAN
			-- Is `timeout_ns` the default timeout?	
		do
			Result := timeout_ns = seconds_to_nanoseconds (default_timeout)
		end

feature -- Access: Timeout

	timeout: INTEGER
			-- Duration of timeout in seconds
		obsolete
			"Use `timeout_ns` using nanoseconds [2018-01-15]"
		local
			ns: like timeout_ns
		do
			ns := timeout_ns
			Result := nanoseconds_to_seconds (ns)
			if Result = 0 and ns > 0 then
					-- As 0 may have different meaning, use the closest non zero possible value.
				Result := 1
			end
		ensure
			timeout_positive: timeout_ns /= 0 implies Result > 0
		end

	timeout_ns: NATURAL_64
			-- Duration of timeout in nanoseconds.

	recv_timeout: INTEGER
			-- Receive timeout in seconds on Current socket.
		obsolete
			"Use `recv_timeout_ns` using nanoseconds [2018-01-15]"
		do
			Result := nanoseconds_to_seconds (recv_timeout_ns)
		ensure
			result_not_negative: Result >= 0
		end

	recv_timeout_ns: NATURAL_64
			-- Receive timeout in nanoseconds on Current socket.
		do
			Result := c_get_sock_opt_timeout (descriptor, level_sol_socket, so_rcv_timeo)
		end

	send_timeout: INTEGER
			-- Send timeout in seconds on Current socket.
		obsolete
			"Use `send_timeout_ns` using nanoseconds [2018-01-15]"
		do
			Result := nanoseconds_to_seconds (send_timeout_ns)
		ensure
			result_not_negative: Result >= 0
		end

	send_timeout_ns: NATURAL_64
			-- Send timeout in nanoseconds on Current socket.
		do
			Result := c_get_sock_opt_timeout (descriptor, level_sol_socket, so_snd_timeo)
		end

feature -- Status setting

	set_reuse_address
			-- Turn `reuse_address' option on.
		require
			socket_exists: exists
		do
			c_set_sock_opt_int (descriptor, level_sol_socket, so_reuse_addr, 1)
		end

	do_not_reuse_address
			-- Turn `reuse_address' option off.
		require
			socket_exists: exists
		do
			c_set_sock_opt_int (descriptor, level_sol_socket, so_reuse_addr, 0)
		end

	set_default_timeout
			-- Set timeout to default.
		do
			timeout_ns := seconds_to_nanoseconds (default_timeout)
		ensure
			timeout_set_to_default: is_default_timeout
		end

	set_timeout (n: INTEGER)
			-- Set timeout to `n' seconds.
		obsolete
			"Use `set_timeout_ns (ns)` [2018-01-15]"
		require
			non_negative: n >= 0
		do
			set_timeout_ns (seconds_to_nanoseconds (n))
		ensure
			timeout_set: timeout = n
		end

	set_timeout_ns (a_timeout_nanoseconds: NATURAL_64)
			-- Set timeout with to `a_timeout_nanoseconds` nanoseconds.
			-- Warning: the timeout granularity of the platform may not be nanoseconds, but micro or milliseconds.
		require
			is_valid_timeout_ns: is_valid_timeout_ns (a_timeout_nanoseconds)
		do
			timeout_ns := a_timeout_nanoseconds
		end

	set_recv_timeout (a_timeout_seconds: INTEGER)
			-- Set the receive timeout in seconds on Current socket.
			-- If `0' the related operations will never timeout.
		obsolete
			"Use `set_recv_timeout_ns` using nanoseconds [2018-01-15]"
		require
			non_negative_timeout: a_timeout_seconds >= 0
		do
			set_recv_timeout_ns (seconds_to_nanoseconds (a_timeout_seconds))
		end

	set_recv_timeout_ns (a_timeout_nanoseconds: NATURAL_64)
			-- Set the receive timeout with `a_timeout_nanoseconds` nanoseconds on Current socket.
			-- If `0' the related operations will never timeout.
			-- Warning: the timeout granularity of the platform may not be nanoseconds, but micro or milliseconds.
		require
			is_valid_timeout_ns: is_valid_timeout_ns (a_timeout_nanoseconds)
		do
			c_set_sock_opt_timeout (descriptor, level_sol_socket, so_rcv_timeo, a_timeout_nanoseconds)
		end

	set_send_timeout (a_timeout_seconds: INTEGER)
			-- Set the send timeout in seconds on Current socket.
			-- If `0' the related operations will never timeout.
		obsolete
			"Use `set_send_timeout_ns` using nanoseconds [2018-01-15]"
		require
			non_negative_timeout: a_timeout_seconds >= 0
		do
			set_send_timeout_ns (seconds_to_nanoseconds (a_timeout_seconds))
		end

	set_send_timeout_ns (a_timeout_nanoseconds: NATURAL_64)
			-- Set the send timeout with `a_timeout_nanoseconds` nanoseconds on Current socket.
			-- If `0' the related operations will never timeout.
			-- Warning: the timeout granularity of the platform may not be nanoseconds, but micro or milliseconds.
		require
			is_valid_timeout_ns: is_valid_timeout_ns (a_timeout_nanoseconds)
		do
			c_set_sock_opt_timeout (descriptor, level_sol_socket, so_snd_timeo, a_timeout_nanoseconds)
		end

	set_non_blocking
			-- <Precursor>
		do
			c_set_non_blocking (fd)
			if fd1 > 0 then
					-- We need to set the blocking status on other socket if it was opened.
				c_set_non_blocking (fd1)
			end
			is_blocking := False
		end

	set_blocking
			-- <Precursor>
		do
			c_set_blocking (fd)
			if fd1 > 0 then
					-- We need to set the blocking status on other socket if it was opened.
				c_set_blocking (fd1)
			end
			is_blocking := True
		end

feature {NONE} -- Implementation

	make_socket
		do
			do_create
			if fd > - 1 then
				is_closed := False
				descriptor_available := True
				set_blocking
			end
		end

	set_closed
			-- Update all internal state to indicate that the C socket is closed.
		do
			is_closed := True
			descriptor_available := False
			is_open_read := False
			is_open_write := False
		end

	shutdown
		do
			c_shutdown (fd, fd1)
		end

	fd: INTEGER

	fd1: INTEGER

	last_fd: INTEGER

	internal_port: INTEGER
			-- Internal storage for `port' when `is_bound'.

	do_create
		deferred
		end

	do_connect (a_peer_address: like peer_address)
		require
			a_peer_address_attached: a_peer_address /= Void
		deferred
		end

	do_bind (a_address: like address)
		require
			a_address_attached: a_address /= Void
		deferred
		end

feature {NONE} -- Constants

	default_timeout: INTEGER
			-- Default timeout duration in seconds

feature {NONE} -- Externals

	c_set_sock_opt_timeout (a_fd, level: INTEGER; a_timeo_opt: INTEGER; a_timeout_nanoseconds: NATURAL_64)
			-- C routine to set socket option `$a_timeo_opt' with `a_timeout_nanoseconds`.
		require
			is_valid_timeout_ns: is_valid_timeout_ns (a_timeout_nanoseconds)
		external
			"C"
		end

	c_get_sock_opt_timeout (a_fd, level: INTEGER; a_timeo_opt: INTEGER): NATURAL_64
			-- C routine to get socket option `$a_timeo_opt' of timeout value in nanoseconds.
		external
			"C"
		end

	c_close (an_fd: INTEGER; an_fd1: INTEGER)
		external
			"C"
		alias
			"en_socket_close"
		end

	c_select_poll_with_timeout (an_fd: INTEGER; is_read_mode: BOOLEAN;
				a_timeout_nanoseconds: NATURAL_64): INTEGER
		require
			is_valid_timeout_ns: is_valid_timeout_ns (a_timeout_nanoseconds)
		external
			"C blocking"
		end

	c_check_exception_with_timeout (an_fd: INTEGER; a_timeout_nanoseconds: NATURAL_64): INTEGER
		require
			is_valid_timeout_ns: is_valid_timeout_ns (a_timeout_nanoseconds)
		external
			"C blocking"
		end

	c_shutdown (an_fd: INTEGER; an_fd1: INTEGER)
		external
			"C blocking"
		alias
			"en_socket_shutdown"
		end

invariant

	correct_exist: not is_created implies is_closed and not exists

note
	copyright:	"Copyright (c) 1984-2018, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
