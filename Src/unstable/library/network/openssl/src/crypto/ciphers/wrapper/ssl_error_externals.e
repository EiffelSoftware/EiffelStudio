note
	description: "Summary description for {SSL_ERROR_EXTERNALS}."
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=ERR_GET_LIB", "src=https://www.openssl.org/docs/man1.1.0/crypto/ERR_GET_FUNC.html", "protocol=uri"
	EIS: "name=ERR_get_error", "src=https://www.openssl.org/docs/man1.1.0/crypto/ERR_get_error.html", "protocol=uri"

class
	SSL_ERROR_EXTERNALS

feature -- Constants

	ERR_LIB_EVP: INTEGER
		external "C inline use %"eif_openssl.h%""
		alias
			"ERR_LIB_EVP"
		end

	EVP_R_DATA_NOT_MULTIPLE_OF_BLOCK_LENGTH: INTEGER
		external "C inline use %"eif_openssl.h%""
		alias
			"EVP_R_DATA_NOT_MULTIPLE_OF_BLOCK_LENGTH"
		end

feature -- Errors

	c_err_lib_error_string (a_code: NATURAL_64): POINTER
		external "C inline use %"eif_openssl.h%""
		alias
			"return ERR_lib_error_string((unsigned long)$a_code);"
		end

	c_err_func_error_string (a_code: NATURAL_64): POINTER
		external "C inline use %"eif_openssl.h%""
		alias
			"return ERR_func_error_string((unsigned long)$a_code);"
		end

	c_err_reason_error_string (a_code: NATURAL_64): POINTER
		external "C inline use %"eif_openssl.h%""
		alias
			"return ERR_reason_error_string((unsigned long)$a_code);"
		end

	c_err_get_error: NATURAL_64
		external "C inline use %"eif_openssl.h%""
		alias
			"return (EIF_NATURAL_64) ERR_get_error() "
		end

	c_error_get_lib (a_code: NATURAL_64 ): INTEGER
		external "C inline use %"eif_openssl.h%""
		alias
			"return (EIF_INTEGER) ERR_GET_LIB((unsigned long)$a_code)"
		end

	c_error_get_reason (a_code: NATURAL_64 ): INTEGER
		external "C inline use %"eif_openssl.h%""
		alias
			"return (EIF_INTEGER) ERR_GET_REASON((unsigned long)$a_code)"
		end

	c_error_fatal_error (a_code: NATURAL_64 ): INTEGER
		external "C inline use %"eif_openssl.h%""
		alias
			"return (EIF_INTEGER) ERR_FATAL_ERROR((unsigned long)$a_code)"
		end

note
	copyright: "Copyright (c) 1984-2023, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
