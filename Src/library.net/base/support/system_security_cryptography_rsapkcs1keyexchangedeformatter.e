indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Security.Cryptography.RSAPKCS1KeyExchangeDeformatter"

external class
	SYSTEM_SECURITY_CRYPTOGRAPHY_RSAPKCS1KEYEXCHANGEDEFORMATTER

inherit
	SYSTEM_SECURITY_CRYPTOGRAPHY_ASYMMETRICKEYEXCHANGEDEFORMATTER

create
	make_rsapkcs1keyexchangedeformatter_1,
	make_rsapkcs1keyexchangedeformatter

feature {NONE} -- Initialization

	frozen make_rsapkcs1keyexchangedeformatter_1 (key: SYSTEM_SECURITY_CRYPTOGRAPHY_ASYMMETRICALGORITHM) is
		external
			"IL creator signature (System.Security.Cryptography.AsymmetricAlgorithm) use System.Security.Cryptography.RSAPKCS1KeyExchangeDeformatter"
		end

	frozen make_rsapkcs1keyexchangedeformatter is
		external
			"IL creator use System.Security.Cryptography.RSAPKCS1KeyExchangeDeformatter"
		end

feature -- Access

	get_parameters: STRING is
		external
			"IL signature (): System.String use System.Security.Cryptography.RSAPKCS1KeyExchangeDeformatter"
		alias
			"get_Parameters"
		end

	frozen get_rng: SYSTEM_SECURITY_CRYPTOGRAPHY_RANDOMNUMBERGENERATOR is
		external
			"IL signature (): System.Security.Cryptography.RandomNumberGenerator use System.Security.Cryptography.RSAPKCS1KeyExchangeDeformatter"
		alias
			"get_RNG"
		end

feature -- Element Change

	frozen set_rng (value: SYSTEM_SECURITY_CRYPTOGRAPHY_RANDOMNUMBERGENERATOR) is
		external
			"IL signature (System.Security.Cryptography.RandomNumberGenerator): System.Void use System.Security.Cryptography.RSAPKCS1KeyExchangeDeformatter"
		alias
			"set_RNG"
		end

	set_parameters (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Security.Cryptography.RSAPKCS1KeyExchangeDeformatter"
		alias
			"set_Parameters"
		end

feature -- Basic Operations

	decrypt_key_exchange (rgb_in: ARRAY [INTEGER_8]): ARRAY [INTEGER_8] is
		external
			"IL signature (System.Byte[]): System.Byte[] use System.Security.Cryptography.RSAPKCS1KeyExchangeDeformatter"
		alias
			"DecryptKeyExchange"
		end

	set_key (key: SYSTEM_SECURITY_CRYPTOGRAPHY_ASYMMETRICALGORITHM) is
		external
			"IL signature (System.Security.Cryptography.AsymmetricAlgorithm): System.Void use System.Security.Cryptography.RSAPKCS1KeyExchangeDeformatter"
		alias
			"SetKey"
		end

end -- class SYSTEM_SECURITY_CRYPTOGRAPHY_RSAPKCS1KEYEXCHANGEDEFORMATTER
