indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Security.Cryptography.RSAPKCS1SignatureDeformatter"

external class
	SYSTEM_SECURITY_CRYPTOGRAPHY_RSAPKCS1SIGNATUREDEFORMATTER

inherit
	SYSTEM_SECURITY_CRYPTOGRAPHY_ASYMMETRICSIGNATUREDEFORMATTER

create
	make_rsapkcs1signaturedeformatter_1,
	make_rsapkcs1signaturedeformatter

feature {NONE} -- Initialization

	frozen make_rsapkcs1signaturedeformatter_1 (key: SYSTEM_SECURITY_CRYPTOGRAPHY_ASYMMETRICALGORITHM) is
		external
			"IL creator signature (System.Security.Cryptography.AsymmetricAlgorithm) use System.Security.Cryptography.RSAPKCS1SignatureDeformatter"
		end

	frozen make_rsapkcs1signaturedeformatter is
		external
			"IL creator use System.Security.Cryptography.RSAPKCS1SignatureDeformatter"
		end

feature -- Basic Operations

	set_hash_algorithm (str_name: STRING) is
		external
			"IL signature (System.String): System.Void use System.Security.Cryptography.RSAPKCS1SignatureDeformatter"
		alias
			"SetHashAlgorithm"
		end

	verify_signature_array_byte (rgb_hash: ARRAY [INTEGER_8]; rgb_signature: ARRAY [INTEGER_8]): BOOLEAN is
		external
			"IL signature (System.Byte[], System.Byte[]): System.Boolean use System.Security.Cryptography.RSAPKCS1SignatureDeformatter"
		alias
			"VerifySignature"
		end

	set_key (key: SYSTEM_SECURITY_CRYPTOGRAPHY_ASYMMETRICALGORITHM) is
		external
			"IL signature (System.Security.Cryptography.AsymmetricAlgorithm): System.Void use System.Security.Cryptography.RSAPKCS1SignatureDeformatter"
		alias
			"SetKey"
		end

end -- class SYSTEM_SECURITY_CRYPTOGRAPHY_RSAPKCS1SIGNATUREDEFORMATTER
