note
	description: "Summary description for {HTTP_CLIENT_SECURE_CONFIG}."
	date: "$Date$"
	revision: "$Revision$"

class
	HTTP_CLIENT_SECURE_CONFIG

feature -- Access

	verify_peer: BOOLEAN
			-- Verify the peer's SSL certificate.
			-- If the verification fails to prove that the certificate is authentic, the connection fails.
			-- by default is disabled. call enable_verify_peer.

	verify_host: BOOLEAN
			-- Verify the certificate's name against host.
			-- Checks the server's certificate's claimed identity.
			-- by default is disabled. call enable_verify_host.

	certificate_type: detachable STRING
			--  specify type of the client SSL certificate.
			--  PEM, DER, P12
			--| LibCurl: Supported formats are "PEM" and "DER", except with Secure Transport.
			--|			 OpenSSL (versions 0.9.3 and later) and Secure Transport (on iOS 5 or later, or OS X 10.7 or later) also support "P12" for PKCS#12-encoded files.
			--|			 https://curl.haxx.se/libcurl/c/CURLOPT_SSLCERTTYPE.html

	client_certificate: detachable STRING_32
			-- specify the certificate for client authentication.

	passphrase: detachable STRING_32
			-- password required for a private key.		

	certificate_authority: detachable STRING_32
			--  path to Certificate Authority (CA) bundle.

	tls_version: INTEGER
			-- TLS version 1.2 or 1.3		

feature -- Change Element

	enable_verify_host
			--Enable verify the certificate's name against host.
		do
			verify_host := True
		ensure
			verify_host_set: verify_host = True
		end

	enable_verify_peer
			-- Enable verify the certificate's name against host.
		do
			verify_peer := True
		ensure
			verify_peer_set: verify_peer = True
		end

	set_certificate_type (a_cert: STRING)
			-- Set type of the client SSL certificate (PEM, P12) `certificate_type` with `a_cert`.
			--| TODO add a precondition to verify the type of the certificate.
		note
			eis:"name=certificates formats", "src=https://www.ssls.com/knowledgebase/what-are-certificate-formats-and-what-is-the-difference-between-them/", "protocol=uri"
		require
			is_valid_certificate_type: certificates_formats.has (a_cert.as_lower)
		do
			certificate_type := a_cert
		ensure
			certificate_type_set: certificate_type = a_cert
		end

	set_client_certificate (a_client_certificate: STRING_32)
			-- Set path to client certificate `client_certificate` with `a_client_certificate` for authentication.
		do
			client_certificate := a_client_certificate
		ensure
			client_certificate_set: client_certificate = a_client_certificate
		end

	set_passphrase (a_password: STRING_32)
			-- Set the passphrase `passphrase` with `a_password`, if the private key required it.
		do
			passphrase := a_password
		ensure
			passphrase_set: passphrase = a_password
		end

	set_certificate_authority (a_certificate: STRING_32)
			--  set path to Certificate Authority `certificate_authority` with `a_certificate`.
		do
			certificate_authority := a_certificate
		ensure
			certificate_authority_set: certificate_authority = a_certificate
		end

	set_tls_version (a_version: INTEGER)
			--  set preferred TLS/SSL version `tls_version` with `a_version`
		require
			valid_tls_version: is_valid_tls_verion (a_version)
		do
			tls_version := a_version
		ensure
			tls_version_set: tls_version = a_version
		end

feature -- Certificates Types

	certificates_formats: SET [STRING]
		note
			eis:"name=certificates formats", "src=https://www.ssls.com/knowledgebase/what-are-certificate-formats-and-what-is-the-difference-between-them/", "protocol=uri"
		do
			create {ARRAYED_SET [STRING]} Result.make (9)
				-- Base64
				-- PEM
			Result.put ("pem")
			Result.put ("crt")
			Result.put ("ca-bundle")
				--PKCS#7
			Result.put ("p7b")
			Result.put ("p7s")
				-- Binary
				-- DER
			Result.put ("der")
			Result.put ("cer")
				--PKCS#12
			Result.put ("pfx")
			Result.put ("p12")
			Result.compare_objects
		ensure
			is_class: class
		end

feature -- TLS versions

	tls_1_2: INTEGER = 2

	tls_1_3: INTEGER = 3

	is_valid_tls_verion (a_version: INTEGER): BOOLEAN
			-- Is `a_version` a valid and supported TLS version?
		do
			Result := a_version = tls_1_2 or a_version = tls_1_3
		end

	is_tls_1_2: BOOLEAN
		do
			Result := tls_version = tls_1_2
		end

	is_tls_1_3: BOOLEAN
		do
			Result := tls_version = tls_1_3
		end

feature -- Reset

	reset
			-- Clear config.
		do
			verify_host := False
			verify_peer := False
			certificate_type := Void
			client_certificate := Void
			passphrase := Void
		end

note
	copyright: "2011-2019, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
