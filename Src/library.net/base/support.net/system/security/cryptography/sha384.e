indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Security.Cryptography.SHA384"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	SHA384

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

	frozen create__string2 (hash_name: SYSTEM_STRING): SHA384 is
		external
			"IL static signature (System.String): System.Security.Cryptography.SHA384 use System.Security.Cryptography.SHA384"
		alias
			"Create"
		end

	frozen create__sha384: SHA384 is
		external
			"IL static signature (): System.Security.Cryptography.SHA384 use System.Security.Cryptography.SHA384"
		alias
			"Create"
		end

end -- class SHA384
