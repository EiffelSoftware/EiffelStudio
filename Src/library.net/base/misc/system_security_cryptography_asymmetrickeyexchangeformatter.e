indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Security.Cryptography.AsymmetricKeyExchangeFormatter"

deferred external class
	SYSTEM_SECURITY_CRYPTOGRAPHY_ASYMMETRICKEYEXCHANGEFORMATTER

feature -- Access

	get_parameters: STRING is
		external
			"IL deferred signature (): System.String use System.Security.Cryptography.AsymmetricKeyExchangeFormatter"
		alias
			"get_Parameters"
		end

feature -- Basic Operations

	create_key_exchange (data: ARRAY [INTEGER_8]): ARRAY [INTEGER_8] is
		external
			"IL deferred signature (System.Byte[]): System.Byte[] use System.Security.Cryptography.AsymmetricKeyExchangeFormatter"
		alias
			"CreateKeyExchange"
		end

	set_key (key: SYSTEM_SECURITY_CRYPTOGRAPHY_ASYMMETRICALGORITHM) is
		external
			"IL deferred signature (System.Security.Cryptography.AsymmetricAlgorithm): System.Void use System.Security.Cryptography.AsymmetricKeyExchangeFormatter"
		alias
			"SetKey"
		end

	create_key_exchange_array_byte_type (data: ARRAY [INTEGER_8]; sym_alg_type: SYSTEM_TYPE): ARRAY [INTEGER_8] is
		external
			"IL deferred signature (System.Byte[], System.Type): System.Byte[] use System.Security.Cryptography.AsymmetricKeyExchangeFormatter"
		alias
			"CreateKeyExchange"
		end

end -- class SYSTEM_SECURITY_CRYPTOGRAPHY_ASYMMETRICKEYEXCHANGEFORMATTER
