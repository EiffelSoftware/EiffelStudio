indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Security.Cryptography.AsymmetricAlgorithm"

deferred external class
	SYSTEM_SECURITY_CRYPTOGRAPHY_ASYMMETRICALGORITHM

feature -- Access

	get_signature_algorithm: STRING is
		external
			"IL deferred signature (): System.String use System.Security.Cryptography.AsymmetricAlgorithm"
		alias
			"get_SignatureAlgorithm"
		end

	get_key_size: INTEGER is
		external
			"IL signature (): System.Int32 use System.Security.Cryptography.AsymmetricAlgorithm"
		alias
			"get_KeySize"
		end

	get_legal_key_sizes: ARRAY [SYSTEM_SECURITY_CRYPTOGRAPHY_KEYSIZES] is
		external
			"IL signature (): System.Security.Cryptography.KeySizes[] use System.Security.Cryptography.AsymmetricAlgorithm"
		alias
			"get_LegalKeySizes"
		end

	get_key_exchange_algorithm: STRING is
		external
			"IL deferred signature (): System.String use System.Security.Cryptography.AsymmetricAlgorithm"
		alias
			"get_KeyExchangeAlgorithm"
		end

feature -- Element Change

	set_key_size (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Security.Cryptography.AsymmetricAlgorithm"
		alias
			"set_KeySize"
		end

feature -- Basic Operations

	to_xml_string (include_private_parameters: BOOLEAN): STRING is
		external
			"IL deferred signature (System.Boolean): System.String use System.Security.Cryptography.AsymmetricAlgorithm"
		alias
			"ToXmlString"
		end

	frozen create__string (alg_name: STRING): SYSTEM_SECURITY_CRYPTOGRAPHY_ASYMMETRICALGORITHM is
		external
			"IL static signature (System.String): System.Security.Cryptography.AsymmetricAlgorithm use System.Security.Cryptography.AsymmetricAlgorithm"
		alias
			"Create"
		end

	from_xml_string (xml_string: STRING) is
		external
			"IL deferred signature (System.String): System.Void use System.Security.Cryptography.AsymmetricAlgorithm"
		alias
			"FromXmlString"
		end

	frozen Create_: SYSTEM_SECURITY_CRYPTOGRAPHY_ASYMMETRICALGORITHM is
		external
			"IL static signature (): System.Security.Cryptography.AsymmetricAlgorithm use System.Security.Cryptography.AsymmetricAlgorithm"
		alias
			"Create"
		end

end -- class SYSTEM_SECURITY_CRYPTOGRAPHY_ASYMMETRICALGORITHM
