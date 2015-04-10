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
		do
			if ssl_initialized.item = False then
					-- FIXME: issue with concurrent call (not thread safe)
				c_ssleay_add_ssl_algorithms
				c_ssl_load_error_strings
				ssl_initialized.put (True)
			end
		end

feature {NONE} -- Attributes

	ssl_initialized: CELL [BOOLEAN]
			-- Have the SSL Library initialization routines been called?
		once ("THREAD")
			create Result.put (False)
		end

feature {NONE} -- Externals

	c_ssl_load_error_strings
			-- External call to SSL_load_error_strings.
		external
			"C use <openssl/ssl.h>"
		alias
			"SSL_load_error_strings"
		end

	c_ssleay_add_ssl_algorithms
			-- External call to SSLeay_add_ssl_algorithms.
		external
			"C use <openssl/ssl.h>"
		alias
			"SSLeay_add_ssl_algorithms"
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
