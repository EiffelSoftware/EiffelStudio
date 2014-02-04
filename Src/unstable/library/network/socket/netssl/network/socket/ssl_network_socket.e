note
	description:	"SSL enabled network socket"
	legal:			"See notice at end of class"
	status:			"See notice at end of class"
	date:			"$Date$"
	revision:		"$Revision$"

deferred class
	SSL_NETWORK_SOCKET

inherit
	NETWORK_SOCKET
		redefine
			connect, shutdown
		end

	SSL_PROTOCOL_SOCKET

feature

	connect
			-- Connect the socket, and setup the SSL context
		local
			l_context: like context
		do
				--| Connect the socket, from NETWORK_SOCKET
			Precursor

			if is_connected then
					--| The NETWORK_SOCKET is connected, we can setup the SSL context

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
					l_ssl.set_fd (fd)
					l_ssl.connect
					if not l_ssl.connected then
						close_socket
					end
				else
					close_socket
				end
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
	copyright:	"Copyright (c) 1984-2013, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source:		"[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
