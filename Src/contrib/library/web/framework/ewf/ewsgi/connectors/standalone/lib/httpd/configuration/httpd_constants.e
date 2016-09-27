note
	description: "[
			Various constant values used in httpd settings.
		]"
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	HTTPD_CONSTANTS

feature -- Default connection settings

	default_http_server_port: INTEGER = 80
	default_max_concurrent_connections: INTEGER = 100
	default_max_tcp_clients: INTEGER = 100

feature -- Default timeout settings

	default_socket_timeout: INTEGER = 60 -- seconds
	default_socket_recv_timeout: INTEGER = 5 -- seconds

feature -- Default persistent connection settings

	default_keep_alive_timeout: INTEGER = 15 -- seconds
	default_max_keep_alive_requests: INTEGER = 100

end
