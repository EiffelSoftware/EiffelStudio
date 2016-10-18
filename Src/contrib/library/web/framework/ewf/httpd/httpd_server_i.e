note
	description: "HTTPD server interface"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	HTTPD_SERVER_I

inherit
	HTTPD_DEBUG_FACILITIES

	HTTPD_LOGGER

	HTTPD_LOGGER_CONSTANTS

feature {NONE} -- Initialization

	make (a_factory: like factory)
			-- Create current httpd server with `a_factory' of connection handlers.
			-- `a_factory': connection handler builder
		require
			a_factory_is_separated: {PLATFORM}.is_scoop_capable implies not attached {HTTPD_REQUEST_HANDLER_FACTORY} a_factory
		do
			make_configured (create {like configuration}.make, a_factory)
		end

	make_configured (a_cfg: like configuration; a_factory: like factory)
			-- `a_cfg': server configuration
			-- `a_factory': connection handler builder
		do
			configuration := a_cfg
			factory := a_factory

			build_controller

			initialize
		end

	build_controller
			-- Build `controller'.
		do
			create <NONE> controller
		end

	initialize
			-- Initialize Current server.
		do
			is_shutdown_requested := False
		end

feature	-- Access

	is_verbose: BOOLEAN
			-- Is verbose for output messages.

	verbose_level: INTEGER
			-- Verbosity of output.

	configuration: HTTPD_CONFIGURATION
			-- Associated server configuration.

	controller: separate HTTPD_CONTROLLER

	factory: separate HTTPD_REQUEST_HANDLER_FACTORY

	is_persistent_connection_supported: BOOLEAN = True
			-- Is persistent connection supported?

feature -- Callbacks

	observer: detachable separate HTTPD_SERVER_OBSERVER

	set_observer (obs: like observer)
			-- Set `observer' to `obs'.
		do
			observer := obs
		end

feature -- Access: listening

	port: INTEGER
			-- Effective listening port.
			--| If 0 then it is not launched successfully!

feature -- Status: listening

	is_launched: BOOLEAN
			-- Server launched and listening on `port'	

	is_terminated: BOOLEAN
			-- Is terminated?

	is_shutdown_requested: BOOLEAN
			-- Set true to stop accept loop

feature {NONE} -- Access: server

	request_counter: INTEGER
			-- request counter, incremented for each new incoming connection.			

feature -- Execution

	launch
		do
			apply_configuration
			is_terminated := False
			if is_verbose then
				log ("%N%NStarting Web Application Server ...")
				log ("  - port = " + configuration.http_server_port.out)
				log ("  - max_tcp_clients = " + configuration.max_tcp_clients.out)
				log ("  - max_concurrent_connections = " + configuration.max_concurrent_connections.out)
				log ("  - socket_timeout = " + configuration.socket_timeout.out + " seconds")
				log ("  - socket_recv_timeout = " + configuration.socket_recv_timeout.out + " seconds")
				log ("  - keep_alive_timeout = " + configuration.keep_alive_timeout.out + " seconds")
				log ("  - max_keep_alive_requests = " + configuration.max_keep_alive_requests.out)
				if configuration.has_secure_support then
					if configuration.is_secure then
						log ("  - SSL = enabled")
					else
						log ("  - SSL = disabled")
					end
				else
					log ("  - SSL = not supported")
				end
				if configuration.verbose_level > 0 then
					log ("  - verbose_level = " + logger_level_representation (configuration.verbose_level))
				end
			end
			is_shutdown_requested := False
			listen
			is_terminated := True
			on_terminated
		end

	shutdown_server
		do
			debug ("dbglog")
				dbglog ("Shutdown requested")
			end
			is_shutdown_requested := True
			controller_shutdown (controller)
		end

	controller_shutdown (ctl: attached like controller)
		do
			ctl.shutdown
		end

feature -- Listening

	listen
			-- <Precursor>
			-- Creates a socket and connects to the http server.
			-- `a_server': The main server object
		local
			l_listening_socket: detachable HTTPD_STREAM_SOCKET
			l_http_port: INTEGER
			l_connection_handler: HTTPD_CONNECTION_HANDLER
		do
			is_terminated := False
			is_launched := False
			port := 0
			is_shutdown_requested := False
			l_http_port := configuration.http_server_port

			if
				attached configuration.http_server_name as l_servername and then
				attached (create {INET_ADDRESS_FACTORY}).create_from_name (l_servername) as l_addr
			then
				l_listening_socket := new_listening_socket (l_addr, l_http_port)
			else
				l_listening_socket := new_listening_socket (Void, l_http_port)
			end

			if not l_listening_socket.is_bound then
				if is_verbose then
					log ("Socket could not be bound on port " + l_http_port.out + " !")
				end
			else
				l_http_port := l_listening_socket.port
				create l_connection_handler.make (Current)
				from
					l_listening_socket.listen (configuration.max_tcp_clients)
					if is_verbose then
						if configuration.is_secure then
							log ("%NListening on port " + l_http_port.out +" : https://localhost:" + l_http_port.out + "/")
						else
							log ("%NListening on port " + l_http_port.out +" : http://localhost:" + l_http_port.out + "/")
						end
					end
					on_launched (l_http_port)
				until
					is_shutdown_requested
				loop
					request_counter := request_counter + 1
					if is_verbose then
						log ("#" + request_counter.out + "# Waiting connection...(listening socket:" + l_listening_socket.descriptor.out + ")")
					end
					debug ("dbglog")
						dbglog (generator + ".before process_waiting_incoming_connection")
					end
					l_connection_handler.accept_incoming_connection (l_listening_socket)
					debug ("dbglog")
						dbglog (generator + ".after process_waiting_incoming_connection")
					end

					update_is_shutdown_requested (l_connection_handler)
				end
				wait_for_connection_handler_completion (l_connection_handler)
				l_listening_socket.cleanup
				check
					socket_is_closed: l_listening_socket.is_closed
				end
			end
			if is_launched then
				on_stopped
			end
			if is_verbose then
				log ("HTTP Connection Server ends.")
			end
		rescue
			log ("HTTP Connection Server shutdown due to exception. Please relaunch manually.")

			if l_listening_socket /= Void then
				l_listening_socket.cleanup
				check
					listening_socket_is_closed: l_listening_socket.is_closed
				end
			end
			if is_launched then
				on_stopped
			end
			is_shutdown_requested := True
			retry
		end

