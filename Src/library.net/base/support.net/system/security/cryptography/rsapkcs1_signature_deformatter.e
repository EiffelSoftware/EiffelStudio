indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Security.Cryptography.RSAPKCS1SignatureDeformatter"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	RSAPKCS1_SIGNATURE_DEFORMATTER

inherit
	ASYMMETRIC_SIGNATURE_DEFORMATTER

create
	make_rsapkcs1_signature_deformatter_1,
	make_rsapkcs1_signature_deformatter

feature {NONE} -- Initialization

	frozen make_rsapkcs1_signature_deformatter_1 (key: ASYMMETRIC_ALGORITHM) is
		external
			"IL creator signature (System.Security.Cryptography.AsymmetricAlgorithm) use System.Security.Cryptography.RSAPKCS1SignatureDeformatter"
		end

	frozen make_rsapkcs1_signature_deformatter is
		external
			"IL creator use System.Security.Cryptography.RSAPKCS1SignatureDeformatter"
		end

feature -- Basic Operations

	set_hash_algorithm (str_name: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Security.Cryptography.RSAPKCS1SignatureDeformatter"
		alias
			"SetHashAlgorithm"
		end

	verify_signature_array_byte (rgb_hash: NATIVE_ARRAY [INTEGER_8]; rgb_signature: NATIVE_ARRAY [INTEGER_8]): BOOLEAN is
		external
			"IL signature (System.Byte[], System.Byte[]): System.Boolean use System.Security.Cryptography.RSAPKCS1SignatureDeformatter"
		alias
			"VerifySignature"
		end

	set_key (key: ASYMMETRIC_ALGORITHM) is
		external
			"IL signature (System.Security.Cryptography.AsymmetricAlgorithm): System.Void use System.Security.Cryptography.RSAPKCS1SignatureDeformatter"
		alias
			"SetKey"
		end

end -- class RSAPKCS1_SIGNATURE_DEFORMATTER
