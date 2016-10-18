note
	description: "[
			Request settings for the standalone HTTPd server.
		]"
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

expanded class
	HTTPD_REQUEST_SETTINGS

feature -- Access

	is_verbose: BOOLEAN assign set_is_verbose
			-- Is verbose?

	verbose_level: INTEGER assign set_verbose_level
			-- Verbosity of output.

	is_secure: BOOLEAN assign set_is_secure
			-- Is using secure connection? i.e SSL?

	timeout: INTEGER assign set_timeout
			-- Amount of seconds that the server waits for receipts and transmissions during communications.

	socket_recv_timeout: INTEGER assign set_socket_recv_timeout
			-- Amount of seconds that the server waits for receiving data on socket during communications.

	keep_alive_timeout: INTEGER assign set_keep_alive_timeout
			-- Keep-alive timeout, also known as persistent-connection timeout.
			-- Number of seconds the server waits after a request has been served before it closes the connection.
			-- Unit in Seconds.

	max_keep_alive_requests: INTEGER assign set_max_keep_alive_requests
			-- Maximum number of requests allowed per persistent connection.

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

	set_timeout (a_timeout_in_seconds: INTEGER)
			-- Set `timeout' to `a_timeout_in_seconds'.
		do
			timeout := a_timeout_in_seconds
		end

	set_socket_recv_timeout (a_timeout_in_seconds: INTEGER)
			-- Set `socket_recv_timeout' to `a_timeout_in_seconds'.
		do
			socket_recv_timeout := a_timeout_in_seconds
		end

	set_keep_alive_timeout (a_timeout_in_seconds: INTEGER)
			-- Set `keep_alive_timeout' to `a_timeout_in_seconds'.
		do
			keep_alive_timeout := a_timeout_in_seconds
		end

	set_max_keep_alive_requests (nb: like max_keep_alive_requests)
			-- Set `max_keep_alive_requests' with `nb'
		do
			max_keep_alive_requests := nb
		end

note
	copyright: "2011-2016, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end

