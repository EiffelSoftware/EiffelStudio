indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Security.Cryptography.RSAOAEPKeyExchangeFormatter"

external class
	SYSTEM_SECURITY_CRYPTOGRAPHY_RSAOAEPKEYEXCHANGEFORMATTER

inherit
	SYSTEM_SECURITY_CRYPTOGRAPHY_ASYMMETRICKEYEXCHANGEFORMATTER

create
	make_rsaoaepkeyexchangeformatter,
	make_rsaoaepkeyexchangeformatter_1

feature {NONE} -- Initialization

	frozen make_rsaoaepkeyexchangeformatter is
		external
			"IL creator use System.Security.Cryptography.RSAOAEPKeyExchangeFormatter"
		end

	frozen make_rsaoaepkeyexchangeformatter_1 (key: SYSTEM_SECURITY_CRYPTOGRAPHY_ASYMMETRICALGORITHM) is
		external
			"IL creator signature (System.Security.Cryptography.AsymmetricAlgorithm) use System.Security.Cryptography.RSAOAEPKeyExchangeFormatter"
		end

feature -- Access

	frozen get_rng: SYSTEM_SECURITY_CRYPTOGRAPHY_RANDOMNUMBERGENERATOR is
		external
			"IL signature (): System.Security.Cryptography.RandomNumberGenerator use System.Security.Cryptography.RSAOAEPKeyExchangeFormatter"
		alias
			"get_Rng"
		end

	get_parameters: STRING is
		external
			"IL signature (): System.String use System.Security.Cryptography.RSAOAEPKeyExchangeFormatter"
		alias
			"get_Parameters"
		end

	frozen get_parameter: ARRAY [INTEGER_8] is
		external
			"IL signature (): System.Byte[] use System.Security.Cryptography.RSAOAEPKeyExchangeFormatter"
		alias
			"get_Parameter"
		end

feature -- Element Change

	frozen set_parameter (value: ARRAY [INTEGER_8]) is
		external
			"IL signature (System.Byte[]): System.Void use System.Security.Cryptography.RSAOAEPKeyExchangeFormatter"
		alias
			"set_Parameter"
		end

	frozen set_rng (value: SYSTEM_SECURITY_CRYPTOGRAPHY_RANDOMNUMBERGENERATOR) is
		external
			"IL signature (System.Security.Cryptography.RandomNumberGenerator): System.Void use System.Security.Cryptography.RSAOAEPKeyExchangeFormatter"
		alias
			"set_Rng"
		end

feature -- Basic Operations

	create_key_exchange (rgb_data: ARRAY [INTEGER_8]): ARRAY [INTEGER_8] is
		external
			"IL signature (System.Byte[]): System.Byte[] use System.Security.Cryptography.RSAOAEPKeyExchangeFormatter"
		alias
			"CreateKeyExchange"
		end

	set_key (key: SYSTEM_SECURITY_CRYPTOGRAPHY_ASYMMETRICALGORITHM) is
		external
			"IL signature (System.Security.Cryptography.AsymmetricAlgorithm): System.Void use System.Security.Cryptography.RSAOAEPKeyExchangeFormatter"
		alias
			"SetKey"
		end

	create_key_exchange_array_byte_type (rgb_data: ARRAY [INTEGER_8]; sym_alg_type: SYSTEM_TYPE): ARRAY [INTEGER_8] is
		external
			"IL signature (System.Byte[], System.Type): System.Byte[] use System.Security.Cryptography.RSAOAEPKeyExchangeFormatter"
		alias
			"CreateKeyExchange"
		end

end -- class SYSTEM_SECURITY_CRYPTOGRAPHY_RSAOAEPKEYEXCHANGEFORMATTER
