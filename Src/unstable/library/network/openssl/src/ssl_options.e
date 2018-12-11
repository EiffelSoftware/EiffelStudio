note
	description: "[
			The behaviour of the SSL library can be changed by setting several options. 
			The options are coded as bitmasks and can be combined by a bitwise or operation (|).

			SSL_CTX_set_options() and SSL_set_options() affect the (external) protocol behaviour of the SSL library.
			The (internal) behaviour of the API can be changed by using the similar SSL_CTX_set_mode and SSL_set_mode() functions.

			During a handshake, the option settings of the SSL object are used.
			When a new SSL object is created from a context using SSL_new(), the current option setting is copied.
			Changes to ctx do not affect already created SSL objects. SSL_clear() does not affect the settings.
			
			It is usually safe to use SSL_OP_ALL to enable the bug workaround options if compatibility with somewhat broken implementations is desired.
			
		]"
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=SSL_OPTIONS", "src=https://www.openssl.org/docs/man1.1.0/ssl/SSL_CTX_set_options.html", "protocol=uri"
class
	SSL_OPTIONS

feature -- Access

	is_valid_option (a_option: INTEGER): BOOLEAN
			-- Is the option `a_option' a valid options?
		do
			Result := 	a_option = SSL_OP_SSLREF2_REUSE_CERT_TYPE_BUG or else
						a_option = SSL_OP_MICROSOFT_BIG_SSLV3_BUFFER or else
						a_option = SSL_OP_SAFARI_ECDHE_ECDSA_BUG or else
						a_option = SSL_OP_SSLEAY_080_CLIENT_DH_BUG or else
						a_option = SSL_OP_TLS_D5_BUG or else
						a_option = SSL_OP_DONT_INSERT_EMPTY_FRAGMENTS or else
						a_option = SSL_OP_TLSEXT_PADDING or else
						a_option = SSL_OP_ALL or else
						a_option = SSL_OP_TLS_ROLLBACK_BUG or else
						a_option = SSL_OP_SINGLE_DH_USE or else
						a_option = SSL_OP_CIPHER_SERVER_PREFERENCE or else
						a_option = SSL_OP_PKCS1_CHECK_1 or else
						a_option = SSL_OP_PKCS1_CHECK_2 or else
						a_option = SSL_OP_NO_SESSION_RESUMPTION_ON_RENEGOTIATION or else
						a_option = SSL_OP_NO_TICKET or else
						a_option = SSL_OP_ALLOW_UNSAFE_LEGACY_RENEGOTIATION or else
						a_option = SSL_OP_LEGACY_SERVER_CONNECT or else
						a_option = SSL_OP_NO_ENCRYPT_THEN_MAC or else
						a_option = SSL_OP_NO_RENEGOTIATION
		end


feature -- Bug workaround options

	SSL_OP_SSLREF2_REUSE_CERT_TYPE_BUG : INTEGER
		external
			"C inline use %"eif_openssl.h%""
		alias
			"SSL_OP_SSLREF2_REUSE_CERT_TYPE_BUG"
		end


	SSL_OP_MICROSOFT_BIG_SSLV3_BUFFER: INTEGER
		external
			"C inline use %"eif_openssl.h%""
		alias
			"SSL_OP_MICROSOFT_BIG_SSLV3_BUFFER"
		end

	SSL_OP_SAFARI_ECDHE_ECDSA_BUG: INTEGER
			-- Don't prefer ECDHE-ECDSA ciphers when the client appears to be Safari on OS X. OS X 10.8..10.8.3 has broken support for ECDHE-ECDSA ciphers.
		external
			"C inline use %"eif_openssl.h%""
		alias
			"SSL_OP_SAFARI_ECDHE_ECDSA_BUG"
		end

	SSL_OP_SSLEAY_080_CLIENT_DH_BUG: INTEGER
		external
			"C inline use %"eif_openssl.h%""
		alias
			"SSL_OP_SSLEAY_080_CLIENT_DH_BUG"
		end

	SSL_OP_TLS_D5_BUG: INTEGER
		external
			"C inline use %"eif_openssl.h%""
		alias
			"SSL_OP_TLS_D5_BUG"
		end

	SSL_OP_DONT_INSERT_EMPTY_FRAGMENTS: INTEGER
			-- Disables a countermeasure against a SSL 3.0/TLS 1.0 protocol vulnerability affecting CBC ciphers,
			-- which cannot be handled by some broken SSL implementations. This option has no effect for connections using other ciphers.
		external
			"C inline use %"eif_openssl.h%""
		alias
			"SSL_OP_DONT_INSERT_EMPTY_FRAGMENTS"
		end

	SSL_OP_TLSEXT_PADDING: INTEGER
			-- Adds a padding extension to ensure the ClientHello size is never between 256 and 511 bytes in length. This is needed as a workaround for some implementations.
		external
			"C inline use %"eif_openssl.h%""
		alias
			"SSL_OP_TLSEXT_PADDING"
		end

	SSL_OP_ALL: INTEGER
			-- All of the above bug workarounds.
		external
			"C inline use %"eif_openssl.h%""
		alias
			"SSL_OP_ALL"
		end

feature -- Modifying Options

	SSL_OP_TLS_ROLLBACK_BUG: INTEGER
			-- Disable version rollback attack detection.
			-- During the client key exchange, the client must send the same information about acceptable SSL/TLS protocol levels as during the first hello.
			-- Some clients violate this rule by adapting to the server's answer.
			-- (Example: the client sends a SSLv2 hello and accepts up to SSLv3.1=TLSv1, the server only understands up to SSLv3.
			-- In this case the client must still use the same SSLv3.1=TLSv1 announcement. Some clients step down to SSLv3 with respect to the server's answer and violate the version rollback protection.)
		external
			"C inline use %"eif_openssl.h%""
		alias
			"SSL_OP_TLS_ROLLBACK_BUG"
		end

	SSL_OP_SINGLE_DH_USE: INTEGER
			-- Always create a new key when using temporary/ephemeral DH parameters (see SSL_CTX_set_tmp_dh_callback).
			-- This option must be used to prevent small subgroup attacks, when the DH parameters were not generated using "strong" primes
			-- (e.g. when using DSA-parameters, see dhparam). If "strong" primes were used, it is not strictly necessary to generate a new DH key during each handshake but it is also recommended.
			-- SSL_OP_SINGLE_DH_USE should therefore be enabled whenever temporary/ephemeral DH parameters are used.
		external
			"C inline use %"eif_openssl.h%""
		alias
			"SSL_OP_SINGLE_DH_USE"
		end

	SSL_OP_CIPHER_SERVER_PREFERENCE: INTEGER
			-- When choosing a cipher, use the server's preferences instead of the client preferences.
			-- When not set, the SSL server will always follow the clients preferences. When set, the SSL/TLS server will choose following its own preferences.
		external
			"C inline use %"eif_openssl.h%""
		alias
			"SSL_OP_CIPHER_SERVER_PREFERENCE"
		end

	SSL_OP_PKCS1_CHECK_1: INTEGER
		external
			"C inline use %"eif_openssl.h%""
		alias
			"SSL_OP_PKCS1_CHECK_1"
		end

	SSL_OP_PKCS1_CHECK_2: INTEGER
		external
			"C inline use %"eif_openssl.h%""
		alias
			"SSL_OP_PKCS1_CHECK_1"
		end

	SSL_OP_NO_SESSION_RESUMPTION_ON_RENEGOTIATION: INTEGER
			-- When performing renegotiation as a server, always start a new session
			-- i.e., session resumption requests are only accepted in the initial handshake). This option is not needed for clients.
		external
			"C inline use %"eif_openssl.h%""
		alias
			"SSL_OP_NO_SESSION_RESUMPTION_ON_RENEGOTIATION"
		end

	SSL_OP_NO_TICKET: INTEGER
			-- Normally clients and servers will, where possible, transparently make use of RFC4507bis tickets for stateless session resumption.
			-- If this option is set this functionality is disabled and tickets will not be used by clients or servers.
		external
			"C inline use %"eif_openssl.h%""
		alias
			"SSL_OP_NO_TICKET"
		end

	SSL_OP_ALLOW_UNSAFE_LEGACY_RENEGOTIATION: INTEGER
			-- Allow legacy insecure renegotiation between OpenSSL and unpatched clients or servers. See the SECURE RENEGOTIATION section for more details.
		external
			"C inline use %"eif_openssl.h%""
		alias
			"SSL_OP_ALLOW_UNSAFE_LEGACY_RENEGOTIATION"
		end

	SSL_OP_LEGACY_SERVER_CONNECT: INTEGER
		-- Allow legacy insecure renegotiation between OpenSSL and unpatched servers only: this option is currently set by default. See the SECURE RENEGOTIATION section for more details.
		external
			"C inline use %"eif_openssl.h%""
		alias
			"SSL_OP_LEGACY_SERVER_CONNECT"
		end

	SSL_OP_NO_ENCRYPT_THEN_MAC: INTEGER
			-- Normally clients and servers will transparently attempt to negotiate the RFC7366 Encrypt-then-MAC option on TLS and DTLS connection.
			-- If this option is set, Encrypt-then-MAC is disabled. Clients will not propose, and servers will not accept the extension.
		external
			"C inline use %"eif_openssl.h%""
		alias
			"SSL_OP_NO_ENCRYPT_THEN_MAC"
		end

	SSL_OP_NO_RENEGOTIATION: INTEGER
			-- Disable all renegotiation in TLSv1.2 and earlier. Do not send HelloRequest messages, and ignore renegotiation requests via ClientHello.
		external
			"C inline use %"eif_openssl.h%""
		alias
			"SSL_OP_NO_RENEGOTIATION"
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
