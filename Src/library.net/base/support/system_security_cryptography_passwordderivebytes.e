indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Security.Cryptography.PasswordDeriveBytes"

external class
	SYSTEM_SECURITY_CRYPTOGRAPHY_PASSWORDDERIVEBYTES

inherit
	SYSTEM_SECURITY_CRYPTOGRAPHY_DERIVEBYTES
		redefine
			finalize
		end

create
	make_passwordderivebytes,
	make_passwordderivebytes_3,
	make_passwordderivebytes_2,
	make_passwordderivebytes_1

feature {NONE} -- Initialization

	frozen make_passwordderivebytes (str_password: STRING; rgb_salt: ARRAY [INTEGER_8]) is
		external
			"IL creator signature (System.String, System.Byte[]) use System.Security.Cryptography.PasswordDeriveBytes"
		end

	frozen make_passwordderivebytes_3 (str_password: STRING; rgb_salt: ARRAY [INTEGER_8]; str_hash_name: STRING; iterations: INTEGER; csp_params: SYSTEM_SECURITY_CRYPTOGRAPHY_CSPPARAMETERS) is
		external
			"IL creator signature (System.String, System.Byte[], System.String, System.Int32, System.Security.Cryptography.CspParameters) use System.Security.Cryptography.PasswordDeriveBytes"
		end

	frozen make_passwordderivebytes_2 (str_password: STRING; rgb_salt: ARRAY [INTEGER_8]; csp_params: SYSTEM_SECURITY_CRYPTOGRAPHY_CSPPARAMETERS) is
		external
			"IL creator signature (System.String, System.Byte[], System.Security.Cryptography.CspParameters) use System.Security.Cryptography.PasswordDeriveBytes"
		end

	frozen make_passwordderivebytes_1 (str_password: STRING; rgb_salt: ARRAY [INTEGER_8]; str_hash_name: STRING; iterations: INTEGER) is
		external
			"IL creator signature (System.String, System.Byte[], System.String, System.Int32) use System.Security.Cryptography.PasswordDeriveBytes"
		end

feature -- Access

	frozen get_hash_name: STRING is
		external
			"IL signature (): System.String use System.Security.Cryptography.PasswordDeriveBytes"
		alias
			"get_HashName"
		end

	frozen get_iteration_count: INTEGER is
		external
			"IL signature (): System.Int32 use System.Security.Cryptography.PasswordDeriveBytes"
		alias
			"get_IterationCount"
		end

	frozen get_salt: ARRAY [INTEGER_8] is
		external
			"IL signature (): System.Byte[] use System.Security.Cryptography.PasswordDeriveBytes"
		alias
			"get_Salt"
		end

feature -- Element Change

	frozen set_salt (value: ARRAY [INTEGER_8]) is
		external
			"IL signature (System.Byte[]): System.Void use System.Security.Cryptography.PasswordDeriveBytes"
		alias
			"set_Salt"
		end

	frozen set_hash_name (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Security.Cryptography.PasswordDeriveBytes"
		alias
			"set_HashName"
		end

	frozen set_iteration_count (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Security.Cryptography.PasswordDeriveBytes"
		alias
			"set_IterationCount"
		end

feature -- Basic Operations

	reset is
		external
			"IL signature (): System.Void use System.Security.Cryptography.PasswordDeriveBytes"
		alias
			"Reset"
		end

	get_bytes (cb: INTEGER): ARRAY [INTEGER_8] is
		external
			"IL signature (System.Int32): System.Byte[] use System.Security.Cryptography.PasswordDeriveBytes"
		alias
			"GetBytes"
		end

	frozen crypt_derive_key (algname: STRING; alghashname: STRING; key_size: INTEGER; rgb_iv: ARRAY [INTEGER_8]): ARRAY [INTEGER_8] is
		external
			"IL signature (System.String, System.String, System.Int32, System.Byte[]): System.Byte[] use System.Security.Cryptography.PasswordDeriveBytes"
		alias
			"CryptDeriveKey"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use System.Security.Cryptography.PasswordDeriveBytes"
		alias
			"Finalize"
		end

end -- class SYSTEM_SECURITY_CRYPTOGRAPHY_PASSWORDDERIVEBYTES
