indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Security.Cryptography.AsymmetricSignatureFormatter"

deferred external class
	SYSTEM_SECURITY_CRYPTOGRAPHY_ASYMMETRICSIGNATUREFORMATTER

feature -- Basic Operations

	create_signature_array_byte (rgb_hash: ARRAY [INTEGER_8]): ARRAY [INTEGER_8] is
		external
			"IL deferred signature (System.Byte[]): System.Byte[] use System.Security.Cryptography.AsymmetricSignatureFormatter"
		alias
			"CreateSignature"
		end

	set_hash_algorithm (str_name: STRING) is
		external
			"IL deferred signature (System.String): System.Void use System.Security.Cryptography.AsymmetricSignatureFormatter"
		alias
			"SetHashAlgorithm"
		end

	set_key (key: SYSTEM_SECURITY_CRYPTOGRAPHY_ASYMMETRICALGORITHM) is
		external
			"IL deferred signature (System.Security.Cryptography.AsymmetricAlgorithm): System.Void use System.Security.Cryptography.AsymmetricSignatureFormatter"
		alias
			"SetKey"
		end

	create_signature (hash: SYSTEM_SECURITY_CRYPTOGRAPHY_HASHALGORITHM): ARRAY [INTEGER_8] is
		external
			"IL signature (System.Security.Cryptography.HashAlgorithm): System.Byte[] use System.Security.Cryptography.AsymmetricSignatureFormatter"
		alias
			"CreateSignature"
		end

end -- class SYSTEM_SECURITY_CRYPTOGRAPHY_ASYMMETRICSIGNATUREFORMATTER
