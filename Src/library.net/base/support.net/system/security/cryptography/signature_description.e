indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Security.Cryptography.SignatureDescription"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SIGNATURE_DESCRIPTION

inherit
	SYSTEM_OBJECT

create
	make,
	make_1

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.Security.Cryptography.SignatureDescription"
		end

	frozen make_1 (el: SECURITY_ELEMENT) is
		external
			"IL creator signature (System.Security.SecurityElement) use System.Security.Cryptography.SignatureDescription"
		end

feature -- Access

	frozen get_formatter_algorithm: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Security.Cryptography.SignatureDescription"
		alias
			"get_FormatterAlgorithm"
		end

	frozen get_deformatter_algorithm: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Security.Cryptography.SignatureDescription"
		alias
			"get_DeformatterAlgorithm"
		end

	frozen get_key_algorithm: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Security.Cryptography.SignatureDescription"
		alias
			"get_KeyAlgorithm"
		end

	frozen get_digest_algorithm: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Security.Cryptography.SignatureDescription"
		alias
			"get_DigestAlgorithm"
		end

feature -- Element Change

	frozen set_digest_algorithm (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Security.Cryptography.SignatureDescription"
		alias
			"set_DigestAlgorithm"
		end

	frozen set_deformatter_algorithm (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Security.Cryptography.SignatureDescription"
		alias
			"set_DeformatterAlgorithm"
		end

	frozen set_formatter_algorithm (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Security.Cryptography.SignatureDescription"
		alias
			"set_FormatterAlgorithm"
		end

	frozen set_key_algorithm (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Security.Cryptography.SignatureDescription"
		alias
			"set_KeyAlgorithm"
		end

feature -- Basic Operations

	create_formatter (key: ASYMMETRIC_ALGORITHM): ASYMMETRIC_SIGNATURE_FORMATTER is
		external
			"IL signature (System.Security.Cryptography.AsymmetricAlgorithm): System.Security.Cryptography.AsymmetricSignatureFormatter use System.Security.Cryptography.SignatureDescription"
		alias
			"CreateFormatter"
		end

	create_deformatter (key: ASYMMETRIC_ALGORITHM): ASYMMETRIC_SIGNATURE_DEFORMATTER is
		external
			"IL signature (System.Security.Cryptography.AsymmetricAlgorithm): System.Security.Cryptography.AsymmetricSignatureDeformatter use System.Security.Cryptography.SignatureDescription"
		alias
			"CreateDeformatter"
		end

	create_digest: HASH_ALGORITHM is
		external
			"IL signature (): System.Security.Cryptography.HashAlgorithm use System.Security.Cryptography.SignatureDescription"
		alias
			"CreateDigest"
		end

end -- class SIGNATURE_DESCRIPTION
