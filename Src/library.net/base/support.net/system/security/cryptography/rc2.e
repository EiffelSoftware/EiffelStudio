indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Security.Cryptography.RC2"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	RC2

inherit
	SYMMETRIC_ALGORITHM
		redefine
			set_key_size,
			get_key_size
		end
	IDISPOSABLE
		rename
			dispose as system_idisposable_dispose
		end

feature -- Access

	get_key_size: INTEGER is
		external
			"IL signature (): System.Int32 use System.Security.Cryptography.RC2"
		alias
			"get_KeySize"
		end

	get_effective_key_size: INTEGER is
		external
			"IL signature (): System.Int32 use System.Security.Cryptography.RC2"
		alias
			"get_EffectiveKeySize"
		end

feature -- Element Change

	set_effective_key_size (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Security.Cryptography.RC2"
		alias
			"set_EffectiveKeySize"
		end

	set_key_size (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Security.Cryptography.RC2"
		alias
			"set_KeySize"
		end

feature -- Basic Operations

	frozen create__rc2: RC2 is
		external
			"IL static signature (): System.Security.Cryptography.RC2 use System.Security.Cryptography.RC2"
		alias
			"Create"
		end

	frozen create__string2 (alg_name: SYSTEM_STRING): RC2 is
		external
			"IL static signature (System.String): System.Security.Cryptography.RC2 use System.Security.Cryptography.RC2"
		alias
			"Create"
		end

end -- class RC2
