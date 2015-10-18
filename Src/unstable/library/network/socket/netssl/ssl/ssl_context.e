note
	description: "SSL context"
	legal: "See notice at end of class"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	SSL_CONTEXT

inherit

	SSL_SHARED

create
	make_as_sslv23_client,
	make_as_sslv23_server,
	make_as_sslv3_client,
	make_as_sslv3_server,
	make_as_tlsv10_client,
	make_as_tlsv10_server,
	make_as_tlsv11_client,
	make_as_tlsv11_server,
	make_as_tlsv12_client,
	make_as_tlsv12_server,
	make_as_dtlsv1_client,
	make_as_dtlsv1_server,
	make_from_context_pointer

feature {NONE} -- Initialization

	make_as_sslv23_client
			-- Make an SSLv2 and SSLv3 capable client context.
		local
			method_pointer: POINTER
		do
				--| Initialize SSL, as this may be one of the entry points into SSL where it is
				--| useful to initialize the SSL Library
			initialize_ssl
			method_pointer := c_sslv23_client_method
			ctx := c_ssl_ctx_new (method_pointer)
		end

	make_as_sslv3_client
			-- Make an SSLv3 capable client context.
		local
			method_pointer: POINTER
		do
				--| Initialize SSL, as this may be one of the entry points into SSL where it is
				--| useful to initialize the SSL Library
			initialize_ssl
			method_pointer := c_sslv3_client_method
			ctx := c_ssl_ctx_new (method_pointer)
		end

	make_as_tlsv10_client
			-- Make an TLSv1 capable client context.
		local
			method_pointer: POINTER
		do
				--| Initialize SSL, as this may be one of the entry points into SSL where it is
				--| useful to initialize the SSL Library
			initialize_ssl
			method_pointer := c_tlsv10_client_method
			ctx := c_ssl_ctx_new (method_pointer)
		end

	make_as_tlsv11_client
			-- Make an TLSv1_1 capable client context.
		local
			method_pointer: POINTER
		do
				--| Initialize SSL, as this may be one of the entry points into SSL where it is
				--| useful to initialize the SSL Library
			initialize_ssl
			method_pointer := c_tlsv11_client_method
			ctx := c_ssl_ctx_new (method_pointer)
		end

	make_as_dtlsv1_client
			-- Make an DTLSv1 capable client context.
		local
			method_pointer: POINTER
		do
				--| Initialize SSL, as this may be one of the entry points into SSL where it is
				--| useful to initialize the SSL Library
			initialize_ssl
			method_pointer := c_dtlsv1_client_method
			ctx := c_ssl_ctx_new (method_pointer)
		end

	make_as_tlsv12_client
			-- Make an DTLSv1 capable client context.
		local
			method_pointer: POINTER
		do
				--| Initialize SSL, as this may be one of the entry points into SSL where it is
				--| useful to initialize the SSL Library
			initialize_ssl
			method_pointer := c_tlsv12_client_method
			ctx := c_ssl_ctx_new (method_pointer)
		end

	make_as_sslv23_server
			-- Make an SSLv2 and SSLv3 capable server context.
		local
			method_pointer: POINTER
		do
				--| Initialize SSL, as this may be one of the entry points into SSL where it is
				--| useful to initialize the SSL Library
			initialize_ssl
			method_pointer := c_sslv23_server_method
			ctx := c_ssl_ctx_new (method_pointer)
		end

	make_as_sslv3_server
			-- Make an SSLv3 capable server context.
		local
			method_pointer: POINTER
		do
				--| Initialize SSL, as this may be one of the entry points into SSL where it is
				--| useful to initialize the SSL Library
			initialize_ssl
			method_pointer := c_sslv3_server_method
			ctx := c_ssl_ctx_new (method_pointer)
		end

	make_as_tlsv10_server
			-- Make an TLSv1 capable server context.
		local
			method_pointer: POINTER
		do
				--| Initialize SSL, as this may be one of the entry points into SSL where it is
				--| useful to initialize the SSL Library
			initialize_ssl
			method_pointer := c_tlsv10_server_method
			ctx := c_ssl_ctx_new (method_pointer)
		end

	make_as_tlsv11_server
			-- Make an TLSv11 capable server context.
		local
			method_pointer: POINTER
		do
				--| Initialize SSL, as this may be one of the entry points into SSL where it is
				--| useful to initialize the SSL Library
			initialize_ssl
			method_pointer := c_tlsv11_server_method
			ctx := c_ssl_ctx_new (method_pointer)
		end

	make_as_tlsv12_server
			-- Make an TLSv12 capable server context.
		local
			method_pointer: POINTER
		do
				--| Initialize SSL, as this may be one of the entry points into SSL where it is
				--| useful to initialize the SSL Library
			initialize_ssl
			method_pointer := c_tlsv12_server_method
			ctx := c_ssl_ctx_new (method_pointer)
		end

	make_as_dtlsv1_server
			-- Make an DTLSv1 capable server context.
		local
			method_pointer: POINTER
		do
				--| Initialize SSL, as this may be one of the entry points into SSL where it is
				--| useful to initialize the SSL Library
			initialize_ssl
			method_pointer := c_dtlsv1_server_method
			ctx := c_ssl_ctx_new (method_pointer)
		end

	make_from_context_pointer (a_context_pointer: POINTER; a_ssl_pointer: POINTER)
			-- Make a SSL context from a pointer `a_context_pointer' and set the
			-- SSL structed represented by the pointer `a_ssl_pointer'.
		do
			ctx := a_context_pointer
			create last_ssl.make_from_pointer (a_ssl_pointer)
		end

