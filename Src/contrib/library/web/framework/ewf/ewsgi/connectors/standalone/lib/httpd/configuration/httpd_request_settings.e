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

	timeout: INTEGER assign set_timeout
			-- Amount of seconds that the server waits for receipts and transmissions during communications.

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

	set_timeout (a_timeout_in_seconds: INTEGER)
			-- Set `timeout' to `a_timeout_in_seconds'.
		do
			timeout := a_timeout_in_seconds
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

end

