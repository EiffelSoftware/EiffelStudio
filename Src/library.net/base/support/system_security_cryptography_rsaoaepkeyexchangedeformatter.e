indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Security.Cryptography.RSAOAEPKeyExchangeDeformatter"

external class
	SYSTEM_SECURITY_CRYPTOGRAPHY_RSAOAEPKEYEXCHANGEDEFORMATTER

inherit
	SYSTEM_SECURITY_CRYPTOGRAPHY_ASYMMETRICKEYEXCHANGEDEFORMATTER

create
	make_rsaoaepkeyexchangedeformatter_1,
	make_rsaoaepkeyexchangedeformatter

feature {NONE} -- Initialization

	frozen make_rsaoaepkeyexchangedeformatter_1 (key: SYSTEM_SECURITY_CRYPTOGRAPHY_ASYMMETRICALGORITHM) is
		external
			"IL creator signature (System.Security.Cryptography.AsymmetricAlgorithm) use System.Security.Cryptography.RSAOAEPKeyExchangeDeformatter"
		end

	frozen make_rsaoaepkeyexchangedeformatter is
		external
			"IL creator use System.Security.Cryptography.RSAOAEPKeyExchangeDeformatter"
		end

feature -- Access

	get_parameters: STRING is
		external
			"IL signature (): System.String use System.Security.Cryptography.RSAOAEPKeyExchangeDeformatter"
		alias
			"get_Parameters"
		end

feature -- Element Change

	set_parameters (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Security.Cryptography.RSAOAEPKeyExchangeDeformatter"
		alias
			"set_Parameters"
		end

feature -- Basic Operations

	decrypt_key_exchange (rgb_data: ARRAY [INTEGER_8]): ARRAY [INTEGER_8] is
		external
			"IL signature (System.Byte[]): System.Byte[] use System.Security.Cryptography.RSAOAEPKeyExchangeDeformatter"
		alias
			"DecryptKeyExchange"
		end

	set_key (key: SYSTEM_SECURITY_CRYPTOGRAPHY_ASYMMETRICALGORITHM) is
		external
			"IL signature (System.Security.Cryptography.AsymmetricAlgorithm): System.Void use System.Security.Cryptography.RSAOAEPKeyExchangeDeformatter"
		alias
			"SetKey"
		end

end -- class SYSTEM_SECURITY_CRYPTOGRAPHY_RSAOAEPKEYEXCHANGEDEFORMATTER