feature -- Access

	create_ssl
			-- Create an SSL object from the current context.
		do
			create last_ssl.make_from_context (ctx)
		end

	free
			-- Free the underlying SSL Context Structure.
		do
			c_ssl_ctx_free (ctx)
		end

	use_certificate (a_certificate: STRING)
			-- Import the PEM certificate in `a_certificate' into this context.
		local
			c_string: C_STRING
			err: INTEGER
			l_exception: DEVELOPER_EXCEPTION
		do
			create c_string.make (a_certificate)
			err := c_ssl_ctx_use_certificate (ctx, c_string.item)
			if err <= 0 then
				create l_exception
				l_exception.set_description ("Cannot load certificate from memory " + a_certificate)
				l_exception.raise
			end
		end

	use_private_key (a_private_key: STRING)
			-- Import the PEM private key in `a_private_key' into this context.
		local
			c_string: C_STRING
			err: INTEGER
			l_exception: DEVELOPER_EXCEPTION
		do
			create c_string.make (a_private_key)
			err := c_ssl_ctx_use_rsaprivatekey (ctx, c_string.item)
			if err <= 0 then
				create l_exception
				l_exception.set_description ("Cannot load private key from memory " + a_private_key)
				l_exception.raise
			end
			err := c_ssl_ctx_check_private_key (ctx)
			if err = 0 then
				create l_exception
				l_exception.set_description ("Private key does not match public key in certificate!")
				l_exception.raise
			end
		end

	use_certificate_file (a_file_name: PATH)
			-- Import the PEM certificate in `a_file_name' into this context.
		local
			c_string: C_STRING
			err: INTEGER
			l_exception: DEVELOPER_EXCEPTION
		do
			create c_string.make (a_file_name.utf_8_name)
			err := c_ssl_ctx_use_certificate_file (ctx, c_string.item, 1)
			if err <= 0 then
				create l_exception
				l_exception.set_description ("Cannot load certificate file " + a_file_name.out)
				l_exception.raise
			end
		end

	use_private_key_file (a_file_name: PATH)
			-- Import the PEM private key in `a_file_name' into this context.
		local
			c_string: C_STRING
			err: INTEGER
			l_exception: DEVELOPER_EXCEPTION
		do
			create c_string.make (a_file_name.utf_8_name)
			err := c_ssl_ctx_use_privatekey_file (ctx, c_string.item, 1)
			if err <= 0 then
				create l_exception
				l_exception.set_description ("Cannot load private key file " + a_file_name.out)
				l_exception.raise
			end
			err := c_ssl_ctx_check_private_key (ctx)
			if err = 0 then
				create l_exception
				l_exception.set_description ("Private key does not match public key in certificate!")
				l_exception.raise
			end
		end

