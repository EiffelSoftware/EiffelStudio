indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Security.Cryptography.RSA"

deferred external class
	SYSTEM_SECURITY_CRYPTOGRAPHY_RSA

inherit
	SYSTEM_SECURITY_CRYPTOGRAPHY_ASYMMETRICALGORITHM

feature -- Basic Operations

	export_parameters (include_private_parameters: BOOLEAN): SYSTEM_SECURITY_CRYPTOGRAPHY_RSAPARAMETERS is
		external
			"IL deferred signature (System.Boolean): System.Security.Cryptography.RSAParameters use System.Security.Cryptography.RSA"
		alias
			"ExportParameters"
		end

	import_parameters (parameters: SYSTEM_SECURITY_CRYPTOGRAPHY_RSAPARAMETERS) is
		external
			"IL deferred signature (System.Security.Cryptography.RSAParameters): System.Void use System.Security.Cryptography.RSA"
		alias
			"ImportParameters"
		end

	from_xml_string (xml_string: STRING) is
		external
			"IL signature (System.String): System.Void use System.Security.Cryptography.RSA"
		alias
			"FromXmlString"
		end

	frozen create__string2 (alg_name: STRING): SYSTEM_SECURITY_CRYPTOGRAPHY_RSA is
		external
			"IL static signature (System.String): System.Security.Cryptography.RSA use System.Security.Cryptography.RSA"
		alias
			"Create"
		end

	encrypt_value (rgb: ARRAY [INTEGER_8]): ARRAY [INTEGER_8] is
		external
			"IL deferred signature (System.Byte[]): System.Byte[] use System.Security.Cryptography.RSA"
		alias
			"EncryptValue"
		end

	decrypt_value (rgb: ARRAY [INTEGER_8]): ARRAY [INTEGER_8] is
		external
			"IL deferred signature (System.Byte[]): System.Byte[] use System.Security.Cryptography.RSA"
		alias
			"DecryptValue"
		end

	to_xml_string (include_private_parameters: BOOLEAN): STRING is
		external
			"IL signature (System.Boolean): System.String use System.Security.Cryptography.RSA"
		alias
			"ToXmlString"
		end

	frozen create__rsa: SYSTEM_SECURITY_CRYPTOGRAPHY_RSA is
		external
			"IL static signature (): System.Security.Cryptography.RSA use System.Security.Cryptography.RSA"
		alias
			"Create"
		end

end -- class SYSTEM_SECURITY_CRYPTOGRAPHY_RSA
