indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Security.Cryptography.KeyedHashAlgorithm"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	KEYED_HASH_ALGORITHM

inherit
	HASH_ALGORITHM
		redefine
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

feature -- Access

	get_key: NATIVE_ARRAY [INTEGER_8] is
		external
			"IL signature (): System.Byte[] use System.Security.Cryptography.KeyedHashAlgorithm"
		alias
			"get_Key"
		end

feature -- Element Change

	set_key (value: NATIVE_ARRAY [INTEGER_8]) is
		external
			"IL signature (System.Byte[]): System.Void use System.Security.Cryptography.KeyedHashAlgorithm"
		alias
			"set_Key"
		end

feature -- Basic Operations

	frozen create__string2 (alg_name: SYSTEM_STRING): KEYED_HASH_ALGORITHM is
		external
			"IL static signature (System.String): System.Security.Cryptography.KeyedHashAlgorithm use System.Security.Cryptography.KeyedHashAlgorithm"
		alias
			"Create"
		end

	frozen create__keyed_hash_algorithm: KEYED_HASH_ALGORITHM is
		external
			"IL static signature (): System.Security.Cryptography.KeyedHashAlgorithm use System.Security.Cryptography.KeyedHashAlgorithm"
		alias
			"Create"
		end

feature {NONE} -- Implementation

	dispose (disposing: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Security.Cryptography.KeyedHashAlgorithm"
		alias
			"Dispose"
		end

	finalize is
		external
			"IL signature (): System.Void use System.Security.Cryptography.KeyedHashAlgorithm"
		alias
			"Finalize"
		end

end -- class KEYED_HASH_ALGORITHM
