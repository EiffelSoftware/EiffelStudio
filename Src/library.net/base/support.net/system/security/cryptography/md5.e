indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Security.Cryptography.MD5"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	MD5

inherit
	HASH_ALGORITHM
	ICRYPTO_TRANSFORM
		rename
			dispose as system_idisposable_dispose
		end
	IDISPOSABLE
		rename
			dispose as system_idisposable_dispose
		end

feature -- Basic Operations

	frozen create__md5: MD5 is
		external
			"IL static signature (): System.Security.Cryptography.MD5 use System.Security.Cryptography.MD5"
		alias
			"Create"
		end

	frozen create__string2 (alg_name: SYSTEM_STRING): MD5 is
		external
			"IL static signature (System.String): System.Security.Cryptography.MD5 use System.Security.Cryptography.MD5"
		alias
			"Create"
		end

end -- class MD5
