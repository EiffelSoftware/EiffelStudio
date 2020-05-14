note
	description: "[
			Component to launch the service using the default connector

				EiffelWeb httpd for this class

			The httpd default connector support options:
				verbose: to display verbose output
				port: numeric such as 8099 (or equivalent string as "8099")
				base: base_url (very specific to standalone server)
				
				max_concurrent_connections: set to 1, for single threaded behavior
				max_tcp_clients: max number of open tcp connection
				
				socket_timeout_ns: connection timeout in nanoseconds
				socket_recv_timeout_ns: read data timeout in nanoseconds

				keep_alive_timeout_ns: amount of nanoseconds the server will wait for subsequent
									requests on a persistent connection,
				max_keep_alive_requests: number of requests allowed on a persistent connection,

				ssl_enabled: set to True for https support.
				ssl_ca_crt: path to the certificat crt file (relevant when ssl_enabled is True)
				ssl_ca_key: path to the certificat key file (relevant when ssl_enabled is True)


			check WSF_SERVICE_LAUNCHER for more documentation
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	WSF_STANDALONE_SERVICE_LAUNCHER [G -> WSF_EXECUTION create make end]

inherit
	WSF_SERVICE_LAUNCHER [G]
		redefine
			launchable
		end

	WGI_STANDALONE_HTTPD_LOGGER_CONSTANTS

	WSF_TIMEOUT_UTILITIES

create
	make,
	make_and_launch

