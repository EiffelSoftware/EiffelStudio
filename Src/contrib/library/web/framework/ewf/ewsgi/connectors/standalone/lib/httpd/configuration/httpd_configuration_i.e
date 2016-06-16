note
	description: "Configuration for the standalone HTTPd server."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	HTTPD_CONFIGURATION_I

feature {NONE} -- Initialization

	make
		do
			http_server_port := default_http_server_port
			max_concurrent_connections := default_max_concurrent_connections
			max_tcp_clients := default_max_tcp_clients
			socket_timeout := default_socket_timeout
			keep_alive_timeout := default_keep_alive_timeout
			max_keep_alive_requests := default_max_keep_alive_requests
			is_secure := False
			create ca_crt.make_empty
			create ca_key.make_empty
		end

feature -- Defaults

	default_http_server_port: INTEGER = 80
	default_max_concurrent_connections: INTEGER = 100
	default_max_tcp_clients: INTEGER = 100
	default_socket_timeout: INTEGER = 300 -- seconds
	default_keep_alive_timeout: INTEGER = 15 -- seconds
	default_max_keep_alive_requests: INTEGER = 100

feature -- Access

	Server_details: STRING_8
			-- Detail of the server.
		deferred
		end

	http_server_name: detachable READABLE_STRING_8 assign set_http_server_name
	http_server_port: INTEGER assign set_http_server_port
	max_tcp_clients: INTEGER assign set_max_tcp_clients
			-- Listen on socket for at most `queue' connections.

	socket_timeout: INTEGER assign set_socket_timeout
			-- Amount of seconds that the server waits for receipts and transmissions during communications.
			-- note: with timeout of 0, socket can wait for ever.
			-- By default: 300 seconds, which is appropriate for most situations.

	max_concurrent_connections: INTEGER assign set_max_concurrent_connections
			-- Max number of concurrent connections.

	force_single_threaded: BOOLEAN assign set_force_single_threaded
		do
			Result := max_concurrent_connections = 0
		end

	is_verbose: BOOLEAN assign set_is_verbose
			-- Display verbose message to the output?

	verbose_level: INTEGER assign set_verbose_level
			-- Verbosity of output.

	keep_alive_timeout: INTEGER assign set_keep_alive_timeout
			-- Persistent connection timeout.
			-- Number of seconds the server waits after a request has been served before it closes the connection.
			-- Timeout unit in Seconds.
			-- By default: 5 seconds.

	max_keep_alive_requests: INTEGER assign set_max_keep_alive_requests
			-- Maximum number of requests allowed per persistent connection.
			-- Recommended a high setting.
			-- To disable KeepAlive, set `max_keep_alive_requests' to 0.
			-- By default: 100 .

	has_ssl_support: BOOLEAN
			-- Has SSL support?
		deferred
		end

	request_settings: HTTPD_REQUEST_SETTINGS
		do
			Result.is_verbose := is_verbose
			Result.verbose_level := verbose_level
			Result.timeout := socket_timeout
			Result.keep_alive_timeout := keep_alive_timeout
			Result.max_keep_alive_requests := max_keep_alive_requests
		end

feature -- Access: SSL

	is_secure: BOOLEAN
			 -- Is SSL/TLS session?.

	ca_crt: IMMUTABLE_STRING_8
			-- the signed certificate.

	ca_key: IMMUTABLE_STRING_8
			-- private key to the certificate.

	ssl_protocol: NATURAL
			-- By default protocol is tls 1.2.

