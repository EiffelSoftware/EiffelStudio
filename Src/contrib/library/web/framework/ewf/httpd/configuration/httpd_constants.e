note
	description: "[
			Various constant values used in httpd settings.
		]"
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	HTTPD_CONSTANTS

inherit
	HTTP_SECURE_HELPER

feature -- Default connection settings

	default_http_server_port: INTEGER = 80
	default_max_concurrent_connections: INTEGER = 100
	default_max_tcp_clients: INTEGER = 100

feature -- Default timeout settings

	default_socket_timeout: INTEGER = 60 -- seconds
	default_socket_recv_timeout: INTEGER = 5 -- seconds

feature -- Default persistent connection settings

	default_keep_alive_timeout: INTEGER = 5 -- seconds
	default_max_keep_alive_requests: INTEGER = 300

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
