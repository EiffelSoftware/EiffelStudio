indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Security.Cryptography.DSASignatureFormatter"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	DSASIGNATURE_FORMATTER

inherit
	ASYMMETRIC_SIGNATURE_FORMATTER

create
	make_dsasignature_formatter,
	make_dsasignature_formatter_1

feature {NONE} -- Initialization

	frozen make_dsasignature_formatter is
		external
			"IL creator use System.Security.Cryptography.DSASignatureFormatter"
		end

	frozen make_dsasignature_formatter_1 (key: ASYMMETRIC_ALGORITHM) is
		external
			"IL creator signature (System.Security.Cryptography.AsymmetricAlgorithm) use System.Security.Cryptography.DSASignatureFormatter"
		end

feature -- Basic Operations

	create_signature_array_byte (rgb_hash: NATIVE_ARRAY [INTEGER_8]): NATIVE_ARRAY [INTEGER_8] is
		external
			"IL signature (System.Byte[]): System.Byte[] use System.Security.Cryptography.DSASignatureFormatter"
		alias
			"CreateSignature"
		end

	set_hash_algorithm (str_name: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Security.Cryptography.DSASignatureFormatter"
		alias
			"SetHashAlgorithm"
		end

	set_key (key: ASYMMETRIC_ALGORITHM) is
		external
			"IL signature (System.Security.Cryptography.AsymmetricAlgorithm): System.Void use System.Security.Cryptography.DSASignatureFormatter"
		alias
			"SetKey"
		end

end -- class DSASIGNATURE_FORMATTER
