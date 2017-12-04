note

	description:
		"A network socket."
	legal: "See notice at end of class.";

	status: "See notice at end of class.";
	date: "$Date$";
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
			exists, make_socket, address_type, is_valid_peer_address, connect, is_valid_family
		end

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

	timeout: INTEGER
			-- Duration of timeout in seconds
		obsolete
			"Use `timeout_ns` using nanoseconds [2018-01-15]"
		local
			ns: like timeout_ns
		do
			ns := timeout_ns
			Result := nanoseconds_to_seconds (timeout_ns)
			if Result = 0 and ns > 0 then
					-- As 0 may have different meaning, use the closest non zero possible value.
				Result := 1
			end
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

	set_timeout (n: INTEGER)
			-- Set timeout to `n' seconds.
		obsolete
			"Use `set_timeout_ns (ns)` [2018-01-15]"
		require
			non_negative: n >= 0
		do
			set_timeout_ns (n.to_natural_64)
		ensure
			timeout_set: timeout = n or timeout = default_timeout
		end

	set_timeout_ns (a_timeout_nanoseconds: NATURAL_64)
			-- Set timeout with to `a_timeout_nanoseconds` nanoseconds.
			-- Warning: the timeout granularity of the platform may not be nanoseconds, but micro or milliseconds.
		require
			is_valid_timeout_ns: is_valid_timeout_ns (a_timeout_nanoseconds)
		do
			if a_timeout_nanoseconds = 0 then
					-- FIXME: check why 0 is not currently accepted [2017-12-01]
					--		  note that changing this may be a breaking change.
				timeout_ns := one_second_in_nanoseconds * default_timeout.to_natural_64
			else
				timeout_ns := a_timeout_nanoseconds
			end
		end

	set_recv_timeout (a_timeout_seconds: INTEGER)
			-- Set the receive timeout in seconds on Current socket.
			-- If `0' the related operations will never timeout.
		obsolete
			"Use `set_recv_timeout_ns` using nanoseconds [2018-01-15]"
		require
			non_negative_timeout: a_timeout_seconds >= 0
		do
			set_recv_timeout_ns (one_second_in_nanoseconds * a_timeout_seconds.to_natural_64)
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
			set_send_timeout_ns (one_second_in_nanoseconds * a_timeout_seconds.to_natural_64)
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

	nanoseconds_to_seconds (ns: NATURAL_64): INTEGER
			-- Number of seconds in `ns` nanoseconds in seconds (that fits in INTEGER_32 value).
			-- Warning: Result can not be more than {INTEGER}.max_value.
		local
			n64: NATURAL_64
		do
			n64 := ns // one_second_in_nanoseconds
			if n64 > {INTEGER}.max_value.to_natural_64 then
				Result := {INTEGER}.max_value
			else
				Result := n64.to_integer_32
			end
		ensure
			non_negative: Result >= 0
			coherent: Result.to_natural_64 * one_second_in_nanoseconds <= ns
		end

feature {NONE} -- Constants

	default_timeout: INTEGER
			-- Default timeout duration in seconds

	one_second_in_nanoseconds: NATURAL_64 = 1_000_000_000
			-- Number of nanoseconds in one second.

	max_timeout_ns_value: NATURAL_64 = 2_147_483_647_999_999_999
			-- Maximum value for a timeout in nanoseconds.
			-- See `is_valid_timeout_ns` for explanation.

feature -- Validation			

	is_valid_timeout_ns (ns: NATURAL_64): BOOLEAN
			--| Note: internally (C API), the ns timeout is splitted into:
			--|  - a long value `tv_sec`: number of seconds
			--|  - a long value `tv_usec`: number of microseconds (with struct timeval)
			--|  or  long value `tv_nsec`: number of nanoseconds  (with struct timespec)
			--| tv_usec or tv_nsec should be >= 0 and < equivalent of 1 second.
			--| tv_usec < 1_000_000
			--| tv_nsec < 1_000_000_000
			--| so there is no issue with NATURAL_64 for usec or nsec
			--| but, then, there is restriction for the seconds value which is coded as long int
			--|  and long values (32 bits) are between -2_147_483_647 and +2_147_483_647 (i.e 2e31 - 1 = {INTEGER_32}.max_value).
			--|  then, the `seconds` part of the timeout <= +2_147_483_647, and then expressed in nanoseconds, and taking into account
			--|  the usec or nsec part, the timeout should not be greater than:
			--|     +2_147_483_647 * 1_000_000_000 + 999_999_999 =  2_147_483_647_999_999_999
			--|      and as NATURAL_64's max value is bigger     = 18_446_744_073_709_551_615
			--|      features dealing with timeout in nanoseconds have related preconditions.
		do
			Result := 0 <= ns and then ns <= max_timeout_ns_value
		end

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

	timeout_ns_set: timeout_ns /= 0
	correct_exist: not is_created implies is_closed and not exists

note
	copyright:	"Copyright (c) 1984-2017, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end -- class NETWORK_SOCKET

