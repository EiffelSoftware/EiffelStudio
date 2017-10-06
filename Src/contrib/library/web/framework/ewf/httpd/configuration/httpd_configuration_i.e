note
	description: "Configuration for the standalone HTTPd server."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	HTTPD_CONFIGURATION_I

inherit
	ANY

	HTTPD_CONSTANTS

feature {NONE} -- Initialization

	make
		do
			http_server_port := default_http_server_port
			max_concurrent_connections := default_max_concurrent_connections
			max_tcp_clients := default_max_tcp_clients
			socket_timeout := default_socket_timeout
			socket_recv_timeout := default_socket_recv_timeout
			keep_alive_timeout := default_keep_alive_timeout
			max_keep_alive_requests := default_max_keep_alive_requests
			is_secure := False
			create secure_certificate.make_empty
			create secure_certificate_key.make_empty
		end

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
			-- By default: 60 seconds, which is appropriate for most situations.

	socket_recv_timeout: INTEGER assign set_socket_recv_timeout
			-- Amount of seconds that the server waits for receiving data during communications.
			-- note: with timeout of 0, socket can wait for ever.
			-- By default: 5 seconds.

	max_concurrent_connections: INTEGER assign set_max_concurrent_connections
			-- Max number of concurrent connections.

	force_single_threaded: BOOLEAN assign set_force_single_threaded
		obsolete
			"Use directly `max_concurrent_connections = 1` [2017-05-31]"
		do
			Result := max_concurrent_connections <= 1
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

	has_secure_support: BOOLEAN
			-- Has SSL/TLS secure support?
		deferred
		end

	request_settings: HTTPD_REQUEST_SETTINGS
		do
			Result.is_verbose := is_verbose
			Result.verbose_level := verbose_level
			Result.timeout := socket_timeout
			Result.socket_recv_timeout := socket_recv_timeout
			Result.keep_alive_timeout := keep_alive_timeout
			Result.max_keep_alive_requests := max_keep_alive_requests
			Result.is_secure := is_secure
		end

feature -- Access: SSL

	is_secure: BOOLEAN
			 -- Is SSL/TLS session?.

	secure_certificate: detachable IMMUTABLE_STRING_32
			-- the signed certificate.

	secure_certificate_key: detachable IMMUTABLE_STRING_32
			-- private key to the certificate authority.

	secure_protocol: NATURAL
			-- By default protocol is tls 1.2.

feature -- Element change

	set_secure_settings (v: detachable separate TUPLE [protocol: separate READABLE_STRING_GENERAL; ca_crt, ca_key: detachable separate READABLE_STRING_GENERAL])
		local
			prot: STRING_32
		do
			is_secure := False
			secure_certificate := Void
			secure_certificate_key := Void
			if v /= Void then
				is_secure := True
				create prot.make_from_separate (v.protocol)
				set_secure_protocol_from_string (prot)
				set_secure_certificate (v.ca_crt)
				set_secure_certificate_key (v.ca_key)
			end
		end

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
			-- Set `socket_timeout' with `a_nb_seconds'.
		do
			socket_timeout := a_nb_seconds
		ensure
			socket_timeout_set: socket_timeout = a_nb_seconds
		end

	set_socket_recv_timeout (a_nb_seconds: like socket_recv_timeout)
			-- Set `socket_recv_timeout' with `a_nb_seconds'.
		do
			socket_recv_timeout := a_nb_seconds
		ensure
			socket_recv_timeout_set: socket_recv_timeout = a_nb_seconds
		end

	set_keep_alive_timeout (a_seconds: like keep_alive_timeout)
			-- Set `keep_alive_timeout' with `a_seconds'.
		do
			keep_alive_timeout := a_seconds
		ensure
			keep_alive_timeout_set: keep_alive_timeout = a_seconds
		end

	set_max_keep_alive_requests (nb: like max_keep_alive_requests)
			-- Set `max_keep_alive_requests' with `nb'.
		do
			max_keep_alive_requests := nb
		ensure
			max_keep_alive_requests_set:  max_keep_alive_requests = nb
		end

	set_force_single_threaded (v: like force_single_threaded)
			-- Force server to handle incoming request in a single thread.
			-- i.e set max_concurrent_connections to 1!
		obsolete
			"Use set_max_concurrent_connections (1) [2017-05-31]"
		do
			if v then
				set_max_concurrent_connections (1)
			else
				set_max_concurrent_connections (default_max_concurrent_connections)
			end
		ensure
			force_single_threaded_set: v implies max_concurrent_connections <= 1
			not_single_threaded: not v implies max_concurrent_connections > 1
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

	set_is_secure (b: BOOLEAN)
			-- Set `is_secure' to `b'.
		do
			if b and has_secure_support then
				is_secure := True
				if
					http_server_port = 80
				then
					set_http_server_port (443)
				end
			else
				is_secure := False
				if
					http_server_port = 443
				then
					set_http_server_port (80)
				end
			end
		ensure
			is_secure_set: has_secure_support implies is_secure
			is_not_secure: not has_secure_support implies not is_secure
		end

	mark_secure
			-- Set is_secure in True.
		do
			set_is_secure (True)
		ensure
			is_secure_set: has_secure_support implies is_secure
			-- http_server_port_set: has_secure_support implies http_server_port = 443
			is_not_secure: not has_secure_support implies not is_secure
			-- default_port: not has_secure_support implies http_server_port = 80
		end

