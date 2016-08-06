note
	description: "[
			Component to launch the service using the default connector

				Eiffel Web httpd for this class


				The httpd default connector support options:
					port: numeric such as 8099 (or equivalent string as "8099")
					base: base_url (very specific to standalone server)
					verbose: to display verbose output, useful for standalone connector
					force_single_threaded: use only one thread, useful for standalone connector

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

			port_number := 80 --| Default, but quite often, this port is already used ...
			max_concurrent_connections := 100
			max_tcp_clients := 100
			socket_timeout := 300 -- 300 seconds
			keep_alive_timeout := 15 -- 15 seconds.
			max_keep_alive_requests := 100
			verbose := False
			verbose_level := notice_level

			base_url := ""

			if attached options as opts then
				if attached {READABLE_STRING_GENERAL} opts.option ("server_name") as l_server_name then
					server_name := l_server_name.to_string_8
				end
				if attached {READABLE_STRING_GENERAL} opts.option ("base") as l_base_str then
					base_url := l_base_str.as_string_8
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
					force_single_threaded
				end
				max_concurrent_connections := opts.option_integer_value ("max_concurrent_connections", max_concurrent_connections)
				max_tcp_clients := opts.option_integer_value ("max_tcp_clients", max_tcp_clients)
				socket_timeout := opts.option_integer_value ("socket_timeout", socket_timeout)
				keep_alive_timeout := opts.option_integer_value ("keep_alive_timeout", keep_alive_timeout)
				max_keep_alive_requests := opts.option_integer_value ("max_keep_alive_requests", max_keep_alive_requests)
			end

			create conn.make
			connector := conn
			conn.on_launched_actions.extend (agent on_launched)
			conn.set_base (base_url)

			update_configuration (conn.configuration)
		end

	force_single_threaded
			-- Set `single_threaded' to True.
		do
			max_concurrent_connections := 1
 		end		

feature -- Execution

	update_configuration (cfg: like connector.configuration)
		do
			cfg.set_is_verbose (verbose)
			cfg.set_verbose_level (verbose_level)
			cfg.set_http_server_name (server_name)
			cfg.http_server_port := port_number
			cfg.set_max_concurrent_connections (max_concurrent_connections)
			cfg.set_max_tcp_clients (max_tcp_clients)
			cfg.set_socket_timeout (socket_timeout)
			cfg.set_keep_alive_timeout (keep_alive_timeout)
			cfg.set_max_keep_alive_requests (max_keep_alive_requests)
		end

	launch
			-- <Precursor/>
			-- using `port_number', `base_url', `verbose' and `single_threaded'
		local
			conn: like connector
		do
			conn := connector
			conn.set_base (base_url)
			debug ("ew_standalone")
				if verbose then
					io.error.put_string ("Launching standalone web server on port " + port_number.out)
					if attached server_name as l_name then
						io.error.put_string ("%N http://" + l_name + ":" + port_number.out + "/" + base_url + "%N")
					else
						io.error.put_string ("%N http://localhost:" + port_number.out + "/" + base_url + "%N")
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

	base_url: READABLE_STRING_8

	verbose: BOOLEAN
	verbose_level: INTEGER
			-- Help defining the verbosity.
			-- The higher, the more output.

	max_concurrent_connections: INTEGER
	max_tcp_clients: INTEGER
	socket_timeout: INTEGER
	keep_alive_timeout: INTEGER	
	max_keep_alive_requests: INTEGER

	single_threaded: BOOLEAN
		do
			Result := max_concurrent_connections = 0
		end

feature -- Status report

	connector: WGI_STANDALONE_CONNECTOR [G]
			-- Default connector

	launchable: BOOLEAN
		do
			Result := Precursor and port_number >= 0
		end

;note
	copyright: "2011-2015, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
