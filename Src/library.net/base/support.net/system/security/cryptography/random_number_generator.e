indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Security.Cryptography.RandomNumberGenerator"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	RANDOM_NUMBER_GENERATOR

inherit
	SYSTEM_OBJECT

feature -- Basic Operations

	frozen create__string (rng_name: SYSTEM_STRING): RANDOM_NUMBER_GENERATOR is
		external
			"IL static signature (System.String): System.Security.Cryptography.RandomNumberGenerator use System.Security.Cryptography.RandomNumberGenerator"
		alias
			"Create"
		end

	frozen create_: RANDOM_NUMBER_GENERATOR is
		external
			"IL static signature (): System.Security.Cryptography.RandomNumberGenerator use System.Security.Cryptography.RandomNumberGenerator"
		alias
			"Create"
		end

	get_non_zero_bytes (data: NATIVE_ARRAY [INTEGER_8]) is
		external
			"IL deferred signature (System.Byte[]): System.Void use System.Security.Cryptography.RandomNumberGenerator"
		alias
			"GetNonZeroBytes"
		end

	get_bytes (data: NATIVE_ARRAY [INTEGER_8]) is
		external
			"IL deferred signature (System.Byte[]): System.Void use System.Security.Cryptography.RandomNumberGenerator"
		alias
			"GetBytes"
		end

end -- class RANDOM_NUMBER_GENERATOR