feature -- Element change

	set_http_server_name (v: detachable separate READABLE_STRING_8)
		do
			if v = Void then
				unset_http_server_name
			else
				create {IMMUTABLE_STRING_8} http_server_name.make_from_separate (v)
			end
		end

	unset_http_server_name
			-- Unset `http_server_name' value.
		do
			http_server_name := Void
		ensure
			unset_http_server_name: http_server_name = Void
		end

	set_http_server_port (v: like http_server_port)
			-- Set `http_server_port' with `v'.
		do
			http_server_port := v
		ensure
			http_server_port_set: http_server_port = v
		end

	set_max_tcp_clients (v: like max_tcp_clients)
			-- Set `max_tcp_clients' with `v'.
		do
			max_tcp_clients := v
		ensure
			max_tcp_clients_set: max_tcp_clients = v
		end

	set_max_concurrent_connections (v: like max_concurrent_connections)
			-- Set `max_concurrent_connections' with `v'.
		do
			max_concurrent_connections := v
		ensure
			max_concurrent_connections_set : max_concurrent_connections = v
		end

	set_socket_timeout (a_nb_seconds: like socket_timeout)
			-- Set `socket_timeout' with `a_nb_seconds'
		do
			socket_timeout := a_nb_seconds
		ensure
			socket_timeout_set: socket_timeout = a_nb_seconds
		end

	set_keep_alive_timeout (a_seconds: like keep_alive_timeout)
			-- Set `keep_alive_timeout' with `a_seconds'
		do
			keep_alive_timeout := a_seconds
		ensure
			keep_alive_timeout_set: keep_alive_timeout = a_seconds
		end

	set_max_keep_alive_requests (nb: like max_keep_alive_requests)
			-- Set `max_keep_alive_requests' with `nb'
		do
			max_keep_alive_requests := nb
		ensure
			max_keep_alive_requests_set:  max_keep_alive_requests = nb
		end

	set_force_single_threaded (v: like force_single_threaded)
			-- Force server to handle incoming request in a single thread.
			-- i.e set max_concurrent_connections to 0!
		obsolete
			"Use set_max_concurrent_connections (0) [June/2016]"
		do
			if v then
				set_max_concurrent_connections (0)
			end
			--|Missing postcondition
			--| force_single_thread_set: v implies max_concurrent_connections = 0	
			--| not_single_thread: not v implies max_concurrent_connections > 0	
		end

	set_is_verbose (b: BOOLEAN)
			-- Set `is_verbose' to `b'
		do
			is_verbose := b
		ensure
			is_verbose_set:  is_verbose = b
		end

	set_verbose_level (lev: INTEGER)
			-- Set `verbose_level' to `lev'.
		do
			verbose_level := lev
		ensure
			verbose_level_set: verbose_level = lev
		end

	mark_secure
			-- Set is_secure in True
		do
			if has_ssl_support then
				is_secure := True
				if http_server_port = 80 then
					set_http_server_port (443)
				end
			else
				is_secure := False
			end
		ensure
			is_secure_set: has_ssl_support implies is_secure
			-- http_server_port_set: has_ssl_support implies http_server_port = 443
			is_not_secure: not has_ssl_support implies not is_secure
			-- default_port: not has_ssl_support implies http_server_port = 80
		end

feature -- Element change

	set_ca_crt (a_value: separate READABLE_STRING_8)
			-- Set `ca_crt' from `a_value'.
		do
			create ca_crt.make_from_separate (a_value)
		end

	set_ca_key (a_value: separate READABLE_STRING_8)
			-- Set `ca_key' with `a_value'.
		do
			create ca_key.make_from_separate (a_value)
		end

	set_ssl_protocol  (a_version: NATURAL)
			-- Set `ssl_protocol' with `a_version'
		do
			ssl_protocol := a_version
		ensure
			ssl_protocol_set: ssl_protocol = a_version
		end

feature -- SSL Helpers

	set_ssl_protocol_to_ssl_2_or_3
			-- Set `ssl_protocol' with `Ssl_23'.
		deferred
		end

	set_ssl_protocol_to_tls_1_0
			-- Set `ssl_protocol' with `Tls_1_0'.
		deferred
		end

	set_ssl_protocol_to_tls_1_1
			-- Set `ssl_protocol' with `Tls_1_1'.
		deferred
		end

	set_ssl_protocol_to_tls_1_2
			-- Set `ssl_protocol' with `Tls_1_2'.
		deferred
		end

	set_ssl_protocol_to_dtls_1_0
			-- Set `ssl_protocol' with `Dtls_1_0'.
		deferred
		end

note
	copyright: "2011-2014, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
