indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Security.Cryptography.DES"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	DES

inherit
	SYMMETRIC_ALGORITHM
		redefine
			set_key,
			get_key
		end
	IDISPOSABLE
		rename
			dispose as system_idisposable_dispose
		end

feature -- Access

	get_key: NATIVE_ARRAY [INTEGER_8] is
		external
			"IL signature (): System.Byte[] use System.Security.Cryptography.DES"
		alias
			"get_Key"
		end

feature -- Element Change

	set_key (value: NATIVE_ARRAY [INTEGER_8]) is
		external
			"IL signature (System.Byte[]): System.Void use System.Security.Cryptography.DES"
		alias
			"set_Key"
		end

feature -- Basic Operations

	frozen create__string2 (alg_name: SYSTEM_STRING): DES is
		external
			"IL static signature (System.String): System.Security.Cryptography.DES use System.Security.Cryptography.DES"
		alias
			"Create"
		end

	frozen create__des: DES is
		external
			"IL static signature (): System.Security.Cryptography.DES use System.Security.Cryptography.DES"
		alias
			"Create"
		end

	frozen is_weak_key (rgb_key: NATIVE_ARRAY [INTEGER_8]): BOOLEAN is
		external
			"IL static signature (System.Byte[]): System.Boolean use System.Security.Cryptography.DES"
		alias
			"IsWeakKey"
		end

	frozen is_semi_weak_key (rgb_key: NATIVE_ARRAY [INTEGER_8]): BOOLEAN is
		external
			"IL static signature (System.Byte[]): System.Boolean use System.Security.Cryptography.DES"
		alias
			"IsSemiWeakKey"
		end

end -- class DES
