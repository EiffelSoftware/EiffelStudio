indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Security.Cryptography.RSAPKCS1SignatureFormatter"

external class
	SYSTEM_SECURITY_CRYPTOGRAPHY_RSAPKCS1SIGNATUREFORMATTER

inherit
	SYSTEM_SECURITY_CRYPTOGRAPHY_ASYMMETRICSIGNATUREFORMATTER

create
	make_rsapkcs1signatureformatter_1,
	make_rsapkcs1signatureformatter

feature {NONE} -- Initialization

	frozen make_rsapkcs1signatureformatter_1 (key: SYSTEM_SECURITY_CRYPTOGRAPHY_ASYMMETRICALGORITHM) is
		external
			"IL creator signature (System.Security.Cryptography.AsymmetricAlgorithm) use System.Security.Cryptography.RSAPKCS1SignatureFormatter"
		end

	frozen make_rsapkcs1signatureformatter is
		external
			"IL creator use System.Security.Cryptography.RSAPKCS1SignatureFormatter"
		end

feature -- Basic Operations

	create_signature_array_byte (rgb_hash: ARRAY [INTEGER_8]): ARRAY [INTEGER_8] is
		external
			"IL signature (System.Byte[]): System.Byte[] use System.Security.Cryptography.RSAPKCS1SignatureFormatter"
		alias
			"CreateSignature"
		end

	set_hash_algorithm (str_name: STRING) is
		external
			"IL signature (System.String): System.Void use System.Security.Cryptography.RSAPKCS1SignatureFormatter"
		alias
			"SetHashAlgorithm"
		end

	set_key (key: SYSTEM_SECURITY_CRYPTOGRAPHY_ASYMMETRICALGORITHM) is
		external
			"IL signature (System.Security.Cryptography.AsymmetricAlgorithm): System.Void use System.Security.Cryptography.RSAPKCS1SignatureFormatter"
		alias
			"SetKey"
		end

end -- class SYSTEM_SECURITY_CRYPTOGRAPHY_RSAPKCS1SIGNATUREFORMATTER
