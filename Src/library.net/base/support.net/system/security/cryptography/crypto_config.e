indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Security.Cryptography.CryptoConfig"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	CRYPTO_CONFIG

inherit
	SYSTEM_OBJECT

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.Security.Cryptography.CryptoConfig"
		end

feature -- Basic Operations

	frozen create_from_name_string_array_object (name: SYSTEM_STRING; args: NATIVE_ARRAY [SYSTEM_OBJECT]): SYSTEM_OBJECT is
		external
			"IL static signature (System.String, System.Object[]): System.Object use System.Security.Cryptography.CryptoConfig"
		alias
			"CreateFromName"
		end

	frozen encode_oid (str: SYSTEM_STRING): NATIVE_ARRAY [INTEGER_8] is
		external
			"IL static signature (System.String): System.Byte[] use System.Security.Cryptography.CryptoConfig"
		alias
			"EncodeOID"
		end

	frozen create_from_name (name: SYSTEM_STRING): SYSTEM_OBJECT is
		external
			"IL static signature (System.String): System.Object use System.Security.Cryptography.CryptoConfig"
		alias
			"CreateFromName"
		end

	frozen map_name_to_oid (name: SYSTEM_STRING): SYSTEM_STRING is
		external
			"IL static signature (System.String): System.String use System.Security.Cryptography.CryptoConfig"
		alias
			"MapNameToOID"
		end

end -- class CRYPTO_CONFIG
