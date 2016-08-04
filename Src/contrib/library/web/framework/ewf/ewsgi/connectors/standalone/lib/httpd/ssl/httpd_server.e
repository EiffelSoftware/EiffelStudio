note
	description: "[
			SSL enabled server
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	HTTPD_SERVER

inherit
	HTTPD_SERVER_I
		redefine
			new_listening_socket
		end

create
	make

feature {NONE} -- Factory

	new_listening_socket (a_addr: detachable INET_ADDRESS; a_http_port: INTEGER): HTTPD_STREAM_SOCKET
		do
			if configuration.is_secure then
				if a_addr /= Void then
					create {HTTPD_STREAM_SSL_SOCKET} Result.make_ssl_server_by_address_and_port (a_addr, a_http_port, configuration.ssl_protocol, configuration.ca_crt, configuration.ca_key)
				else
					create {HTTPD_STREAM_SSL_SOCKET} Result.make_ssl_server_by_port (a_http_port, configuration.ssl_protocol, configuration.ca_crt, configuration.ca_key)
				end
			else
				Result := Precursor (a_addr, a_http_port)
			end
		end

end
