indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Security.Cryptography.AsymmetricKeyExchangeDeformatter"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	ASYMMETRIC_KEY_EXCHANGE_DEFORMATTER

inherit
	SYSTEM_OBJECT

feature -- Access

	get_parameters: SYSTEM_STRING is
		external
			"IL deferred signature (): System.String use System.Security.Cryptography.AsymmetricKeyExchangeDeformatter"
		alias
			"get_Parameters"
		end

feature -- Element Change

	set_parameters (value: SYSTEM_STRING) is
		external
			"IL deferred signature (System.String): System.Void use System.Security.Cryptography.AsymmetricKeyExchangeDeformatter"
		alias
			"set_Parameters"
		end

feature -- Basic Operations

	decrypt_key_exchange (rgb: NATIVE_ARRAY [INTEGER_8]): NATIVE_ARRAY [INTEGER_8] is
		external
			"IL deferred signature (System.Byte[]): System.Byte[] use System.Security.Cryptography.AsymmetricKeyExchangeDeformatter"
		alias
			"DecryptKeyExchange"
		end

	set_key (key: ASYMMETRIC_ALGORITHM) is
		external
			"IL deferred signature (System.Security.Cryptography.AsymmetricAlgorithm): System.Void use System.Security.Cryptography.AsymmetricKeyExchangeDeformatter"
		alias
			"SetKey"
		end

end -- class ASYMMETRIC_KEY_EXCHANGE_DEFORMATTER
