indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Security.Cryptography.AsymmetricKeyExchangeDeformatter"

deferred external class
	SYSTEM_SECURITY_CRYPTOGRAPHY_ASYMMETRICKEYEXCHANGEDEFORMATTER

feature -- Access

	get_parameters: STRING is
		external
			"IL deferred signature (): System.String use System.Security.Cryptography.AsymmetricKeyExchangeDeformatter"
		alias
			"get_Parameters"
		end

feature -- Element Change

	set_parameters (value: STRING) is
		external
			"IL deferred signature (System.String): System.Void use System.Security.Cryptography.AsymmetricKeyExchangeDeformatter"
		alias
			"set_Parameters"
		end

feature -- Basic Operations

	decrypt_key_exchange (rgb: ARRAY [INTEGER_8]): ARRAY [INTEGER_8] is
		external
			"IL deferred signature (System.Byte[]): System.Byte[] use System.Security.Cryptography.AsymmetricKeyExchangeDeformatter"
		alias
			"DecryptKeyExchange"
		end

	set_key (key: SYSTEM_SECURITY_CRYPTOGRAPHY_ASYMMETRICALGORITHM) is
		external
			"IL deferred signature (System.Security.Cryptography.AsymmetricAlgorithm): System.Void use System.Security.Cryptography.AsymmetricKeyExchangeDeformatter"
		alias
			"SetKey"
		end

end -- class SYSTEM_SECURITY_CRYPTOGRAPHY_ASYMMETRICKEYEXCHANGEDEFORMATTER
