indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Security.Cryptography.RSAOAEPKeyExchangeFormatter"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	RSAOAEPKEY_EXCHANGE_FORMATTER

inherit
	ASYMMETRIC_KEY_EXCHANGE_FORMATTER

create
	make_rsaoaepkey_exchange_formatter_1,
	make_rsaoaepkey_exchange_formatter

feature {NONE} -- Initialization

	frozen make_rsaoaepkey_exchange_formatter_1 (key: ASYMMETRIC_ALGORITHM) is
		external
			"IL creator signature (System.Security.Cryptography.AsymmetricAlgorithm) use System.Security.Cryptography.RSAOAEPKeyExchangeFormatter"
		end

	frozen make_rsaoaepkey_exchange_formatter is
		external
			"IL creator use System.Security.Cryptography.RSAOAEPKeyExchangeFormatter"
		end

feature -- Access

	frozen get_rng: RANDOM_NUMBER_GENERATOR is
		external
			"IL signature (): System.Security.Cryptography.RandomNumberGenerator use System.Security.Cryptography.RSAOAEPKeyExchangeFormatter"
		alias
			"get_Rng"
		end

	get_parameters: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Security.Cryptography.RSAOAEPKeyExchangeFormatter"
		alias
			"get_Parameters"
		end

	frozen get_parameter: NATIVE_ARRAY [INTEGER_8] is
		external
			"IL signature (): System.Byte[] use System.Security.Cryptography.RSAOAEPKeyExchangeFormatter"
		alias
			"get_Parameter"
		end

feature -- Element Change

	frozen set_parameter (value: NATIVE_ARRAY [INTEGER_8]) is
		external
			"IL signature (System.Byte[]): System.Void use System.Security.Cryptography.RSAOAEPKeyExchangeFormatter"
		alias
			"set_Parameter"
		end

	frozen set_rng (value: RANDOM_NUMBER_GENERATOR) is
		external
			"IL signature (System.Security.Cryptography.RandomNumberGenerator): System.Void use System.Security.Cryptography.RSAOAEPKeyExchangeFormatter"
		alias
			"set_Rng"
		end

feature -- Basic Operations

	create_key_exchange (rgb_data: NATIVE_ARRAY [INTEGER_8]): NATIVE_ARRAY [INTEGER_8] is
		external
			"IL signature (System.Byte[]): System.Byte[] use System.Security.Cryptography.RSAOAEPKeyExchangeFormatter"
		alias
			"CreateKeyExchange"
		end

	set_key (key: ASYMMETRIC_ALGORITHM) is
		external
			"IL signature (System.Security.Cryptography.AsymmetricAlgorithm): System.Void use System.Security.Cryptography.RSAOAEPKeyExchangeFormatter"
		alias
			"SetKey"
		end

	create_key_exchange_array_byte_type (rgb_data: NATIVE_ARRAY [INTEGER_8]; sym_alg_type: TYPE): NATIVE_ARRAY [INTEGER_8] is
		external
			"IL signature (System.Byte[], System.Type): System.Byte[] use System.Security.Cryptography.RSAOAEPKeyExchangeFormatter"
		alias
			"CreateKeyExchange"
		end

end -- class RSAOAEPKEY_EXCHANGE_FORMATTER
