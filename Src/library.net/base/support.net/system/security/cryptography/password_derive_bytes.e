indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Security.Cryptography.PasswordDeriveBytes"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	PASSWORD_DERIVE_BYTES

inherit
	DERIVE_BYTES
		redefine
			finalize
		end

create
	make_password_derive_bytes_3,
	make_password_derive_bytes_2,
	make_password_derive_bytes_1,
	make_password_derive_bytes

feature {NONE} -- Initialization

	frozen make_password_derive_bytes_3 (str_password: SYSTEM_STRING; rgb_salt: NATIVE_ARRAY [INTEGER_8]; str_hash_name: SYSTEM_STRING; iterations: INTEGER; csp_params: CSP_PARAMETERS) is
		external
			"IL creator signature (System.String, System.Byte[], System.String, System.Int32, System.Security.Cryptography.CspParameters) use System.Security.Cryptography.PasswordDeriveBytes"
		end

	frozen make_password_derive_bytes_2 (str_password: SYSTEM_STRING; rgb_salt: NATIVE_ARRAY [INTEGER_8]; csp_params: CSP_PARAMETERS) is
		external
			"IL creator signature (System.String, System.Byte[], System.Security.Cryptography.CspParameters) use System.Security.Cryptography.PasswordDeriveBytes"
		end

	frozen make_password_derive_bytes_1 (str_password: SYSTEM_STRING; rgb_salt: NATIVE_ARRAY [INTEGER_8]; str_hash_name: SYSTEM_STRING; iterations: INTEGER) is
		external
			"IL creator signature (System.String, System.Byte[], System.String, System.Int32) use System.Security.Cryptography.PasswordDeriveBytes"
		end

	frozen make_password_derive_bytes (str_password: SYSTEM_STRING; rgb_salt: NATIVE_ARRAY [INTEGER_8]) is
		external
			"IL creator signature (System.String, System.Byte[]) use System.Security.Cryptography.PasswordDeriveBytes"
		end

feature -- Access

	frozen get_hash_name: SYSTEM_STRING is
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

	frozen get_salt: NATIVE_ARRAY [INTEGER_8] is
		external
			"IL signature (): System.Byte[] use System.Security.Cryptography.PasswordDeriveBytes"
		alias
			"get_Salt"
		end

feature -- Element Change

	frozen set_salt (value: NATIVE_ARRAY [INTEGER_8]) is
		external
			"IL signature (System.Byte[]): System.Void use System.Security.Cryptography.PasswordDeriveBytes"
		alias
			"set_Salt"
		end

	frozen set_hash_name (value: SYSTEM_STRING) is
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

	get_bytes (cb: INTEGER): NATIVE_ARRAY [INTEGER_8] is
		external
			"IL signature (System.Int32): System.Byte[] use System.Security.Cryptography.PasswordDeriveBytes"
		alias
			"GetBytes"
		end

	frozen crypt_derive_key (algname: SYSTEM_STRING; alghashname: SYSTEM_STRING; key_size: INTEGER; rgb_iv: NATIVE_ARRAY [INTEGER_8]): NATIVE_ARRAY [INTEGER_8] is
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

end -- class PASSWORD_DERIVE_BYTES
