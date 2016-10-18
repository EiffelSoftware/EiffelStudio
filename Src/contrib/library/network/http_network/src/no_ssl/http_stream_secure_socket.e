note
	description: "[
			A fake SSL network stream socket... when SSL is disabled at compilation time.
			Its behavior is similar to HTTP_STREAM_SOCKET.
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	HTTP_STREAM_SECURE_SOCKET

inherit
	HTTP_STREAM_SOCKET

create
	make, make_empty,
	make_client_by_port, make_client_by_address_and_port,
	make_server_by_port, make_server_by_address_and_port, make_loopback_server_by_port

create {HTTP_STREAM_SECURE_SOCKET}
	make_from_descriptor_and_address

feature -- Element change	

	set_certificate_file_path (a_crt_filename: PATH)
		do
		end

	set_key_file_path (a_key_filename: PATH)
		do
		end
feature -- SSL Helpers

	set_secure_protocol (v: NATURAL)
		do
		end

	set_secure_protocol_to_ssl_2_or_3
			-- Set `ssl_protocol' with `Ssl_23'.
		do
		end

	set_secure_protocol_to_tls_1_0
			-- Set `ssl_protocol' with `Tls_1_0'.
		do
		end

	set_secure_protocol_to_tls_1_1
			-- Set `ssl_protocol' with `Tls_1_1'.
		do
		end

	set_secure_protocol_to_tls_1_2
			-- Set `ssl_protocol' with `Tls_1_2'.
		do
		end

	set_secure_protocol_to_dtls_1_0
			-- Set `ssl_protocol' with `Dtls_1_0'.
		do
		end

invariant
	secure_connection_not_supported: not is_secure_connection_supported -- Current is a Fake SSL interface!
note
	copyright: "2011-2013, Javier Velilla, Jocelyn Fiat and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"

end
