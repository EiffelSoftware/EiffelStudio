indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Security.Cryptography.Rijndael"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	RIJNDAEL

inherit
	SYMMETRIC_ALGORITHM
	IDISPOSABLE
		rename
			dispose as system_idisposable_dispose
		end

feature -- Basic Operations

	frozen create__string2 (alg_name: SYSTEM_STRING): RIJNDAEL is
		external
			"IL static signature (System.String): System.Security.Cryptography.Rijndael use System.Security.Cryptography.Rijndael"
		alias
			"Create"
		end

	frozen create__rijndael: RIJNDAEL is
		external
			"IL static signature (): System.Security.Cryptography.Rijndael use System.Security.Cryptography.Rijndael"
		alias
			"Create"
		end

end -- class RIJNDAEL
