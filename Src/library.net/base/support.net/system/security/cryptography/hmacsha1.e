indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Security.Cryptography.HMACSHA1"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	HMACSHA1

inherit
	KEYED_HASH_ALGORITHM
		redefine
			set_key,
			get_key,
			dispose,
			finalize
		end
	ICRYPTO_TRANSFORM
		rename
			dispose as system_idisposable_dispose
		end
	IDISPOSABLE
		rename
			dispose as system_idisposable_dispose
		end

create
	make_hmacsha1_1,
	make_hmacsha1

feature {NONE} -- Initialization

	frozen make_hmacsha1_1 (rgb_key: NATIVE_ARRAY [INTEGER_8]) is
		external
			"IL creator signature (System.Byte[]) use System.Security.Cryptography.HMACSHA1"
		end

	frozen make_hmacsha1 is
		external
			"IL creator use System.Security.Cryptography.HMACSHA1"
		end

feature -- Access

	frozen get_hash_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Security.Cryptography.HMACSHA1"
		alias
			"get_HashName"
		end

	get_key: NATIVE_ARRAY [INTEGER_8] is
		external
			"IL signature (): System.Byte[] use System.Security.Cryptography.HMACSHA1"
		alias
			"get_Key"
		end

feature -- Element Change

	frozen set_hash_name (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Security.Cryptography.HMACSHA1"
		alias
			"set_HashName"
		end

	set_key (value: NATIVE_ARRAY [INTEGER_8]) is
		external
			"IL signature (System.Byte[]): System.Void use System.Security.Cryptography.HMACSHA1"
		alias
			"set_Key"
		end

feature -- Basic Operations

	initialize is
		external
			"IL signature (): System.Void use System.Security.Cryptography.HMACSHA1"
		alias
			"Initialize"
		end

feature {NONE} -- Implementation

	hash_core (rgb: NATIVE_ARRAY [INTEGER_8]; ib: INTEGER; cb: INTEGER) is
		external
			"IL signature (System.Byte[], System.Int32, System.Int32): System.Void use System.Security.Cryptography.HMACSHA1"
		alias
			"HashCore"
		end

	hash_final: NATIVE_ARRAY [INTEGER_8] is
		external
			"IL signature (): System.Byte[] use System.Security.Cryptography.HMACSHA1"
		alias
			"HashFinal"
		end

	dispose (disposing: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Security.Cryptography.HMACSHA1"
		alias
			"Dispose"
		end

	finalize is
		external
			"IL signature (): System.Void use System.Security.Cryptography.HMACSHA1"
		alias
			"Finalize"
		end

end -- class HMACSHA1
