indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Security.Cryptography.RandomNumberGenerator"

deferred external class
	SYSTEM_SECURITY_CRYPTOGRAPHY_RANDOMNUMBERGENERATOR

feature -- Basic Operations

	frozen create__string (rng_name: STRING): SYSTEM_SECURITY_CRYPTOGRAPHY_RANDOMNUMBERGENERATOR is
		external
			"IL static signature (System.String): System.Security.Cryptography.RandomNumberGenerator use System.Security.Cryptography.RandomNumberGenerator"
		alias
			"Create"
		end

	get_non_zero_bytes (data: ARRAY [INTEGER_8]) is
		external
			"IL deferred signature (System.Byte[]): System.Void use System.Security.Cryptography.RandomNumberGenerator"
		alias
			"GetNonZeroBytes"
		end

	frozen Create_: SYSTEM_SECURITY_CRYPTOGRAPHY_RANDOMNUMBERGENERATOR is
		external
			"IL static signature (): System.Security.Cryptography.RandomNumberGenerator use System.Security.Cryptography.RandomNumberGenerator"
		alias
			"Create"
		end

	get_bytes (data: ARRAY [INTEGER_8]) is
		external
			"IL deferred signature (System.Byte[]): System.Void use System.Security.Cryptography.RandomNumberGenerator"
		alias
			"GetBytes"
		end

end -- class SYSTEM_SECURITY_CRYPTOGRAPHY_RANDOMNUMBERGENERATOR