feature -- Element change

	set_secure_certificate (a_value: detachable separate READABLE_STRING_GENERAL)
			-- Set `secure_certificate' from `a_value'.
		do
			if a_value /= Void then
				create secure_certificate.make_from_separate (a_value)
			else
				secure_certificate := Void
			end
		end

	set_secure_certificate_key (a_value: detachable separate READABLE_STRING_GENERAL)
			-- Set `secure_certificate_key' with `a_value'.
		do
			if a_value /= Void then
				create secure_certificate_key.make_from_separate (a_value)
			else
				secure_certificate_key := Void
			end
		end

	set_secure_protocol (a_version: NATURAL)
			-- Set `secure_protocol' with `a_version'.
		do
			secure_protocol := a_version
		ensure
			secure_protocol_set: secure_protocol = a_version
		end

	set_secure_protocol_from_string (a_ssl_version: READABLE_STRING_GENERAL)
			-- Set `secure_protocol' with `a_ssl_version'.
		do
			if a_ssl_version.is_case_insensitive_equal ("tls_1_2") then
				set_secure_protocol_to_tls_1_2
			elseif a_ssl_version.is_case_insensitive_equal ("tls_1_1") then
				set_secure_protocol_to_tls_1_1
			elseif a_ssl_version.is_case_insensitive_equal ("tls_1_0") then
				set_secure_protocol_to_tls_1_0
			elseif a_ssl_version.is_case_insensitive_equal ("dtls_1_0") then
				set_secure_protocol_to_dtls_1_0
			elseif a_ssl_version.is_case_insensitive_equal ("ssl_2_3") then
					-- Obsolete!
				set_secure_protocol_to_ssl_2_or_3
			else -- Default
				set_secure_protocol_to_tls_1_2
			end
		end

feature -- SSL Helpers

	set_secure_protocol_to_ssl_2_or_3
			-- Set `secure_protocol' with `Ssl_23'.
		obsolete
			"Use `set_secure_protocol_to_tls_1_2` [2017-06-23]."
		deferred
		end

	set_secure_protocol_to_tls_1_0
			-- Set `secure_protocol' with `Tls_1_0'.
		deferred
		end

	set_secure_protocol_to_tls_1_1
			-- Set `secure_protocol' with `Tls_1_1'.
		deferred
		end

	set_secure_protocol_to_tls_1_2
			-- Set `secure_protocol' with `Tls_1_2'.
		deferred
		end

	set_secure_protocol_to_dtls_1_0
			-- Set `secure_protocol' with `Dtls_1_0'.
		deferred
		end

note
	copyright: "2011-2017, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
