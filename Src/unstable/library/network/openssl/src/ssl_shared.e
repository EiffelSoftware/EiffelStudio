note
	description: "SSL context,  loads up the algorithms that OpenSSL will be using and also loads the errors Strings."
	legal: "See notice at end of class"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	SSL_SHARED

feature {NONE} -- Initialization

	initialize_ssl
			-- Initialize the SSL Library.
			-- with libcrypto.
		do
			if ssl_initialized.item = False then
				c_openssl_init_ssl
				c_openssl_add_ssl_algorithms
				c_openssl_add_all_algorithms
				process_exclusive_execution (exclusive_access)
				process_crypto_exclusive_execution (exclusive_access)
				ssl_initialized.put (True)
			end
		end

feature {NONE} -- Attributes

	process_exclusive_execution (a_access: like exclusive_access)
		local
			l_retry: BOOLEAN
		do
			if not l_retry then
				a_access.enter
	   			a_access.call(agent c_ssl_load_error_strings)
				a_access.leave
			else
			end
		rescue
			l_retry := True
			a_access.leave
			retry
		end

	process_crypto_exclusive_execution (a_access: like exclusive_access)
		local
			l_retry: BOOLEAN
		do
			if not l_retry then
				a_access.enter
	   			a_access.call(agent c_err_load_crypto_strings)
				a_access.leave
			else
			end
		rescue
			l_retry := True
			a_access.leave
			retry
		end


	ssl_initialized: CELL [BOOLEAN]
			-- Have the SSL Library initialization routines been called?
		once ("THREAD")
			create Result.put (False)
		end

   exclusive_access: separate SSL_EXCLUSIVE_ACCESS
   		once("PROCESS")
   			create Result
   		end

feature {NONE} -- External

	c_ssl_load_error_strings
			-- External call to SSL_load_error_strings.
		external
			"C use %"eif_openssl.h%""
		alias
			"SSL_load_error_strings"
		end

	c_openssl_init_ssl
			-- External call to OPENSSL_init_ssl.
		external
			"C inline use %"eif_openssl.h%""
		alias
			"SSL_library_init()"
		end

	c_openssl_add_ssl_algorithms
			-- External call to OpenSSL_add_ssl_algorithms();.
		external
			"C use %"eif_openssl.h%""
		alias
			"OpenSSL_add_ssl_algorithms"
		end


	c_openssl_add_all_algorithms
			-- External call to OPENSSL_add_all_algorithm.
		external "C use %"eif_openssl.h%""
		alias
			"OpenSSL_add_all_algorithms"
		end

	c_err_load_crypto_strings
			-- External call to ERR_load_crypto_strings
		external
			"C use %"eif_openssl.h%""
		alias
			"ERR_load_crypto_strings"
		end

	c_ssl_get_ctx (a_ssl: POINTER): POINTER
			-- External call to SSL_get_SSL_CTX.
		external
			"C use %"eif_openssl.h%""
		alias
			"SSL_get_SSL_CTX"
		end

note
	copyright: "Copyright (c) 1984-2017, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
