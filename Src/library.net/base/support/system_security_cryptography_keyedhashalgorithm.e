indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Security.Cryptography.KeyedHashAlgorithm"

deferred external class
	SYSTEM_SECURITY_CRYPTOGRAPHY_KEYEDHASHALGORITHM

inherit
	SYSTEM_SECURITY_CRYPTOGRAPHY_HASHALGORITHM
	SYSTEM_SECURITY_CRYPTOGRAPHY_ICRYPTOTRANSFORM

feature -- Access

	get_key: ARRAY [INTEGER_8] is
		external
			"IL signature (): System.Byte[] use System.Security.Cryptography.KeyedHashAlgorithm"
		alias
			"get_Key"
		end

feature -- Element Change

	set_key (value: ARRAY [INTEGER_8]) is
		external
			"IL signature (System.Byte[]): System.Void use System.Security.Cryptography.KeyedHashAlgorithm"
		alias
			"set_Key"
		end

feature -- Basic Operations

	frozen create__string2 (alg_name: STRING): SYSTEM_SECURITY_CRYPTOGRAPHY_KEYEDHASHALGORITHM is
		external
			"IL static signature (System.String): System.Security.Cryptography.KeyedHashAlgorithm use System.Security.Cryptography.KeyedHashAlgorithm"
		alias
			"Create"
		end

	frozen create__keyed_hash_algorithm: SYSTEM_SECURITY_CRYPTOGRAPHY_KEYEDHASHALGORITHM is
		external
			"IL static signature (): System.Security.Cryptography.KeyedHashAlgorithm use System.Security.Cryptography.KeyedHashAlgorithm"
		alias
			"Create"
		end

end -- class SYSTEM_SECURITY_CRYPTOGRAPHY_KEYEDHASHALGORITHM
