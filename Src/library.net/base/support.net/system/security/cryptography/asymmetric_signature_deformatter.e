indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Security.Cryptography.AsymmetricSignatureDeformatter"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	ASYMMETRIC_SIGNATURE_DEFORMATTER

inherit
	SYSTEM_OBJECT

feature -- Basic Operations

	set_hash_algorithm (str_name: SYSTEM_STRING) is
		external
			"IL deferred signature (System.String): System.Void use System.Security.Cryptography.AsymmetricSignatureDeformatter"
		alias
			"SetHashAlgorithm"
		end

	verify_signature (hash: HASH_ALGORITHM; rgb_signature: NATIVE_ARRAY [INTEGER_8]): BOOLEAN is
		external
			"IL signature (System.Security.Cryptography.HashAlgorithm, System.Byte[]): System.Boolean use System.Security.Cryptography.AsymmetricSignatureDeformatter"
		alias
			"VerifySignature"
		end

	verify_signature_array_byte (rgb_hash: NATIVE_ARRAY [INTEGER_8]; rgb_signature: NATIVE_ARRAY [INTEGER_8]): BOOLEAN is
		external
			"IL deferred signature (System.Byte[], System.Byte[]): System.Boolean use System.Security.Cryptography.AsymmetricSignatureDeformatter"
		alias
			"VerifySignature"
		end

	set_key (key: ASYMMETRIC_ALGORITHM) is
		external
			"IL deferred signature (System.Security.Cryptography.AsymmetricAlgorithm): System.Void use System.Security.Cryptography.AsymmetricSignatureDeformatter"
		alias
			"SetKey"
		end

end -- class ASYMMETRIC_SIGNATURE_DEFORMATTER
