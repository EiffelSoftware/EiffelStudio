note
	description: "Constants for SSL/TLS protocols."
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=TLS", "src=http://en.wikipedia.org/wiki/Transport_Layer_Security", "protocol=uri"
	EIS: "name=SSL", "src=http://en.wikipedia.org/wiki/SSL", "protocol=uri"

class
	SSL_PROTOCOL

feature -- Access

	Ssl_23: NATURAL
        	-- Ssl version 3 but can rollback to version 2.
		obsolete "[
					Use. Use Tls_1_2 since Ssl_23 is not suported anymore [2017-12-01]."
					Use SSL3_VERSION instead of Ssl23, not supported anymore [2019-06-01] .
				]"
        do
            Result := SSL3_VERSION
        ensure
            instance_free: class
        end

	Tls_1_0: NATURAL
        obsolete "Use TLS1_VERSION,  Tls_1_0 is not supported anymore [2019-06-01]."
        do
            Result := TLS1_VERSION
        ensure
            instance_free: class
        end


	Tls_1_1: NATURAL
       	obsolete "Use TLS1_1_VERSION,  Tls_1_1 is not supported anymore [2019-06-01]."
       	do
            Result := TLS1_1_VERSION
        ensure
            instance_free: class
        end

	Tls_1_2: NATURAL
	   	obsolete "Use TLS1_2_VERSION,  Tls_1_2 is not supported anymore [2019-06-01]."
       	do
            Result := TLS1_2_VERSION
        ensure
            instance_free: class
        end


	Dtls_1_0: NATURAL
		-- Dtls version 1.0.
	   	obsolete "Use DTLS1_VERSION,  Dtls_1_0 is not supported anymore [2019-06-01]."
       	do
            Result := DTLS1_VERSION
        ensure
            instance_free: class
        end

	Tls_method: NATURAL = 7
		-- 	version-flexible SSL/TLS methods.
		--| The actual protocol version used will be negotiated to the highest version mutually supported by the client and the server.
		--| The supported protocols are SSLv3, TLSv1, TLSv1.1, TLSv1.2 and TLSv1.3.
		--| Applications should use these methods, and avoid the version-specific methods  	

feature -- Protocol Versions.

	SSL3_VERSION: NATURAL = 0x0300
		-- Defined in ssl3.h

	TLS1_VERSION: NATURAL = 0x0301
		-- Defined in tls1.h

	TLS1_1_VERSION: NATURAL = 0x0302
		-- Defined in tls1.h

	TLS1_2_VERSION: NATURAL = 0x0303
		-- Defined in tls1.h

	TLS1_3_VERSION: NATURAL = 0x0304
		-- Defined in tls1.h	

	DTLS1_VERSION: NATURAL = 0xFEFF
		-- Defined in dtls1.h 	

	DTLS1_2_VERSION: NATURAL = 0xFEFD
		-- Defined in dtls1.h 	


	is_valid_protocol  (a_version: NATURAL): BOOLEAN
			-- Is version `a_version' a valid protocol?
		do
			Result := 	a_version = 0 or else
						a_version = {SSL_PROTOCOL}.SSL3_VERSION or else
						a_version = {SSL_PROTOCOL}.TLS1_VERSION or else
						a_version = {SSL_PROTOCOL}.TLS1_1_VERSION or else
						a_version = {SSL_PROTOCOL}.TLS1_2_VERSION or else
						a_version = {SSL_PROTOCOL}.TLS1_3_VERSION or else
						a_version = {SSL_PROTOCOL}.DTLS1_VERSION or else
						a_version = {SSL_PROTOCOL}.DTLS1_2_VERSION
		ensure
			instance_free: class
		end

note
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
