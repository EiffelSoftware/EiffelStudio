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
			if tls_protocol = {SSL_PROTOCOL}.ssl3_version then
				create l_context.make_as_sslv23_client
			elseif tls_protocol = {SSL_PROTOCOL}.tls1_version then
				create l_context.make_as_tlsv10_client
			elseif tls_protocol = {SSL_PROTOCOL}.tls1_1_version then
				create l_context.make_as_tlsv11_client
			elseif tls_protocol = {SSL_PROTOCOL}.dtls1_version then
				create l_context.make_as_dtlsv1_client
			elseif tls_protocol = {SSL_PROTOCOL}.TLS1_3_VERSION then
				create l_context.make_as_tls_client
			else
					--| By default tlsv1.2
				create l_context.make_as_tlsv12_client
			end

			context := l_context
			l_context.create_ssl

				-- Server name indication is only used by TLS protocol.
			if
				attached server_name as l_server_name and then (
				tls_protocol = {SSL_PROTOCOL}.tls1_version or else
				tls_protocol = {SSL_PROTOCOL}.tls1_1_version or else
				tls_protocol = {SSL_PROTOCOL}.tls1_2_version or else
				tls_protocol = {SSL_PROTOCOL}.tls1_3_version)
			then
				l_context.ssl_set_tlsext_host_name (l_server_name)
			end

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
			l_context := get_server_context
			context := l_context
			if a_cert_file /= Void then
				l_context.use_certificate_file (create {PATH}.make_from_separate (a_cert_file))
				set_certificate_file_path (create {PATH}.make_from_separate (a_cert_file))
			end
			if a_key_file /= Void then
				l_context.use_private_key_file (create {PATH}.make_from_separate (a_key_file))
				set_key_file_path (create {PATH}.make_from_separate (a_key_file))
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

	initialize_server_ssl_with_string (a_certificate_x509_string, a_private_rsa_key_string : detachable separate IMMUTABLE_STRING_8)
			-- Initialize the server SSL stuff for an accepted socket with manifest strings certificate and key.
		local
			l_context: like context
		do
			l_context := get_server_context
			context := l_context

			if a_certificate_x509_string /= Void then
				l_context.use_certificate (create {STRING}.make_from_separate (a_certificate_x509_string))
				set_certificate_x509_string (create {STRING}.make_from_separate (a_certificate_x509_string))
			end
			if a_private_rsa_key_string /= Void then
				l_context.use_private_key(create {STRING}.make_from_separate (a_private_rsa_key_string))
				set_private_rsa_key_string (create {STRING}.make_from_separate (a_private_rsa_key_string))
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

	server_context, get_server_context: SSL_CONTEXT
			--Server SSL context.
		do
			inspect tls_protocol
			when {SSL_PROTOCOL}.ssl3_version  then
				create Result.make_as_sslv23_server
			when {SSL_PROTOCOL}.tls1_version then
				create Result.make_as_tlsv10_server
			when {SSL_PROTOCOL}.tls1_1_version then
				create Result.make_as_tlsv11_server
			when {SSL_PROTOCOL}.dtls1_2_version then
				create Result.make_as_dtlsv1_server
			when {SSL_PROTOCOL}.tls1_3_version then
				create Result.make_as_tls_server
			else
					--| By default tlsv1.2
				create Result.make_as_tlsv12_server
			end
		end

	set_options (a_options: INTEGER_64)
			-- adds the options `a_options' set via bitmask in options to ctx.
			-- Options already set before are not cleared!
		note
			EIS: "name=CTX_set_options", "src=https://www.openssl.org/docs/man1.1.0/ssl/SSL_CTX_set_options.html", "protocol=uri"
		do
			if attached context as l_context then
				l_context.set_options (a_options)
			end
		end

	clear_options (a_options: INTEGER_64)
			-- clears the options `a_options' set via bitmask in options to ctx.
		note
			EIS: "name=CTX_set_options", "src=https://www.openssl.org/docs/man1.1.0/ssl/SSL_CTX_set_options.html", "protocol=uri"
		do
			if attached context as l_context then
				l_context.clear_options (a_options)
			end
		end

	set_max_protocol_version (a_version: NATURAL)
			-- Set the maximun version to `a_version'.
			-- If the version is 0, will enable protocol versions up to the highest version supported by the library.
			--| Currently supported versions are SSL3_VERSION, TLS1_VERSION, TLS1_1_VERSION, TLS1_2_VERSION, TLS1_3_VERSION for TLS and DTLS1_VERSION, DTLS1_2_VERSION for DTLS.
		require
			is_valid_version: {SSL_PROTOCOL}.is_valid_protocol (a_version)
		do
			if attached context as l_context then
				l_context.set_max_proto_version (a_version)
			end
		end

	set_min_protocol_version (a_version: NATURAL)
			-- Set the minimum version to `a_version'.
			-- If the version is 0, will enable protocol versions down to the lowest version supported by the library.
			--| Currently supported versions are SSL3_VERSION, TLS1_VERSION, TLS1_1_VERSION, TLS1_2_VERSION, TLS1_3_VERSION for TLS and DTLS1_VERSION, DTLS1_2_VERSION for DTLS.
		require
			is_valid_version: {SSL_PROTOCOL}.is_valid_protocol (a_version)
		do
			if attached context as l_context then
				l_context.set_min_proto_version (a_version)
			end
		end

