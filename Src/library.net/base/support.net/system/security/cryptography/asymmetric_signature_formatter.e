indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Security.Cryptography.AsymmetricSignatureFormatter"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	ASYMMETRIC_SIGNATURE_FORMATTER

inherit
	SYSTEM_OBJECT

feature -- Basic Operations

	create_signature_array_byte (rgb_hash: NATIVE_ARRAY [INTEGER_8]): NATIVE_ARRAY [INTEGER_8] is
		external
			"IL deferred signature (System.Byte[]): System.Byte[] use System.Security.Cryptography.AsymmetricSignatureFormatter"
		alias
			"CreateSignature"
		end

	set_hash_algorithm (str_name: SYSTEM_STRING) is
		external
			"IL deferred signature (System.String): System.Void use System.Security.Cryptography.AsymmetricSignatureFormatter"
		alias
			"SetHashAlgorithm"
		end

	set_key (key: ASYMMETRIC_ALGORITHM) is
		external
			"IL deferred signature (System.Security.Cryptography.AsymmetricAlgorithm): System.Void use System.Security.Cryptography.AsymmetricSignatureFormatter"
		alias
			"SetKey"
		end

	create_signature (hash: HASH_ALGORITHM): NATIVE_ARRAY [INTEGER_8] is
		external
			"IL signature (System.Security.Cryptography.HashAlgorithm): System.Byte[] use System.Security.Cryptography.AsymmetricSignatureFormatter"
		alias
			"CreateSignature"
		end

end -- class ASYMMETRIC_SIGNATURE_FORMATTER
