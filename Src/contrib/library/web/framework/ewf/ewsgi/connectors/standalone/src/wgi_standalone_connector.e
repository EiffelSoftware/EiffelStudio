note
	description: "[
			Standalone Web Server connector.
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	WGI_STANDALONE_CONNECTOR [G -> WGI_EXECUTION create make end]

inherit
	WGI_CONNECTOR

create
	make,
	make_with_base

feature {NONE} -- Initialization

	make
			-- Create current standalone connector.
		local
			fac: like request_handler_factory
		do
				-- Callbacks
			create on_launched_actions

				-- Server
			create <NONE> fac
			request_handler_factory := fac
			create server.make (fac)
			create <NONE> observer
			configuration := server_configuration (server)
			controller := server_controller (server)
			initialize_server (server)
		end

	make_with_base (a_base: detachable separate READABLE_STRING_8)
			-- Create current standalone connector with base url `a_base'
		require
			a_base_starts_with_slash: (a_base /= Void and then not a_base.is_empty) implies is_valid_base (a_base)
		do
			make
			set_base (a_base)
		end

feature {NONE} -- Separate helper

	initialize_server (a_server: like server)
		do
			a_server.set_observer (observer)
		end

	update_factory (conn: detachable separate WGI_STANDALONE_CONNECTOR [G]; fac: separate WGI_HTTPD_REQUEST_HANDLER_FACTORY [G]; a_conf: like configuration)
		do
			fac.update_with (conn, a_conf)
		end

	server_configuration (a_server: like server): like configuration
		do
			Result := a_server.configuration
		end

feature -- Access

	name: STRING_8
			-- Name of Current connector
		once
			Result := "httpd"
		end

	version: STRING_8
			-- Version of Current connector
		once
			Result := "1.0"
		end

feature -- Access

	server: separate HTTPD_SERVER
			-- HTTPd server object.

	request_handler_factory: separate WGI_HTTPD_REQUEST_HANDLER_FACTORY [G]
			-- Factory for request handlers.

	controller: separate HTTPD_CONTROLLER
			-- Controller used to shutdown server.

	observer: separate WGI_STANDALONE_SERVER_OBSERVER
			-- Observer providing information related to port number, and server status.

	configuration: separate HTTPD_CONFIGURATION
			-- Server configuration.

feature -- Access

	base: detachable READABLE_STRING_8
			-- Root url base

feature -- Status report

	launched: BOOLEAN
			-- Server launched and listening on `port'

	port: INTEGER
			-- Listening port.
			--| 0: not launched

feature -- Callbacks

	on_launched_actions: ACTION_SEQUENCE [TUPLE [WGI_STANDALONE_CONNECTOR [WGI_EXECUTION]]]
			-- Actions triggered when launched.
			-- WARNING: only supported for now with SCOOP concurrency mode. [2016-10-07]

feature -- Event

	on_launched (a_port: INTEGER)
			-- Server launched
		do
			launched := True
			port := a_port
			on_launched_actions.call ([Current])
		end

feature -- Element change

	set_base (v: detachable separate READABLE_STRING_8)
			-- Set base url `base' to `v'.
		require
			b_starts_with_slash: (v /= Void and then not v.is_empty) implies is_valid_base (v)
		do
			if v = Void then
				base := Void
			else
				create {STRING_8} base.make_from_separate (v)
			end
		ensure
			valid_base: (attached base as l_base and then not l_base.is_empty) implies l_base.starts_with ("/")
		end

	is_valid_base (v: separate READABLE_STRING_8): BOOLEAN
		do
			Result := not v.is_whitespace and then v[1] = '/'
		end

	set_port_number (a_port_number: INTEGER)
			-- Set port number to `a_port_number'.
		require
			a_port_number_positive_or_zero: a_port_number >= 0
		do
			set_port_on_configuration (a_port_number, configuration)
		end

	set_socket_recv_timeout (a_nb_seconds: INTEGER)
		require
			a_nb_seconds_positive_or_zero: a_nb_seconds >= 0
		do
			set_socket_recv_timeout_on_configuration (a_nb_seconds, configuration)
		end

	set_max_concurrent_connections (nb: INTEGER)
			-- Set maximum concurrent connections to `nb'.
		require
			nb_positive_or_zero: nb >= 0
		do
			set_max_concurrent_connections_on_configuration (nb, configuration)
		end

	set_is_verbose (b: BOOLEAN)
			-- Set verbose mode.
		do
			set_is_verbose_on_configuration (b, configuration)
		end

	set_is_secure (b: BOOLEAN)
			-- Set is_secure connection mode.
			-- i.e: using SSL.
		do
			set_is_secure_on_configuration (b, configuration)
		end

feature -- Server

	launch_on_port (a_port_number: INTEGER)
			-- Launch server listening on port `a_port_number'.
		do
			set_port_number (a_port_number)
			launch
		end

	launch
			-- Launch web server listening.
		do
			launched := False
			port := 0
			launch_server (server)
			on_server_started (observer)
		end

	shutdown_server
			-- Shutdown web server listening.
		do
			if launched then
					-- FIXME: prevent multiple calls (otherwise it hangs) [2015-03-27]
				separate_shutdown_server_on_controller (controller)
			end
		end

feature -- Events

	on_server_started (obs: like observer)
			-- Server started and listeing on port `obs.port'.
		require
			obs.started -- SCOOP wait condition.
		do
				-- FIXME: this works only with SCOOP concurrency mode. [2016-10-07]
			if obs.port > 0 then
				on_launched (obs.port)
			end
		end

feature {NONE} -- Implementation

	server_controller (a_server: like server): separate HTTPD_CONTROLLER
		do
			Result := a_server.controller
		end

	apply_configuration (a_configuration: like configuration)
		local
			v: BOOLEAN
		do
			v := a_configuration.is_verbose
			if v then
				if attached base as l_base and then not l_base.is_whitespace then
					io.error.put_string ("Base=" + l_base + "%N")
				end
			end
			update_factory (Current, request_handler_factory, a_configuration)
		end

	launch_server (a_server: like server)
		do
			apply_configuration (a_server.configuration)
			a_server.launch
		end

	separate_server_terminated (a_server: like server): BOOLEAN
		do
			Result := a_server.is_terminated
		end

	separate_shutdown_server_on_controller (a_controller: separate HTTPD_CONTROLLER)
		do
			a_controller.shutdown
		end

feature {NONE} -- Implementation: element change

	set_port_on_configuration (a_port_number: INTEGER; cfg: like configuration)
		do
			cfg.set_http_server_port (a_port_number)
		end

	set_socket_recv_timeout_on_configuration (a_nb_seconds: INTEGER; cfg: like configuration)
		do
			cfg.set_socket_recv_timeout (a_nb_seconds)
		end

	set_max_concurrent_connections_on_configuration (nb: INTEGER; cfg: like configuration)
		do
			cfg.set_max_concurrent_connections (nb)
		end

	set_is_verbose_on_configuration (b: BOOLEAN; cfg: like configuration)
		do
			cfg.set_is_verbose (b)
		end

	set_is_secure_on_configuration (b: BOOLEAN; cfg: like configuration)
		do
			cfg.set_is_secure (b)
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

