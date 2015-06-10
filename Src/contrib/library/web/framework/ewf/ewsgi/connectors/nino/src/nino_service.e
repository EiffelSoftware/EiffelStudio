note
	description: "Summary description for {NINO_SERVICE}."
	date: "$Date$"
	revision: "$Revision$"

class
	NINO_SERVICE [G -> WGI_EXECUTION create make end]

create
	make,
	make_custom

feature {NONE} -- Implementation

	make
			-- Initialize `Current'.
		do
			make_custom (Void)
		end

	make_custom (a_base_url: detachable STRING)
			-- Initialize `Current'.
		require
			base_url_starts_with_slash: (a_base_url /= Void and then not a_base_url.is_empty) implies a_base_url.starts_with ("/")
		do
			create connector.make_with_base (a_base_url)
		end

feature -- Access

	connector: WGI_NINO_CONNECTOR [G]
			-- Web server connector

feature -- Status report

	launched: BOOLEAN
			-- Server launched?
		do
			Result := connector.launched
		end

	port: INTEGER
			-- Port listened
		do
			Result := connector.port
		end

feature -- Status settings

	configuration: HTTP_SERVER_CONFIGURATION
		do
			Result := connector.configuration
		end

	force_single_threaded
			-- Force single threaded behavior
		do
			configuration.force_single_threaded := True
		end

	set_is_verbose (b: BOOLEAN)
			-- Set verbose message behavior to `b'
		do
			configuration.set_is_verbose (b)
		end

	set_base_url (s: detachable READABLE_STRING_8)
			-- Set base_url to `s'
		do
			connector.set_base (s)
		end

feature -- Server

	listen (a_port: INTEGER)
		do
			configuration.http_server_port := a_port
			connector.launch
		end

	shutdown
			-- Shutdown the server
		do
			connector.server.shutdown_server
		end

note
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
