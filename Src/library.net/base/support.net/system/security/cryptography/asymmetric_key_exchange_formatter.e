indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Security.Cryptography.AsymmetricKeyExchangeFormatter"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	ASYMMETRIC_KEY_EXCHANGE_FORMATTER

inherit
	SYSTEM_OBJECT

feature -- Access

	get_parameters: SYSTEM_STRING is
		external
			"IL deferred signature (): System.String use System.Security.Cryptography.AsymmetricKeyExchangeFormatter"
		alias
			"get_Parameters"
		end

feature -- Basic Operations

	create_key_exchange (data: NATIVE_ARRAY [INTEGER_8]): NATIVE_ARRAY [INTEGER_8] is
		external
			"IL deferred signature (System.Byte[]): System.Byte[] use System.Security.Cryptography.AsymmetricKeyExchangeFormatter"
		alias
			"CreateKeyExchange"
		end

	set_key (key: ASYMMETRIC_ALGORITHM) is
		external
			"IL deferred signature (System.Security.Cryptography.AsymmetricAlgorithm): System.Void use System.Security.Cryptography.AsymmetricKeyExchangeFormatter"
		alias
			"SetKey"
		end

	create_key_exchange_array_byte_type (data: NATIVE_ARRAY [INTEGER_8]; sym_alg_type: TYPE): NATIVE_ARRAY [INTEGER_8] is
		external
			"IL deferred signature (System.Byte[], System.Type): System.Byte[] use System.Security.Cryptography.AsymmetricKeyExchangeFormatter"
		alias
			"CreateKeyExchange"
		end

end -- class ASYMMETRIC_KEY_EXCHANGE_FORMATTER
