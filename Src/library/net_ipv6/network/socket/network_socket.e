indexing

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
			put_real, putreal, put_double, putdouble, put_managed_pointer
		redefine
			make_socket, address, peer_address, is_valid_peer_address, connect
		end

feature

	close_socket is
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

	descriptor: INTEGER is
			-- Socket descriptor of current socket
		do
			Result := fd
		end

	connect is
		local
			retried: BOOLEAN
		do
			if not retried then
				do_connect
				is_open_write := True;
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

	bind is
		local
			retried: BOOLEAN
		do
			if not retried then
				do_bind
				is_open_read := True
				is_bound := True
			end
		rescue
			if not assertion_violation then
				is_open_read := False
				retried := True
				retry
			end
		end

feature -- Status report

	address: NETWORK_SOCKET_ADDRESS;
			-- Local address of socket

	peer_address: NETWORK_SOCKET_ADDRESS;
			-- Peer address of socket

	is_closed: BOOLEAN

	is_created: BOOLEAN

	is_connected: BOOLEAN

	is_bound: BOOLEAN

	port: INTEGER is
			--
		do
			if not is_connected then
				Result := 0
			else
				Result := the_port
			end
		end

	local_port: INTEGER is
			--
		do
			if not is_bound then
				Result := -1
			else
				Result := the_local_port
			end
		end

	reuse_address: BOOLEAN is
			-- Is reuse_address option set?
		require
			socket_exists: exists
		local
			reuse: INTEGER
		do
			reuse := c_get_sock_opt_int (descriptor, level_sol_socket, so_reuse_addr);
			Result := reuse /= 0
		end

	is_valid_peer_address (addr: like address): BOOLEAN is
			-- Is `addr' a valid peer address?
		do
			Result := (addr.family = family)
		end

	ready_for_reading: BOOLEAN is
			-- Is data available for reading from the socket within
			-- `timeout' seconds?
		local
			retval: INTEGER
		do
			retval := c_select_poll_with_timeout (descriptor, True, timeout)
			Result := (retval > 0)
		end

	ready_for_writing: BOOLEAN is
			-- Can data be written to the socket within `timeout' seconds?
		local
			retval: INTEGER
		do
			retval := c_select_poll_with_timeout (descriptor, False, timeout)
			Result := (retval > 0)
		end

	has_exception_state: BOOLEAN is
			-- Is socket in exception state within `timeout' seconds?
		local
			retval: INTEGER
		do
			retval := c_check_exception_with_timeout (descriptor, timeout)
			Result := (retval > 0)
		end

	timeout: INTEGER
			-- Duration of timeout in seconds

feature -- Status setting

	set_reuse_address is
			-- Turn `reuse_address' option on.
		require
			socket_exists: exists
		do
			c_set_sock_opt_int (descriptor, level_sol_socket, so_reuse_addr, 1)
		end;

	do_not_reuse_address is
			-- Turn `reuse_address' option off.
		require
			socket_exists: exists
		do
			c_set_sock_opt_int (descriptor, level_sol_socket, so_reuse_addr, 0)
		end;

	set_timeout (n: INTEGER) is
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

feature {NONE} -- Implementation

	make_socket is
		do
			do_create
			if fd > - 1 then
				descriptor_available := True
				set_blocking
			end
		end

	shutdown is
		do
			-- TODO
		end

	fd: INTEGER

	fd1: INTEGER

	the_port: INTEGER

	the_local_port: INTEGER

	do_create is
		deferred
		end

	do_connect
		deferred
		end

	do_bind is
		deferred
		end

feature {NONE} -- Constants

	default_timeout: INTEGER is 20
			-- Default timeout duration in seconds

feature {NONE} -- Externals

	c_close (an_fd: INTEGER; an_fd1: INTEGER) is
		external
			"C"
		alias
			"en_socket_close"
		end

	c_select_poll_with_timeout (an_fd: INTEGER; is_read_mode: BOOLEAN;
								timeout_secs: INTEGER): INTEGER is
		external
			"C blocking"
		end

	c_check_exception_with_timeout (an_fd: INTEGER;
								timeout_secs: INTEGER): INTEGER is
		external
			"C blocking"
		end

invariant

	timeout_set: timeout > 0

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class NETWORK_SOCKET