feature -- Status report		

	error_number: INTEGER
			-- <Precursor>
		do
			if
				attached context as l_context and then
				attached l_context.last_ssl as l_ssl and then
				l_ssl.was_error
			then
				Result := l_ssl.ssl_error_number
			end
		end

	max_proto_version: NATURAL
			-- Configured version or 0 for auto-configuration of highest protocol.
		do
			if attached context as l_context then
				Result := l_context.max_proto_version
			end
		end

	min_proto_version: NATURAL
			-- Configured version or 0 for auto-configuration of lowest protocol.
		do
			if attached context as l_context then
				Result := l_context.min_proto_version
			end
		end

	protocol_version: INTEGER
			-- protocol version used for the connection.
		do
			if
				attached context as l_context and then
				attached l_context.last_ssl as l_ssl and then
				not l_ssl.was_error
			then
				Result := l_context.version
			end
		end

feature -- Access

	certificate_x509_string: detachable IMMUTABLE_STRING_8
			-- X09 certificate manifest string.

	private_rsa_key_string: detachable IMMUTABLE_STRING_8
			-- rsa key manifest string.

	certificate_file_path: detachable PATH
			-- File location of certificate.

	key_file_path: detachable PATH
			-- File location of private key.

	certificate_file_name: detachable FILE_NAME
			-- Name of the file that holds the certificate.
		obsolete
			"Use certificate_file_path [2015-mar-31]"
		do
			if attached certificate_file_path as p then
				create Result.make_from_string (p.utf_8_name)
			end
		end

	key_file_name: detachable FILE_NAME
			-- Name of the file that holds the private key.
		obsolete
			"Use key_file_path [2015-mar-31]"
		do
			if attached key_file_path as p then
				create Result.make_from_string (p.utf_8_name)
			end
		end

feature -- Change Element

	unset_certificate_x509_string
			-- Unset `certificate_x509_string'.
		do
			certificate_x509_string := Void
		end

	set_certificate_x509_string (a_x509: STRING_8)
			-- X09 certificate manifest string.
		do
			certificate_x509_string := a_x509
		ensure
			certificate_x509_string_set: attached certificate_x509_string as l_509 implies l_509.same_string (a_x509)
		end

	unset_private_rsa_key_string
			-- Unset `private_rsa_key_string'.
		do
			private_rsa_key_string := Void
		end

	set_private_rsa_key_string ( a_rsa_key: STRING_8)
			-- rsa key manifest string.
		do
			private_rsa_key_string := a_rsa_key
		ensure
			private_rsa_key_string_set: attached private_rsa_key_string as l_rsa_key implies l_rsa_key.same_string (a_rsa_key)
		end

	unset_certificate_file
		do
			certificate_file_path := Void
		end

	set_certificate_file_path (a_path: PATH)
			-- Set `certificate_file_path' to `a_path'
		do
			certificate_file_path := a_path
		end

	unset_key_file
		do
			key_file_path := Void
		end

	set_key_file_path (a_path: PATH)
			-- Set `key_file_path' to `a_path'
		do
			key_file_path := a_path
		end

	set_certificate_file_name (a_file_name: READABLE_STRING_GENERAL)
			-- Set `certificate_file_name' to `a_file_name'
		do
			set_certificate_file_path (create {PATH}.make_from_string (a_file_name))
		end

	set_key_file_name (a_file_name: READABLE_STRING_GENERAL)
			-- Set `key_file_name' to `a_file_name'
		do
			set_key_file_path (create {PATH}.make_from_string (a_file_name))
		end

feature -- Client Server Name Indication

	set_tls_server_name_indication (a_server_name: READABLE_STRING_GENERAL)
		note
			EIS:"name=Server Name Indication", "src=https://en.wikipedia.org/wiki/Server_Name_Indication", "protocol=uri"
		do
			server_name := a_server_name
		ensure
			server_name_set: attached server_name as l_server_name implies l_server_name.same_string (a_server_name)
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

	server_name: detachable READABLE_STRING_GENERAL
			-- The name of the hostname used by TLS extension.		

;note
	copyright: "Copyright (c) 1984-2018, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
