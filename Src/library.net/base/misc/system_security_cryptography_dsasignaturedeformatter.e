indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Security.Cryptography.DSASignatureDeformatter"

external class
	SYSTEM_SECURITY_CRYPTOGRAPHY_DSASIGNATUREDEFORMATTER

inherit
	SYSTEM_SECURITY_CRYPTOGRAPHY_ASYMMETRICSIGNATUREDEFORMATTER

create
	make_dsasignaturedeformatter,
	make_dsasignaturedeformatter_1

feature {NONE} -- Initialization

	frozen make_dsasignaturedeformatter is
		external
			"IL creator use System.Security.Cryptography.DSASignatureDeformatter"
		end

	frozen make_dsasignaturedeformatter_1 (key: SYSTEM_SECURITY_CRYPTOGRAPHY_ASYMMETRICALGORITHM) is
		external
			"IL creator signature (System.Security.Cryptography.AsymmetricAlgorithm) use System.Security.Cryptography.DSASignatureDeformatter"
		end

feature -- Basic Operations

	set_hash_algorithm (str_name: STRING) is
		external
			"IL signature (System.String): System.Void use System.Security.Cryptography.DSASignatureDeformatter"
		alias
			"SetHashAlgorithm"
		end

	verify_signature_array_byte (rgb_hash: ARRAY [INTEGER_8]; rgb_signature: ARRAY [INTEGER_8]): BOOLEAN is
		external
			"IL signature (System.Byte[], System.Byte[]): System.Boolean use System.Security.Cryptography.DSASignatureDeformatter"
		alias
			"VerifySignature"
		end

	set_key (key: SYSTEM_SECURITY_CRYPTOGRAPHY_ASYMMETRICALGORITHM) is
		external
			"IL signature (System.Security.Cryptography.AsymmetricAlgorithm): System.Void use System.Security.Cryptography.DSASignatureDeformatter"
		alias
			"SetKey"
		end

end -- class SYSTEM_SECURITY_CRYPTOGRAPHY_DSASIGNATUREDEFORMATTER
