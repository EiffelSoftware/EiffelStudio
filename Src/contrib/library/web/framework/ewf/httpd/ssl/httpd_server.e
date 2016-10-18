note
	description: "[
			SECURE enabled server
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
		local
			s_secure: HTTPD_STREAM_SECURE_SOCKET
		do
			if configuration.is_secure then
				if a_addr /= Void then
					create s_secure.make_server_by_address_and_port (a_addr, a_http_port)
					Result := s_secure
				else
					create s_secure.make_server_by_port (a_http_port)
				end
				s_secure.set_tls_protocol (configuration.secure_protocol)
				if attached configuration.secure_certificate as l_crt then
					s_secure.set_certificate_file_name (l_crt)
				end
				if attached configuration.secure_certificate_key as l_key then
					s_secure.set_key_file_name (l_key)
				end

				Result := s_secure
			else
				Result := Precursor (a_addr, a_http_port)
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
