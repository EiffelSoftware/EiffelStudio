note
	description: "[
			Options specific to standalone connector.
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	WSF_STANDALONE_SERVICE_OPTIONS

inherit
	WSF_SERVICE_LAUNCHER_OPTIONS

create
	default_create,
	make,
	make_from_array,
	make_from_iterable

convert
	make_from_array ({ARRAY [TUPLE [name: READABLE_STRING_GENERAL; value: detachable ANY]]})	

feature -- Status report

	is_secure_connection_supported: BOOLEAN
			-- Is SSL/TLS supported by current compiled system?
		do
			Result := {WGI_STANDALONE_CONSTANTS}.is_secure_connection_supported
		end

feature -- Access: output

	is_verbose: BOOLEAN
			-- Send verbose message to the output?
		do
			Result := option_boolean_value ("verbose", False)
		end

	verbose_level: detachable READABLE_STRING_8
			-- Verbosity of output.
		do
			if attached {READABLE_STRING_GENERAL} option ("verbose_level") as l_verbose_level and then l_verbose_level.is_valid_as_string_8 then
				Result := l_verbose_level.to_string_8
			end
		end

feature -- Access: connection			

	port: INTEGER assign set_port
			-- Listening port number.
		do
			Result := option_integer_value ("port", 0)
		end

	server_name: detachable READABLE_STRING_8 assign set_server_name
			-- Listening only for connection on `server_name' if defined.
		do
			if attached {READABLE_STRING_GENERAL} option ("server_name") as l_server_name and then l_server_name.is_valid_as_string_8 then
				Result := l_server_name.to_string_8
			end
		end

	base_url: detachable READABLE_STRING_8 assign set_base_url
		do
			if attached {READABLE_STRING_GENERAL} option ("base") as l_base and then l_base.is_valid_as_string_8 then
				Result := l_base.to_string_8
			end
		end

	max_concurrent_connections: INTEGER assign set_max_concurrent_connections
			-- Maximum of concurrent connections.
			-- Define the size of the concurrent pool.
		do
			Result := option_integer_value ("max_concurrent_connections", 0)
		end

	max_tcp_clients: INTEGER assign set_max_tcp_clients
			-- Listen on socket for at most `max_tcp_clients' connections.	
		do
			Result := option_integer_value ("max_tcp_clients", 0)
		end

feature -- Access: network

	socket_timeout: INTEGER assign set_socket_timeout
			-- Amount of seconds that the server waits for receipts and transmissions during communications.
			-- note: with timeout of 0, socket can wait for ever.
			-- By default: {HTTPD_CONFIGURATION_I}.default_socket_timeout seconds, which is appropriate for most situations.
		do
			Result := option_integer_value ("socket_timeout", 0)
		end

	socket_recv_timeout: INTEGER assign set_socket_recv_timeout
			-- Amount of seconds that the server waits for receiving data during communications.
			-- note: with timeout of 0, socket can wait for ever.
			-- By default: {HTTPD_CONFIGURATION_I}.default_socket_recv_timeout seconds.	
		do
			Result := option_integer_value ("socket_recv_timeout", 0)
		end

feature -- Access: persistent connection	

	keep_alive_timeout: INTEGER assign set_keep_alive_timeout
			-- Persistent connection timeout.
			-- Number of seconds the server waits after a request has been served before it closes the connection.
			-- Timeout unit in Seconds.
			-- By default: {HTTPD_CONFIGURATION_I}.default_keep_alive_timeout .	
		do
			Result := option_integer_value ("keep_alive_timeout", 0)
		end

	max_keep_alive_requests: INTEGER assign set_max_keep_alive_requests
			-- Maximum number of requests allowed per persistent connection.
			-- Recommended a high setting.
			-- To disable KeepAlive, set `max_keep_alive_requests' to 0.
			-- To have no limit, set `max_keep_alive_requests' to -1.
			-- By default: {HTTPD_CONFIGURATION_I}.default_max_keep_alive_requests .	
		do
			Result := option_integer_value ("max_keep_alive_requests", 0)
		end

	persistent_connection_disabled: BOOLEAN
			-- Persistent connection disabled?
			-- (or Keep-Alive disabled).
		do
			Result := max_keep_alive_requests = 0
		end

	has_unlimited_keep_alive_requests: BOOLEAN
			-- Has unlimited count of keep alive requests.
			-- i.e no limit of number of requests allowed per persistent connection.
		do
			Result := max_keep_alive_requests < 0
		end