feature {NONE} -- Initialization

	initialize
		local
			conn: like connector
			s: READABLE_STRING_GENERAL
		do
			create on_launched_actions
			create on_stopped_actions

			port_number := {WGI_STANDALONE_CONSTANTS}.default_http_server_port --| Default, but quite often, this port is already used ...
			max_concurrent_connections := {WGI_STANDALONE_CONSTANTS}.default_max_concurrent_connections
			max_tcp_clients := {WGI_STANDALONE_CONSTANTS}.default_max_tcp_clients
			socket_timeout_ns := seconds_to_nanoseconds ({WGI_STANDALONE_CONSTANTS}.default_socket_timeout) -- default in seconds
			socket_recv_timeout_ns := seconds_to_nanoseconds ({WGI_STANDALONE_CONSTANTS}.default_socket_recv_timeout) -- default in seconds
			keep_alive_timeout_ns := seconds_to_nanoseconds ({WGI_STANDALONE_CONSTANTS}.default_keep_alive_timeout) -- default in seconds.
			max_keep_alive_requests := {WGI_STANDALONE_CONSTANTS}.default_max_keep_alive_requests
			verbose := False
			verbose_level := notice_level

			base_url := Void

			if attached options as opts then
				if attached {READABLE_STRING_GENERAL} opts.option ("server_name") as l_server_name then
					server_name := l_server_name.to_string_8
				end
				if 
					attached {READABLE_STRING_GENERAL} opts.option ("base") as l_base_str and then
					l_base_str.is_valid_as_string_8
				then
					base_url := l_base_str.to_string_8
				end

				verbose := opts.option_boolean_value ("verbose", verbose)
					-- See `{HTTPD_REQUEST_HANDLER_I}.*_verbose_level`

				if opts.has_integer_option ("verbose_level") then
					verbose_level := opts.option_integer_value ("verbose_level", verbose_level)
				elseif attached {READABLE_STRING_GENERAL} opts.option ("verbose_level") as s_verbose_level then
					verbose_level := 0 -- Reset
					across
						s_verbose_level.split ('+') as ic
					loop
						s := ic.item
						if s.is_case_insensitive_equal ("alert") then
							verbose_level := verbose_level | alert_level
						elseif s.is_case_insensitive_equal ("critical") then
							verbose_level := verbose_level | critical_level
						elseif s.is_case_insensitive_equal ("error") then
							verbose_level := verbose_level | error_level
						elseif s.is_case_insensitive_equal ("warning") then
							verbose_level := verbose_level | warning_level
						elseif s.is_case_insensitive_equal ("notice") then
							verbose_level := verbose_level | notice_level
						elseif s.is_case_insensitive_equal ("information") then
							verbose_level := verbose_level | information_level
						elseif s.is_case_insensitive_equal ("debug") then
							verbose_level := verbose_level | debug_level
						else
						end
					end
				end
				port_number := opts.option_integer_value ("port", port_number)

				if opts.option_boolean_value ("force_single_threaded", False) then
						-- Obsolete: keep for backward compatibility with obsolete Nino connector.
					set_max_concurrent_connections (1)
				end
				max_concurrent_connections := opts.option_integer_value ("max_concurrent_connections", max_concurrent_connections)
				max_tcp_clients := opts.option_integer_value ("max_tcp_clients", max_tcp_clients)
				socket_timeout_ns := opts.option_timeout_ns_value ("socket_timeout", socket_timeout_ns)
				socket_recv_timeout_ns := opts.option_timeout_ns_value ("socket_recv_timeout", socket_recv_timeout_ns)
				keep_alive_timeout_ns := opts.option_timeout_ns_value ("keep_alive_timeout", keep_alive_timeout_ns)
				max_keep_alive_requests := opts.option_integer_value ("max_keep_alive_requests", max_keep_alive_requests)

				if
					opts.option_boolean_value ("is_secure", is_secure) and then
					attached opts.option_string_32_value ("secure_protocol", "tls_1_2") as l_secure_prot
				then
					secure_settings := [l_secure_prot, opts.option_string_32_value ("secure_certificate", Void), opts.option_string_32_value ("secure_certificate_key", Void)]
				elseif
						-- OBSOLETE: backward compatible with old settings name [2017-05-31].
					opts.option_boolean_value ("ssl_enabled", is_secure) and then
					attached opts.option_string_32_value ("ssl_protocol", "tls_1_2") as ssl_prot
				then
					secure_settings := [ssl_prot, opts.option_string_32_value ("ssl_ca_crt", Void), opts.option_string_32_value ("ssl_ca_key", Void)]
				end
				if is_secure then
					if opts.has_integer_option ("secure_port") then
						port_number := opts.option_integer_value ("secure_port", port_number)
					end
				end
			end

			create conn.make
			connector := conn
			conn.on_launched_actions.extend (agent on_launched)
			conn.set_base (base_url)

			update_configuration (conn.configuration)
		end

	force_single_threaded
			-- Set `single_threaded' to True.
		obsolete
			"Use set_max_concurrent_connections (1) [2017-05-31]"
		do
			set_max_concurrent_connections (1)
		ensure
			single_threaded: single_threaded
 		end

	set_max_concurrent_connections (v: like max_concurrent_connections)
			-- Set `max_concurrent_connections` to `v`.
		require
			v_positive_or_zero: v >= 0
		do
			max_concurrent_connections := v
		ensure
			max_concurrent_connections_set : max_concurrent_connections = v
		end

feature -- Execution

	update_configuration (cfg: like connector.configuration)
		do
			cfg.set_is_verbose (verbose)
			cfg.set_verbose_level (verbose_level)
			cfg.set_secure_settings (secure_settings)
			cfg.set_http_server_name (server_name)
			cfg.http_server_port := port_number
			cfg.set_max_concurrent_connections (max_concurrent_connections)
			cfg.set_max_tcp_clients (max_tcp_clients)
			cfg.set_socket_timeout_ns (socket_timeout_ns)
			cfg.set_socket_recv_timeout_ns (socket_recv_timeout_ns)
			cfg.set_keep_alive_timeout_ns (keep_alive_timeout_ns)
			cfg.set_max_keep_alive_requests (max_keep_alive_requests)
		end

	launch
			-- <Precursor/>
			-- using associated settings/configuration.
		local
			conn: like connector
		do
			conn := connector
			conn.set_base (base_url)
			debug ("ew_standalone")
				if verbose then
					io.error.put_string ("Launching standalone web server on port " + port_number.out)
					if is_secure then
						io.error.put_string ("%N https://")
					else
						io.error.put_string ("%N http://")
					end
					if attached server_name as l_name then
						io.error.put_string (l_name)
					else
						io.error.put_string ("localhost")
					end
					io.error.put_string (":" + port_number.out)
					if attached base_url as b and then not b.is_empty then
						io.error.put_string (b + "%N")
					else
						io.error.put_string ("/%N")
					end
				end
			end
			update_configuration (conn.configuration)
			conn.launch
		end

feature -- Callback

	on_launched_actions: ACTION_SEQUENCE [TUPLE [like connector]]
			-- Actions triggered when launched

	on_stopped_actions: ACTION_SEQUENCE [TUPLE [like connector]]
			-- Actions triggered when stopped

feature {NONE} -- Implementation

	on_launched (conn: like connector)
		do
			on_launched_actions.call ([conn])
		end

	port_number: INTEGER

	server_name: detachable READABLE_STRING_8

	base_url: detachable READABLE_STRING_8

	verbose: BOOLEAN
	verbose_level: INTEGER
			-- Help defining the verbosity.
			-- The higher, the more output.

	max_concurrent_connections: INTEGER assign set_max_concurrent_connections

	single_threaded: BOOLEAN
		obsolete
			"Use max_concurrent_connections <= 1 [2017-05-31]"
		do
			Result := max_concurrent_connections <= 1
		end

	max_tcp_clients: INTEGER
	socket_timeout_ns: NATURAL_64
	socket_recv_timeout_ns: NATURAL_64

	keep_alive_timeout_ns: NATURAL_64
	max_keep_alive_requests: INTEGER

	is_secure_connection_supported: BOOLEAN
			-- Is SSL supported in current compiled system?
		do
			Result := {WGI_STANDALONE_CONSTANTS}.is_secure_connection_supported
		end

	is_secure: BOOLEAN
			-- Is secure server? i.e using SSL?
		do
			Result := attached secure_settings as l_secure_settings and then
					attached l_secure_settings.protocol as prot and then not prot.is_whitespace
		end

	secure_settings: detachable TUPLE [protocol: READABLE_STRING_GENERAL; ca_crt, ca_key: detachable READABLE_STRING_GENERAL]


feature -- Status report

	connector: WGI_STANDALONE_CONNECTOR [G]
			-- Default connector

	launchable: BOOLEAN
		do
			Result := Precursor and port_number >= 0
		end

;note
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
