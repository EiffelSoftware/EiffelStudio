indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Security.Cryptography.AsymmetricSignatureDeformatter"

deferred external class
	SYSTEM_SECURITY_CRYPTOGRAPHY_ASYMMETRICSIGNATUREDEFORMATTER

feature -- Basic Operations

	set_hash_algorithm (str_name: STRING) is
		external
			"IL deferred signature (System.String): System.Void use System.Security.Cryptography.AsymmetricSignatureDeformatter"
		alias
			"SetHashAlgorithm"
		end

	verify_signature (hash: SYSTEM_SECURITY_CRYPTOGRAPHY_HASHALGORITHM; rgb_signature: ARRAY [INTEGER_8]): BOOLEAN is
		external
			"IL signature (System.Security.Cryptography.HashAlgorithm, System.Byte[]): System.Boolean use System.Security.Cryptography.AsymmetricSignatureDeformatter"
		alias
			"VerifySignature"
		end

	verify_signature_array_byte (rgb_hash: ARRAY [INTEGER_8]; rgb_signature: ARRAY [INTEGER_8]): BOOLEAN is
		external
			"IL deferred signature (System.Byte[], System.Byte[]): System.Boolean use System.Security.Cryptography.AsymmetricSignatureDeformatter"
		alias
			"VerifySignature"
		end

	set_key (key: SYSTEM_SECURITY_CRYPTOGRAPHY_ASYMMETRICALGORITHM) is
		external
			"IL deferred signature (System.Security.Cryptography.AsymmetricAlgorithm): System.Void use System.Security.Cryptography.AsymmetricSignatureDeformatter"
		alias
			"SetKey"
		end

end -- class SYSTEM_SECURITY_CRYPTOGRAPHY_ASYMMETRICSIGNATUREDEFORMATTER