feature -- Access: SSL	

	is_secure: BOOLEAN assign set_is_secure
			 -- Is SSL/TLS session?
		do
			Result := option_boolean_value ("is_secure", False)
		end

	secure_protocol: detachable READABLE_STRING_GENERAL assign set_secure_protocol
			-- SSL protocol name, by default TLS 1.2
		do
			if attached {READABLE_STRING_GENERAL} option ("secure_protocol") as l_prot and then l_prot.is_valid_as_string_8 then
				Result := l_prot.to_string_8
			end
		end

	secure_certificate: detachable READABLE_STRING_GENERAL assign set_secure_certificate
			-- Signed certificate.	
		do
			if attached {READABLE_STRING_GENERAL} option ("secure_certificate") as l_ssl_ca_crt then
				Result := l_ssl_ca_crt
			end
		end

	secure_certificate_key: detachable READABLE_STRING_GENERAL assign set_secure_certificate_key
			-- Private key for the certificate.
		do
			if attached {READABLE_STRING_GENERAL} option ("secure_certificate_key") as l_ssl_ca_key then
				Result := l_ssl_ca_key
			end
		end

feature -- Element change

	set_is_verbose (b: BOOLEAN)
		do
			set_boolean_option ("verbose", b)
		end

	set_verbose_level (lev: detachable READABLE_STRING_GENERAL)
			-- Set `verbose_level' to `lev'.
		do
			set_string_option ("verbose_level", lev)
		end

	set_port (a_port_number: INTEGER)
		do
			set_numeric_option ("port", a_port_number)
		end

	set_server_name (v: detachable READABLE_STRING_8)
		do
			set_string_option ("server_name", v)
		end

	set_base_url (v: detachable READABLE_STRING_8)
		do
			set_string_option ("base_url", v)
		end

	set_max_tcp_clients (v: like max_tcp_clients)
			-- Set `max_tcp_clients' with `v'.
		do
			set_numeric_option ("max_tcp_clients", v)
		end

	set_max_concurrent_connections (v: like max_concurrent_connections)
			-- Set `max_concurrent_connections' with `v'.
		do
			set_numeric_option ("max_concurrent_connections", v)
		end

	set_socket_timeout (a_nb_seconds: like socket_timeout)
			-- Set `socket_timeout' with `a_nb_seconds'
		do
			set_numeric_option ("socket_timeout", a_nb_seconds)
		end

	set_socket_recv_timeout (a_nb_seconds: like socket_recv_timeout)
			-- Set `socket_recv_timeout' with `a_nb_seconds'
		do
			set_numeric_option ("socket_recv_timeout", a_nb_seconds)
		end

	set_keep_alive_timeout (a_nb_seconds: like keep_alive_timeout)
			-- Set `keep_alive_timeout' with `a_nb_seconds'
		do
			set_numeric_option ("keep_alive_timeout", a_nb_seconds)
		end

	set_max_keep_alive_requests (nb: like max_keep_alive_requests)
			-- Set `max_keep_alive_requests' with `nb'
		do
			set_numeric_option ("max_keep_alive_requests", nb)
		end

	set_unlimited_keep_alive_requests
		do
			set_max_keep_alive_requests (-1)
		end

	disable_persistent_connection
		do
			set_max_keep_alive_requests (0)
		end

	set_is_secure (b: BOOLEAN)
			-- Set secured connection enabled to `b'.
			-- i.e if connection is using SSL/TLS.
		do
			set_boolean_option ("is_secure", b)
		end

	set_secure_protocol_to_ssl_2_or_3
			-- Set `ssl_protocol' with `Ssl_23'.
		do
			set_secure_protocol ("ssl_2_3")
		end

	set_secure_protocol_to_tls_1_0
			-- Set `ssl_protocol' with `Tls_1_0'.
		do
			set_secure_protocol ("tls_1_0")
		end

	set_secure_protocol_to_tls_1_1
			-- Set `ssl_protocol' with `Tls_1_1'.
		do
			set_secure_protocol ("tls_1_1")
		end

	set_secure_protocol_to_tls_1_2
			-- Set `ssl_protocol' with `Tls_1_2'.
		do
			set_secure_protocol ("tls_1_2")
		end

	set_secure_protocol_to_dtls_1_0
			-- Set `ssl_protocol' with `Dtls_1_0'.
		do
			set_secure_protocol ("dtls_1_0")
		end

	set_secure_protocol (a_prot: detachable READABLE_STRING_GENERAL)
			-- Set `secure_protocol' with `a_version'
		do
			set_string_option ("secure_protocol", a_prot)
		end

	set_secure_certificate (a_value: detachable READABLE_STRING_GENERAL)
			-- Set `secure_certificate' from `a_value'.
		do
			set_string_option ("secure_certificate", a_value)
		end

	set_secure_certificate_key (a_value: detachable READABLE_STRING_GENERAL)
			-- Set `secure_certificate_key' with `a_value'.
		do
			set_string_option ("secure_certificate_key", a_value)
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
