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
			--
		do
			if not is_closed then
				if is_created then
					c_close (fd, fd1)
				end
				is_closed := True
			end
			descriptor_available := False
			is_open_read := False
			is_open_write := False
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
			Result := (addr.family = af_inet or else addr.family = af_inet6)
		end

	is_valid_family (addr: attached like address): BOOLEAN
		do
			Result := (addr.family = af_inet or else addr.family = af_inet6)
		end

	ready_for_reading: BOOLEAN
			-- Is data available for reading from the socket within
			-- `timeout' seconds?
		require
			socket_exists: exists
		local
			retval: INTEGER
		do
			retval := c_select_poll_with_timeout (descriptor, True, timeout)
			Result := (retval > 0)
		end

	ready_for_writing: BOOLEAN
			-- Can data be written to the socket within `timeout' seconds?
		require
			socket_exists: exists
		local
			retval: INTEGER
		do
			retval := c_select_poll_with_timeout (descriptor, False, timeout)
			Result := (retval > 0)
		end

	has_exception_state: BOOLEAN
			-- Is socket in exception state within `timeout' seconds?
		require
			socket_exists: exists
		local
			retval: INTEGER
		do
			retval := c_check_exception_with_timeout (descriptor, timeout)
			Result := (retval > 0)
		end

	timeout: INTEGER
			-- Duration of timeout in seconds

feature -- Status setting

	set_reuse_address
			-- Turn `reuse_address' option on.
		require
			socket_exists: exists
		do
			c_set_sock_opt_int (descriptor, level_sol_socket, so_reuse_addr, 1)
		end;

	do_not_reuse_address
			-- Turn `reuse_address' option off.
		require
			socket_exists: exists
		do
			c_set_sock_opt_int (descriptor, level_sol_socket, so_reuse_addr, 0)
		end;

	set_timeout (n: INTEGER)
			-- Set timeout to `n' seconds.
		require
			non_negative: n >= 0
		do
			if n > 0 then
				timeout := n
			else
				timeout := default_timeout
			end
		ensure
			timeout_set: timeout = n or timeout = default_timeout
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

	default_timeout: INTEGER = 20
			-- Default timeout duration in seconds

feature {NONE} -- Externals

	c_close (an_fd: INTEGER; an_fd1: INTEGER)
		external
			"C"
		alias
			"en_socket_close"
		end

	c_select_poll_with_timeout (an_fd: INTEGER; is_read_mode: BOOLEAN;
								timeout_secs: INTEGER): INTEGER
		external
			"C blocking"
		end

	c_check_exception_with_timeout (an_fd: INTEGER;
								timeout_secs: INTEGER): INTEGER
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

	timeout_set: timeout > 0
	correct_exist: not is_created implies is_closed and not exists

note
	copyright:	"Copyright (c) 1984-2015, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"




end -- class NETWORK_SOCKET