feature {NONE} -- Factory

	new_listening_socket (a_addr: detachable INET_ADDRESS; a_http_port: INTEGER): HTTPD_STREAM_SOCKET
		do
			if a_addr /= Void then
				create Result.make_server_by_address_and_port (a_addr, a_http_port)
			else
				create Result.make_server_by_port (a_http_port)
			end
		end

feature {NONE} -- Helpers

	wait_for_connection_handler_completion (h: HTTPD_CONNECTION_HANDLER)
		do
			h.wait_for_completion
			debug ("dbglog")
				dbglog ("Shutdown ready from connection_handler point of view")
			end
		end

	update_is_shutdown_requested (a_connection_handler: HTTPD_CONNECTION_HANDLER)
		do
			is_shutdown_requested := is_shutdown_requested or shutdown_requested (controller)
			if is_shutdown_requested then
				a_connection_handler.shutdown
			end
		end

	shutdown_requested (a_controller: separate HTTPD_CONTROLLER): BOOLEAN
			-- Shutdown requested on concurrent `a_controller'?
		do
			Result := a_controller.shutdown_requested
		end

feature -- Event

	on_launched (a_port: INTEGER)
			-- Server launched using port `a_port'
		require
			not_launched: not is_launched
		do
			is_launched := True
			port := a_port
			if attached observer as obs then
				observer_on_launched (obs, a_port)
			end
		ensure
			is_launched: is_launched
		end

	on_stopped
			-- Server stopped
		require
			is_launched: is_launched
		do
			if attached observer as obs then
				observer_on_stopped (obs)
			end
		end

	on_terminated
			-- Server terminated
		require
			is_terminated
		do
			if is_terminated and is_verbose then
				log ("%N%NTerminating Web Application Server (port="+ port.out +"):%N")
			end
			if attached output as o then
				o.flush
				o.close
			end
			if attached observer as obs then
				observer_on_terminated (obs)
			end
		end

feature {NONE} -- Separate event

	observer_on_launched (obs: attached like observer; a_port: INTEGER)
		do
			obs.on_launched (a_port)
		end

	observer_on_stopped (obs: attached like observer)
		do
			obs.on_stopped
		end

	observer_on_terminated (obs: attached like observer)
		do
			obs.on_terminated
		end

feature -- Configuration change

	apply_configuration
		require
			is_not_launched: not is_launched
		do
			is_verbose := configuration.is_verbose
			verbose_level := configuration.verbose_level
		end

feature -- Output

	output: detachable FILE

	set_log_output (f: FILE)
			-- Set `output' to `f'.
		do
			output := f
		ensure
			output_set: output = f
		end

	log (a_message: separate READABLE_STRING_8)
			-- Log `a_message'.
		local
			m: STRING
		do
			create m.make_from_separate (a_message)
			if attached output as o then
				o.put_string (m)
				o.put_new_line
			else
				io.error.put_string (m)
				io.error.put_new_line
			end
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
