indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Security.Cryptography.RSAOAEPKeyExchangeDeformatter"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	RSAOAEPKEY_EXCHANGE_DEFORMATTER

inherit
	ASYMMETRIC_KEY_EXCHANGE_DEFORMATTER

create
	make_rsaoaepkey_exchange_deformatter,
	make_rsaoaepkey_exchange_deformatter_1

feature {NONE} -- Initialization

	frozen make_rsaoaepkey_exchange_deformatter is
		external
			"IL creator use System.Security.Cryptography.RSAOAEPKeyExchangeDeformatter"
		end

	frozen make_rsaoaepkey_exchange_deformatter_1 (key: ASYMMETRIC_ALGORITHM) is
		external
			"IL creator signature (System.Security.Cryptography.AsymmetricAlgorithm) use System.Security.Cryptography.RSAOAEPKeyExchangeDeformatter"
		end

feature -- Access

	get_parameters: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Security.Cryptography.RSAOAEPKeyExchangeDeformatter"
		alias
			"get_Parameters"
		end

feature -- Element Change

	set_parameters (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Security.Cryptography.RSAOAEPKeyExchangeDeformatter"
		alias
			"set_Parameters"
		end

feature -- Basic Operations

	decrypt_key_exchange (rgb_data: NATIVE_ARRAY [INTEGER_8]): NATIVE_ARRAY [INTEGER_8] is
		external
			"IL signature (System.Byte[]): System.Byte[] use System.Security.Cryptography.RSAOAEPKeyExchangeDeformatter"
		alias
			"DecryptKeyExchange"
		end

	set_key (key: ASYMMETRIC_ALGORITHM) is
		external
			"IL signature (System.Security.Cryptography.AsymmetricAlgorithm): System.Void use System.Security.Cryptography.RSAOAEPKeyExchangeDeformatter"
		alias
			"SetKey"
		end

end -- class RSAOAEPKEY_EXCHANGE_DEFORMATTER
