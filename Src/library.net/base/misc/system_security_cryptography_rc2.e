indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Security.Cryptography.RC2"

deferred external class
	SYSTEM_SECURITY_CRYPTOGRAPHY_RC2

inherit
	SYSTEM_SECURITY_CRYPTOGRAPHY_SYMMETRICALGORITHM
		redefine
			set_key_size,
			get_key_size
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

	frozen create__rc2: SYSTEM_SECURITY_CRYPTOGRAPHY_RC2 is
		external
			"IL static signature (): System.Security.Cryptography.RC2 use System.Security.Cryptography.RC2"
		alias
			"Create"
		end

	frozen create__string2 (alg_name: STRING): SYSTEM_SECURITY_CRYPTOGRAPHY_RC2 is
		external
			"IL static signature (System.String): System.Security.Cryptography.RC2 use System.Security.Cryptography.RC2"
		alias
			"Create"
		end

end -- class SYSTEM_SECURITY_CRYPTOGRAPHY_RC2
