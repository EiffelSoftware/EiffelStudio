note
	description: "[
			Request settings for the standalone HTTPd server.
		]"
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

expanded class
	HTTPD_REQUEST_SETTINGS

inherit
	SOCKET_TIMEOUT_UTILITIES

feature -- Access

	is_verbose: BOOLEAN assign set_is_verbose
			-- Is verbose?

	verbose_level: INTEGER assign set_verbose_level
			-- Verbosity of output.

	is_secure: BOOLEAN assign set_is_secure
			-- Is using secure connection? i.e SSL?

	timeout_ns: NATURAL_64 assign set_timeout_ns
			-- Amount of seconds that the server waits for receipts and transmissions during communications.

	socket_recv_timeout_ns: NATURAL_64 assign set_socket_recv_timeout_ns
			-- Amount of seconds that the server waits for receiving data on socket during communications.

	keep_alive_timeout_ns: NATURAL_64 assign set_keep_alive_timeout_ns
			-- Keep-alive timeout, also known as persistent-connection timeout.
			-- Number of seconds the server waits after a request has been served before it closes the connection.
			-- Unit in Seconds.

	max_keep_alive_requests: INTEGER assign set_max_keep_alive_requests
			-- Maximum number of requests allowed per persistent connection.

feature -- Access: obsolete			

	timeout: INTEGER assign set_timeout
		obsolete
			"Use `timeout_ns` [2018-10-29]"
		do
			Result := nanoseconds_to_seconds (timeout_ns)
		end

	socket_recv_timeout: INTEGER assign set_socket_recv_timeout
		obsolete
			"Use `socket_recv_timeout_ns` [2018-10-29]"
		do
			Result := nanoseconds_to_seconds (socket_recv_timeout_ns)
		end

	keep_alive_timeout: INTEGER assign set_keep_alive_timeout
		obsolete
			"Use `keep_alive_timeout_ns` [2018-10-29]"
		do
			Result := nanoseconds_to_seconds (keep_alive_timeout_ns)
		end

feature -- Change

	set_is_verbose (b: BOOLEAN)
			-- Set `is_verbose' to `b'.
		do
			is_verbose := b
		end

	set_verbose_level (lev: INTEGER)
			-- Set `verbose_level' to `lev'.
		do
			verbose_level := lev
		end

	set_is_secure (b: BOOLEAN)
			-- Set `is_secure' to `b'.
		do
			is_secure := b
		end

feature -- Timeout change		

	set_timeout_ns (a_timeout_in_nanoseconds: NATURAL_64)
			-- Set `timeout_ns' to `a_timeout_in_nanoseconds'.
		do
			timeout_ns := a_timeout_in_nanoseconds
		end

	set_socket_recv_timeout_ns (a_timeout_in_nanoseconds: NATURAL_64)
			-- Set `socket_recv_timeout_ns' to `a_timeout_in_nanoseconds'.
		do
			socket_recv_timeout_ns := a_timeout_in_nanoseconds
		end

	set_keep_alive_timeout_ns (a_timeout_in_nanoseconds: NATURAL_64)
			-- Set `keep_alive_timeout_ns' to `a_timeout_in_nanoseconds'.
		do
			keep_alive_timeout_ns := a_timeout_in_nanoseconds
		end

feature -- Timeout change (in seconds)		

	set_timeout (a_timeout_in_seconds: INTEGER)
			-- Set `timeout' to `a_timeout_in_seconds'.
		do
			set_timeout_ns (seconds_to_nanoseconds (a_timeout_in_seconds))
		end

	set_socket_recv_timeout (a_timeout_in_seconds: INTEGER)
			-- Set `socket_recv_timeout' to `a_timeout_in_seconds'.
		do
			set_socket_recv_timeout_ns (seconds_to_nanoseconds (a_timeout_in_seconds))
		end

	set_keep_alive_timeout (a_timeout_in_seconds: INTEGER)
			-- Set `keep_alive_timeout' to `a_timeout_in_seconds'.
		do
			set_keep_alive_timeout_ns (seconds_to_nanoseconds (a_timeout_in_seconds))
		end

feature -- Change		

	set_max_keep_alive_requests (nb: like max_keep_alive_requests)
			-- Set `max_keep_alive_requests' with `nb'
		do
			max_keep_alive_requests := nb
		end

note
	copyright: "2011-2018, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end

