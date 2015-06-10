note
	description: "Summary description for {WGI_NINO_CONNECTOR}."
	date: "$Date$"
	revision: "$Revision$"

class
	WGI_NINO_CONNECTOR

inherit
	WGI_CONNECTOR

create
	make,
	make_with_base

feature {NONE} -- Initialization

	make (a_service: like service)
		local
			cfg: HTTP_SERVER_CONFIGURATION
		do
			service := a_service

			create cfg.make
			create server.make (cfg)

				-- Callbacks
			create on_launched_actions
			create on_stopped_actions
		end

	make_with_base (a_service: like service; a_base: like base)
		require
			a_base_starts_with_slash: (a_base /= Void and then not a_base.is_empty) implies a_base.starts_with ("/")
		do
			make (a_service)
			set_base (a_base)
		end

feature -- Access

	name: STRING_8 = "Nino"
			-- Name of Current connector

	version: STRING_8 = "0.1"
			-- Version of Current connector

feature {NONE} -- Access

	service: WGI_SERVICE
			-- Gateway Service		

feature -- Access

	server: HTTP_SERVER

	configuration: HTTP_SERVER_CONFIGURATION
		do
			Result := server.configuration
		end

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

	on_launched_actions: ACTION_SEQUENCE [TUPLE [WGI_CONNECTOR]]
			-- Actions triggered when launched

	on_stopped_actions: ACTION_SEQUENCE [TUPLE [WGI_CONNECTOR]]
			-- Actions triggered when stopped

feature -- Element change

	on_launched (a_port: INTEGER)
			-- Server launched
		do
			launched := True
			port := a_port
			on_launched_actions.call ([Current])
		end

	on_stopped
			-- Server stopped
		do
			on_stopped_actions.call ([Current])
			launched := False
			port := 0
		end

feature -- Element change

	set_base (b: like base)
		require
			b_starts_with_slash: (b /= Void and then not b.is_empty) implies b.starts_with ("/")
		do
			base := b
		ensure
			valid_base: (attached base as l_base and then not l_base.is_empty) implies l_base.starts_with ("/")
		end

feature -- Server

	launch
		local
			l_http_handler : HTTP_HANDLER
		do
			launched := False
			port := 0
			create {WGI_NINO_HANDLER} l_http_handler.make_with_callback (server, Current)
			if configuration.is_verbose then
				if attached base as l_base then
					io.error.put_string ("Base=" + l_base + "%N")
				end
			end
			server.setup (l_http_handler)
		end

	process_request (env: STRING_TABLE [READABLE_STRING_8]; a_headers_text: STRING; a_socket: TCP_STREAM_SOCKET)
		local
			req: WGI_REQUEST_FROM_TABLE
			res: detachable WGI_NINO_RESPONSE_STREAM
			retried: BOOLEAN
		do
			if not retried then
				create req.make (env, create {WGI_NINO_INPUT_STREAM}.make (a_socket), Current)
				create res.make (create {WGI_NINO_OUTPUT_STREAM}.make (a_socket), create {WGI_NINO_ERROR_STREAM}.make_stderr (a_socket.descriptor.out))
				req.set_meta_string_variable ("RAW_HEADER_DATA", a_headers_text)
				service.execute (req, res)
				res.push
			end
		rescue
			if not retried then
				retried := True
				retry
			end
		end

note
	copyright: "2011-2013, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
