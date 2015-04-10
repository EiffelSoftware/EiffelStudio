note
	description: "Generic SSL sockets"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	SSL_SOCKET

inherit
	SOCKET
		redefine
			error_number
		end

	SSL_PROTOCOL_SOCKET

feature -- SSL

	initialize_client_ssl
			-- Initialize the client SSL stuff for socket.
		local
			l_context: like context
		do
			if tls_protocol = {SSL_PROTOCOL}.ssl_23 then
				create l_context.make_as_sslv23_client
			elseif tls_protocol = {SSL_PROTOCOL}.ssl_3 then
				create l_context.make_as_sslv3_client
			elseif tls_protocol = {SSL_PROTOCOL}.tls_1_0 then
				create l_context.make_as_tlsv10_client
			elseif tls_protocol = {SSL_PROTOCOL}.tls_1_1 then
				create l_context.make_as_tlsv11_client
			elseif tls_protocol = {SSL_PROTOCOL}.dtls_1_0 then
				create l_context.make_as_dtlsv1_client
			else
					--| By default tlsv1.2
				create l_context.make_as_tlsv12_client
			end

			context := l_context
			l_context.create_ssl

			if attached l_context.last_ssl as l_ssl then
				l_ssl.set_fd (descriptor)
				l_ssl.connect
				if not l_ssl.connected then
					close_socket
				end
			else
				close_socket
			end
		end

	initialize_server_ssl (a_cert_file, a_key_file: detachable separate PATH)
			-- Initialize the server SSL stuff for an accepted socket.
		local
			l_context: like context
		do
			if tls_protocol = {SSL_PROTOCOL}.ssl_23 then
				create l_context.make_as_sslv23_server
			elseif tls_protocol = {SSL_PROTOCOL}.ssl_3 then
				create l_context.make_as_sslv3_server
			elseif tls_protocol = {SSL_PROTOCOL}.tls_1_0 then
				create l_context.make_as_tlsv10_server
			elseif tls_protocol = {SSL_PROTOCOL}.tls_1_1 then
				create l_context.make_as_tlsv11_server
			elseif tls_protocol = {SSL_PROTOCOL}.dtls_1_0 then
				create l_context.make_as_dtlsv1_server
			else
					--| By default tlsv1.2
				create l_context.make_as_tlsv12_server
			end

			context := l_context
			if a_cert_file /= Void then
				l_context.use_certificate_file (create {PATH}.make_from_separate (a_cert_file))
			end
			if a_key_file /= Void then
				l_context.use_private_key_file (create {PATH}.make_from_separate (a_key_file))
			end
			l_context.create_ssl

			if attached l_context.last_ssl as l_ssl then
				l_ssl.set_fd (descriptor)
				l_ssl.accept
				if l_ssl.was_error then
					socket_error := l_ssl.ssl_error
				end				
			end
		end

feature -- Status report		

	error_number: INTEGER
			-- <Precursor>
		do
			if 
				attached context as l_context and then 
				attached l_context.last_ssl as l_ssl 
			then
				Result := l_ssl.ssl_error_number
			end
		end			

feature {NONE} -- Implementation

	shutdown
			-- Send SSL/TLS close_notify
		do
			if
				attached context as l_context and then
				attached l_context.last_ssl as l_ssl
			then
				l_ssl.shutdown
			end
		end

feature {NONE} -- Attributes

	context: detachable SSL_CONTEXT;
			-- The SSL structure used in the SSL/TLS communication	

note
	copyright: "Copyright (c) 1984-2015, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
