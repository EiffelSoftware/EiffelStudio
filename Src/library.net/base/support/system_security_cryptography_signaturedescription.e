indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Security.Cryptography.SignatureDescription"

external class
	SYSTEM_SECURITY_CRYPTOGRAPHY_SIGNATUREDESCRIPTION

create
	make

feature {NONE} -- Initialization

	frozen make (el: SYSTEM_SECURITY_SECURITYELEMENT) is
		external
			"IL creator signature (System.Security.SecurityElement) use System.Security.Cryptography.SignatureDescription"
		end

feature -- Access

	frozen get_formatter_algorithm: STRING is
		external
			"IL signature (): System.String use System.Security.Cryptography.SignatureDescription"
		alias
			"get_FormatterAlgorithm"
		end

	frozen get_deformatter_algorithm: STRING is
		external
			"IL signature (): System.String use System.Security.Cryptography.SignatureDescription"
		alias
			"get_DeformatterAlgorithm"
		end

	frozen get_key_algorithm: STRING is
		external
			"IL signature (): System.String use System.Security.Cryptography.SignatureDescription"
		alias
			"get_KeyAlgorithm"
		end

	frozen get_digest_algorithm: STRING is
		external
			"IL signature (): System.String use System.Security.Cryptography.SignatureDescription"
		alias
			"get_DigestAlgorithm"
		end

feature -- Element Change

	frozen set_digest_algorithm (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Security.Cryptography.SignatureDescription"
		alias
			"set_DigestAlgorithm"
		end

	frozen set_deformatter_algorithm (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Security.Cryptography.SignatureDescription"
		alias
			"set_DeformatterAlgorithm"
		end

	frozen set_formatter_algorithm (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Security.Cryptography.SignatureDescription"
		alias
			"set_FormatterAlgorithm"
		end

	frozen set_key_algorithm (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Security.Cryptography.SignatureDescription"
		alias
			"set_KeyAlgorithm"
		end

feature -- Basic Operations

	create_formatter (key: SYSTEM_SECURITY_CRYPTOGRAPHY_ASYMMETRICALGORITHM): SYSTEM_SECURITY_CRYPTOGRAPHY_ASYMMETRICSIGNATUREFORMATTER is
		external
			"IL signature (System.Security.Cryptography.AsymmetricAlgorithm): System.Security.Cryptography.AsymmetricSignatureFormatter use System.Security.Cryptography.SignatureDescription"
		alias
			"CreateFormatter"
		end

	create_deformatter (key: SYSTEM_SECURITY_CRYPTOGRAPHY_ASYMMETRICALGORITHM): SYSTEM_SECURITY_CRYPTOGRAPHY_ASYMMETRICSIGNATUREDEFORMATTER is
		external
			"IL signature (System.Security.Cryptography.AsymmetricAlgorithm): System.Security.Cryptography.AsymmetricSignatureDeformatter use System.Security.Cryptography.SignatureDescription"
		alias
			"CreateDeformatter"
		end

	create_digest: SYSTEM_SECURITY_CRYPTOGRAPHY_HASHALGORITHM is
		external
			"IL signature (): System.Security.Cryptography.HashAlgorithm use System.Security.Cryptography.SignatureDescription"
		alias
			"CreateDigest"
		end

end -- class SYSTEM_SECURITY_CRYPTOGRAPHY_SIGNATUREDESCRIPTION
