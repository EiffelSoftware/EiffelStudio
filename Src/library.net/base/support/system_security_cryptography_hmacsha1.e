indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Security.Cryptography.HMACSHA1"

external class
	SYSTEM_SECURITY_CRYPTOGRAPHY_HMACSHA1

inherit
	SYSTEM_SECURITY_CRYPTOGRAPHY_KEYEDHASHALGORITHM
		redefine
			set_key,
			get_key
		end
	SYSTEM_SECURITY_CRYPTOGRAPHY_ICRYPTOTRANSFORM

create
	make_hmacsha1_1,
	make_hmacsha1

feature {NONE} -- Initialization

	frozen make_hmacsha1_1 (rgb_key: ARRAY [INTEGER_8]) is
		external
			"IL creator signature (System.Byte[]) use System.Security.Cryptography.HMACSHA1"
		end

	frozen make_hmacsha1 is
		external
			"IL creator use System.Security.Cryptography.HMACSHA1"
		end

feature -- Access

	frozen get_hash_name: STRING is
		external
			"IL signature (): System.String use System.Security.Cryptography.HMACSHA1"
		alias
			"get_HashName"
		end

	get_key: ARRAY [INTEGER_8] is
		external
			"IL signature (): System.Byte[] use System.Security.Cryptography.HMACSHA1"
		alias
			"get_Key"
		end

feature -- Element Change

	frozen set_hash_name (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Security.Cryptography.HMACSHA1"
		alias
			"set_HashName"
		end

	set_key (value: ARRAY [INTEGER_8]) is
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

	hash_core (rgb: ARRAY [INTEGER_8]; ib: INTEGER; cb: INTEGER) is
		external
			"IL signature (System.Byte[], System.Int32, System.Int32): System.Void use System.Security.Cryptography.HMACSHA1"
		alias
			"HashCore"
		end

	hash_final: ARRAY [INTEGER_8] is
		external
			"IL signature (): System.Byte[] use System.Security.Cryptography.HMACSHA1"
		alias
			"HashFinal"
		end

end -- class SYSTEM_SECURITY_CRYPTOGRAPHY_HMACSHA1
