indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Security.Cryptography.TripleDES"

deferred external class
	SYSTEM_SECURITY_CRYPTOGRAPHY_TRIPLEDES

inherit
	SYSTEM_SECURITY_CRYPTOGRAPHY_SYMMETRICALGORITHM
		redefine
			set_key,
			get_key
		end

feature -- Access

	get_key: ARRAY [INTEGER_8] is
		external
			"IL signature (): System.Byte[] use System.Security.Cryptography.TripleDES"
		alias
			"get_Key"
		end

feature -- Element Change

	set_key (value: ARRAY [INTEGER_8]) is
		external
			"IL signature (System.Byte[]): System.Void use System.Security.Cryptography.TripleDES"
		alias
			"set_Key"
		end

feature -- Basic Operations

	frozen create__string2 (str: STRING): SYSTEM_SECURITY_CRYPTOGRAPHY_TRIPLEDES is
		external
			"IL static signature (System.String): System.Security.Cryptography.TripleDES use System.Security.Cryptography.TripleDES"
		alias
			"Create"
		end

	frozen create__triple_des: SYSTEM_SECURITY_CRYPTOGRAPHY_TRIPLEDES is
		external
			"IL static signature (): System.Security.Cryptography.TripleDES use System.Security.Cryptography.TripleDES"
		alias
			"Create"
		end

	frozen is_weak_key (rgb_key: ARRAY [INTEGER_8]): BOOLEAN is
		external
			"IL static signature (System.Byte[]): System.Boolean use System.Security.Cryptography.TripleDES"
		alias
			"IsWeakKey"
		end

end -- class SYSTEM_SECURITY_CRYPTOGRAPHY_TRIPLEDES
