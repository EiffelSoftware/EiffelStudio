indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Security.Cryptography.DSASignatureFormatter"

external class
	SYSTEM_SECURITY_CRYPTOGRAPHY_DSASIGNATUREFORMATTER

inherit
	SYSTEM_SECURITY_CRYPTOGRAPHY_ASYMMETRICSIGNATUREFORMATTER

create
	make_dsasignatureformatter_1,
	make_dsasignatureformatter

feature {NONE} -- Initialization

	frozen make_dsasignatureformatter_1 (key: SYSTEM_SECURITY_CRYPTOGRAPHY_ASYMMETRICALGORITHM) is
		external
			"IL creator signature (System.Security.Cryptography.AsymmetricAlgorithm) use System.Security.Cryptography.DSASignatureFormatter"
		end

	frozen make_dsasignatureformatter is
		external
			"IL creator use System.Security.Cryptography.DSASignatureFormatter"
		end

feature -- Basic Operations

	create_signature_array_byte (rgb_hash: ARRAY [INTEGER_8]): ARRAY [INTEGER_8] is
		external
			"IL signature (System.Byte[]): System.Byte[] use System.Security.Cryptography.DSASignatureFormatter"
		alias
			"CreateSignature"
		end

	set_hash_algorithm (str_name: STRING) is
		external
			"IL signature (System.String): System.Void use System.Security.Cryptography.DSASignatureFormatter"
		alias
			"SetHashAlgorithm"
		end

	set_key (key: SYSTEM_SECURITY_CRYPTOGRAPHY_ASYMMETRICALGORITHM) is
		external
			"IL signature (System.Security.Cryptography.AsymmetricAlgorithm): System.Void use System.Security.Cryptography.DSASignatureFormatter"
		alias
			"SetKey"
		end

end -- class SYSTEM_SECURITY_CRYPTOGRAPHY_DSASIGNATUREFORMATTER
