indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Security.Cryptography.DSASignatureDeformatter"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	DSASIGNATURE_DEFORMATTER

inherit
	ASYMMETRIC_SIGNATURE_DEFORMATTER

create
	make_dsasignature_deformatter,
	make_dsasignature_deformatter_1

feature {NONE} -- Initialization

	frozen make_dsasignature_deformatter is
		external
			"IL creator use System.Security.Cryptography.DSASignatureDeformatter"
		end

	frozen make_dsasignature_deformatter_1 (key: ASYMMETRIC_ALGORITHM) is
		external
			"IL creator signature (System.Security.Cryptography.AsymmetricAlgorithm) use System.Security.Cryptography.DSASignatureDeformatter"
		end

feature -- Basic Operations

	set_hash_algorithm (str_name: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Security.Cryptography.DSASignatureDeformatter"
		alias
			"SetHashAlgorithm"
		end

	verify_signature_array_byte (rgb_hash: NATIVE_ARRAY [INTEGER_8]; rgb_signature: NATIVE_ARRAY [INTEGER_8]): BOOLEAN is
		external
			"IL signature (System.Byte[], System.Byte[]): System.Boolean use System.Security.Cryptography.DSASignatureDeformatter"
		alias
			"VerifySignature"
		end

	set_key (key: ASYMMETRIC_ALGORITHM) is
		external
			"IL signature (System.Security.Cryptography.AsymmetricAlgorithm): System.Void use System.Security.Cryptography.DSASignatureDeformatter"
		alias
			"SetKey"
		end

end -- class DSASIGNATURE_DEFORMATTER
