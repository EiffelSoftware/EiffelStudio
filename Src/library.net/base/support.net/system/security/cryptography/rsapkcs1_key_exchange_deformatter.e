indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Security.Cryptography.RSAPKCS1KeyExchangeDeformatter"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	RSAPKCS1_KEY_EXCHANGE_DEFORMATTER

inherit
	ASYMMETRIC_KEY_EXCHANGE_DEFORMATTER

create
	make_rsapkcs1_key_exchange_deformatter,
	make_rsapkcs1_key_exchange_deformatter_1

feature {NONE} -- Initialization

	frozen make_rsapkcs1_key_exchange_deformatter is
		external
			"IL creator use System.Security.Cryptography.RSAPKCS1KeyExchangeDeformatter"
		end

	frozen make_rsapkcs1_key_exchange_deformatter_1 (key: ASYMMETRIC_ALGORITHM) is
		external
			"IL creator signature (System.Security.Cryptography.AsymmetricAlgorithm) use System.Security.Cryptography.RSAPKCS1KeyExchangeDeformatter"
		end

feature -- Access

	get_parameters: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Security.Cryptography.RSAPKCS1KeyExchangeDeformatter"
		alias
			"get_Parameters"
		end

	frozen get_rng: RANDOM_NUMBER_GENERATOR is
		external
			"IL signature (): System.Security.Cryptography.RandomNumberGenerator use System.Security.Cryptography.RSAPKCS1KeyExchangeDeformatter"
		alias
			"get_RNG"
		end

feature -- Element Change

	frozen set_rng (value: RANDOM_NUMBER_GENERATOR) is
		external
			"IL signature (System.Security.Cryptography.RandomNumberGenerator): System.Void use System.Security.Cryptography.RSAPKCS1KeyExchangeDeformatter"
		alias
			"set_RNG"
		end

	set_parameters (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Security.Cryptography.RSAPKCS1KeyExchangeDeformatter"
		alias
			"set_Parameters"
		end

feature -- Basic Operations

	decrypt_key_exchange (rgb_in: NATIVE_ARRAY [INTEGER_8]): NATIVE_ARRAY [INTEGER_8] is
		external
			"IL signature (System.Byte[]): System.Byte[] use System.Security.Cryptography.RSAPKCS1KeyExchangeDeformatter"
		alias
			"DecryptKeyExchange"
		end

	set_key (key: ASYMMETRIC_ALGORITHM) is
		external
			"IL signature (System.Security.Cryptography.AsymmetricAlgorithm): System.Void use System.Security.Cryptography.RSAPKCS1KeyExchangeDeformatter"
		alias
			"SetKey"
		end

end -- class RSAPKCS1_KEY_EXCHANGE_DEFORMATTER