feature -- Status Report

	last_ssl: detachable SSL
			-- The SSL Structure created by `create_ssl'.

feature {NONE} -- Implementation

feature {NONE} -- Attributes

	ctx: POINTER
			-- External SSL_CTX structure.

feature {NONE} -- Externals

	c_ssl_ctx_check_private_key (a_ctx_ptr: POINTER): INTEGER
			-- Call external SSL_CTX_check_private_key.
		external
			"C use %"eif_openssl.h%""
		alias
			"SSL_CTX_check_private_key"
		end

	c_ssl_ctx_free (a_ctx_ptr: POINTER)
			-- External call to SSL_CTX_free.
		external
			"C use %"eif_openssl.h%""
		alias
			"SSL_CTX_free"
		end

	c_ssl_ctx_new (method_ptr: POINTER): POINTER
			-- External call to SSL_CTX_new.
		external
			"C use %"eif_openssl.h%""
		alias
			"SSL_CTX_new"
		end

	c_ssl_ctx_use_certificate(a_ctx_ptr, a_cert_buffer: POINTER ): INTEGER
			-- Call external c_ssl_ctx_use_certificate.
		external
			"C inline use %"eif_openssl.h%""
		alias
			"{
				X509 *cert = NULL;
				BIO *cbio;
			
				cbio = BIO_new_mem_buf((void*)(const char *)$a_cert_buffer, -1);
				cert = PEM_read_bio_X509(cbio, NULL, 0, NULL);
				return (EIF_INTEGER_32) SSL_CTX_use_certificate((SSL_CTX *)$a_ctx_ptr, cert);
			}"
		end


	c_ssl_ctx_use_rsaprivatekey	(a_ctx_ptr, a_key_buffer: POINTER): INTEGER
			-- Call external c_ssl_ctx_use_rsaprivatekey
		external
			"C inline use %"eif_openssl.h%""
		alias
		 "{
			BIO *kbio;
			RSA *rsa = NULL;
	
			kbio = BIO_new_mem_buf((void*)(const char *)$a_key_buffer, -1);
			rsa = PEM_read_bio_RSAPrivateKey(kbio, NULL, 0, NULL);
			return (EIF_INTEGER_32) SSL_CTX_use_RSAPrivateKey((SSL_CTX *)$a_ctx_ptr, rsa);
		  }"
		end

	c_ssl_ctx_use_certificate_file (a_ctx_ptr, file: POINTER; type: INTEGER): INTEGER
			-- Call external SSL_CTX_use_certificate_file.
		external
			"C use %"eif_openssl.h%""
		alias
			"SSL_CTX_use_certificate_file"
		end

	c_ssl_ctx_use_privatekey_file (a_ctx_ptr, file: POINTER; type: INTEGER): INTEGER
			-- Call external SSL_CTX_use_PrivateKey_file.
		external
			"C use %"eif_openssl.h%""
		alias
			"SSL_CTX_use_PrivateKey_file"
		end

	c_sslv3_client_method: POINTER
			-- External call to SSLv3_client_method.
		external
			"C use %"eif_openssl.h%""
		alias
			"SSLv3_client_method"
		end

	c_sslv23_client_method: POINTER
			-- External call to SSLv23_client_method.
		external
			"C use %"eif_openssl.h%""
		alias
			"SSLv23_client_method"
		end

	c_sslv23_server_method: POINTER
			-- External call to SSLv23_server_method.
		external
			"C use %"eif_openssl.h%""
		alias
			"SSLv23_server_method"
		end

	c_sslv3_server_method: POINTER
			-- External call to SSLv3_server_method.
		external
			"C use %"eif_openssl.h%""
		alias
			"SSLv3_server_method"
		end

	c_tlsv10_client_method: POINTER
			-- External call to TLSv1_client_method.
		external
			"C use %"eif_openssl.h%""
		alias
			"TLSv1_client_method"
		end

	c_tlsv10_server_method: POINTER
			-- External call to TLSv1_server_method.
		external
			"C use %"eif_openssl.h%""
		alias
			"TLSv1_server_method"
		end

	c_tlsv11_client_method: POINTER
			-- External call to TLSv1_1_client_method.
		external
			"C use %"eif_openssl.h%""
		alias
			"TLSv1_1_client_method"
		end

	c_tlsv11_server_method: POINTER
			-- External call to TLSv1_1_server_method.
		external
			"C use %"eif_openssl.h%""
		alias
			"TLSv1_1_server_method"
		end

	c_tlsv12_client_method: POINTER
			-- External call to TLSv1_2_client_method.
		external
			"C use %"eif_openssl.h%""
		alias
			"TLSv1_2_client_method"
		end

	c_tlsv12_server_method: POINTER
			-- External call to TLSv1_2_server_method.
		external
			"C use %"eif_openssl.h%""
		alias
			"TLSv1_2_server_method"
		end

	c_dtlsv1_client_method: POINTER
			-- External call to DTLSv1_client_method.
		external
			"C use %"eif_openssl.h%""
		alias
			"DTLSv1_client_method"
		end

	c_dtlsv1_server_method: POINTER
			-- External call to DTLSv1_server_method.
		external
			"C use %"eif_openssl.h%""
		alias
			"DTLSv1_server_method"
		end

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
