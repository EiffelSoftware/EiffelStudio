indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Security.Cryptography.RSA"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	RSA

inherit
	ASYMMETRIC_ALGORITHM
	IDISPOSABLE
		rename
			dispose as system_idisposable_dispose
		end

feature -- Basic Operations

	export_parameters (include_private_parameters: BOOLEAN): RSAPARAMETERS is
		external
			"IL deferred signature (System.Boolean): System.Security.Cryptography.RSAParameters use System.Security.Cryptography.RSA"
		alias
			"ExportParameters"
		end

	import_parameters (parameters: RSAPARAMETERS) is
		external
			"IL deferred signature (System.Security.Cryptography.RSAParameters): System.Void use System.Security.Cryptography.RSA"
		alias
			"ImportParameters"
		end

	from_xml_string (xml_string: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Security.Cryptography.RSA"
		alias
			"FromXmlString"
		end

	frozen create__string2 (alg_name: SYSTEM_STRING): RSA is
		external
			"IL static signature (System.String): System.Security.Cryptography.RSA use System.Security.Cryptography.RSA"
		alias
			"Create"
		end

	encrypt_value (rgb: NATIVE_ARRAY [INTEGER_8]): NATIVE_ARRAY [INTEGER_8] is
		external
			"IL deferred signature (System.Byte[]): System.Byte[] use System.Security.Cryptography.RSA"
		alias
			"EncryptValue"
		end

	decrypt_value (rgb: NATIVE_ARRAY [INTEGER_8]): NATIVE_ARRAY [INTEGER_8] is
		external
			"IL deferred signature (System.Byte[]): System.Byte[] use System.Security.Cryptography.RSA"
		alias
			"DecryptValue"
		end

	to_xml_string (include_private_parameters: BOOLEAN): SYSTEM_STRING is
		external
			"IL signature (System.Boolean): System.String use System.Security.Cryptography.RSA"
		alias
			"ToXmlString"
		end

	frozen create__rsa: RSA is
		external
			"IL static signature (): System.Security.Cryptography.RSA use System.Security.Cryptography.RSA"
		alias
			"Create"
		end

end -- class RSA
