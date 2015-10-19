note
	description: "Configuration for the standalone HTTPd server."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	HTTPD_CONFIGURATION_I

feature {NONE} -- Initialization

	make
		do
			http_server_port := 80
			max_concurrent_connections := 100
			max_tcp_clients := 100
			socket_accept_timeout := 1_000
			socket_connect_timeout := 5_000
			keep_alive_timeout := 5
			is_secure := False
			create ca_crt.make_empty
			create ca_key.make_empty
		end

feature -- Access

	Server_details: STRING_8
			-- Detail of the server.
		deferred
		end

	http_server_name: detachable READABLE_STRING_8 assign set_http_server_name
	http_server_port: INTEGER assign set_http_server_port
	max_tcp_clients: INTEGER assign set_max_tcp_clients
	max_concurrent_connections: INTEGER assign set_max_concurrent_connections
	socket_accept_timeout: INTEGER assign set_socket_accept_timeout
	socket_connect_timeout: INTEGER assign set_socket_connect_timeout
	force_single_threaded: BOOLEAN assign set_force_single_threaded
		do
			Result := (max_concurrent_connections = 0)
		end

	is_verbose: BOOLEAN assign set_is_verbose
			-- Display verbose message to the output?

	keep_alive_timeout: INTEGER assign set_keep_alive_timeout
			-- Persistent connection timeout
			-- Timeout unit in Seconds.

	has_ssl_support: BOOLEAN
			-- Has SSL support?
		deferred
		end

feature -- Access: SSL

	is_secure: BOOLEAN
			 -- Is SSL/TLS session?.

	ca_crt: STRING
			-- the signed certificate.

	ca_key: STRING
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
			--| Missing postcondition.	
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

	set_socket_accept_timeout (v: like socket_accept_timeout)
			-- Set `socket_accept_timeout' with `v'
		do
			socket_accept_timeout := v
		ensure
			socket_accept_timeout_set: socket_accept_timeout = v
		end

	set_socket_connect_timeout (v: like socket_connect_timeout)
			-- Set `socket_connect_timeout' with `v'
		do
			socket_connect_timeout := v
		ensure
			socket_connect_timeout_set:  socket_connect_timeout = v
		end

	set_force_single_threaded (v: like force_single_threaded)
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

	set_keep_alive_timeout (a_seconds: like keep_alive_timeout)
			-- Set `keep_alive_timeout' with `a_seconds'
		do
			keep_alive_timeout := a_seconds
		ensure
			keep_alive_timeout_set: keep_alive_timeout = a_seconds
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

	set_ca_crt (a_value: STRING)
			-- Set `ca_crt' with `a_value'
		do
			ca_crt := a_value
		ensure
			ca_crt_set: ca_crt = a_value
		end

	set_ca_key (a_value: STRING)
			-- Set `ca_key' with `a_value'
		do
			ca_key := a_value
		ensure
			ca_key_set: ca_key = a_value
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
