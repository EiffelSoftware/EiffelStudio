note
	description: "[
			Summary description for {HTTPD_STREAM_SSL_SOCKET}
			that can be used for http or https connection.
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	HTTPD_STREAM_SSL_SOCKET

inherit
	HTTPD_STREAM_SOCKET
		redefine
			port,
			is_bound,
			ready_for_writing,
			ready_for_reading,
			try_ready_for_reading,
			put_readable_string_8
		end

create
	make_ssl_server_by_address_and_port, make_ssl_server_by_port,
	make_server_by_address_and_port, make_server_by_port

create {HTTPD_STREAM_SOCKET}
	make

feature {NONE} -- Initialization

	make_ssl_server_by_address_and_port (an_address: INET_ADDRESS; a_port: INTEGER; a_ssl_protocol: NATURAL; a_crt: STRING; a_key: STRING)
		local
			l_socket: SSL_TCP_STREAM_SOCKET
		do
			create l_socket.make_server_by_address_and_port (an_address, a_port)
			l_socket.set_tls_protocol (a_ssl_protocol)
			socket := l_socket
			set_certificates (a_crt, a_key)
		end

	make_ssl_server_by_port (a_port: INTEGER; a_ssl_protocol: NATURAL; a_crt: STRING; a_key: STRING)
		local
			l_socket: SSL_TCP_STREAM_SOCKET
		do
			create  l_socket.make_server_by_port (a_port)
			l_socket.set_tls_protocol (a_ssl_protocol)
			socket := l_socket
			set_certificates (a_crt, a_key)
		end

feature -- Output

	put_readable_string_8 (s: READABLE_STRING_8)
			-- <Precursor>
		do
			if attached {SSL_TCP_STREAM_SOCKET} socket as l_ssl_socket then
				l_ssl_socket.put_readable_string_8 (s)
			else
				Precursor (s)
			end
		end

feature -- Status Report

	port: INTEGER
			-- <Precursor>	
		do
			if attached {SSL_TCP_STREAM_SOCKET} socket as l_ssl_socket then
				Result := l_ssl_socket.port
			else
				Result := Precursor
			end
		end

	is_bound: BOOLEAN
			-- <Precursor>	
		do
			if attached {SSL_TCP_STREAM_SOCKET} socket as l_ssl_socket then
				Result := l_ssl_socket.is_bound
			else
				Result := Precursor
			end
		end

	ready_for_writing: BOOLEAN
			-- <Precursor>
		do
			if attached {SSL_TCP_STREAM_SOCKET} socket as l_ssl_socket then
				Result := l_ssl_socket.ready_for_writing
			else
				Result := Precursor
			end
		end

	ready_for_reading: BOOLEAN
			-- <Precursor>
		do
			if attached {SSL_TCP_STREAM_SOCKET} socket as l_ssl_socket then
				Result := l_ssl_socket.ready_for_reading
			else
				Result := Precursor
			end
		end

	try_ready_for_reading: BOOLEAN
		do
			if attached {SSL_TCP_STREAM_SOCKET} socket as l_socket then
				Result := l_socket.try_ready_for_reading
			else
				Result := Precursor
			end
		end

feature {HTTPD_STREAM_SOCKET} -- Implementation

	set_certificates (a_crt: STRING; a_key: STRING)
		local
			a_file_name: FILE_NAME
		do
			if attached {SSL_NETWORK_STREAM_SOCKET} socket as l_socket then
				create a_file_name.make_from_string (a_crt)
				l_socket.set_certificate_file_name (a_file_name)
				create a_file_name.make_from_string (a_key)
				l_socket.set_key_file_name (a_file_name)
			end
		end

note
	copyright: "2011-2014, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
