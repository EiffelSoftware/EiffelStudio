note
	description:	"SSL enabled connection oriented socket"
	legal:			"See notice at end of class"
	status:			"See notice at end of class"
	date:			"$Date$"
	revision:		"$Revision$"

deferred class
	SSL_STREAM_SOCKET

inherit
	STREAM_SOCKET
		redefine
			accepted
		end

	SSL_PROTOCOL_SOCKET

feature

	accepted: detachable like Current;
			-- Last accepted SSL socket

feature -- SSL

	initialize_server_ssl (a_cert_file, a_key_file: detachable FILE_NAME)
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
				l_context.use_certificate_file (a_cert_file)
			end
			if a_key_file /= Void then
				l_context.use_private_key_file (a_key_file)
			end
			l_context.create_ssl

			if attached l_context.last_ssl as l_ssl then
				l_ssl.set_fd (descriptor)
				l_ssl.accept
			end
		end

feature {NONE} -- Attributes

	context: detachable SSL_CONTEXT;
			-- The SSL context in which this socket operates.

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
