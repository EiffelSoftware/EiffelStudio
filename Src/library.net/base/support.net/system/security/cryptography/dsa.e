indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Security.Cryptography.DSA"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	DSA

inherit
	ASYMMETRIC_ALGORITHM
	IDISPOSABLE
		rename
			dispose as system_idisposable_dispose
		end

feature -- Basic Operations

	export_parameters (include_private_parameters: BOOLEAN): DSAPARAMETERS is
		external
			"IL deferred signature (System.Boolean): System.Security.Cryptography.DSAParameters use System.Security.Cryptography.DSA"
		alias
			"ExportParameters"
		end

	frozen create__string2 (alg_name: SYSTEM_STRING): DSA is
		external
			"IL static signature (System.String): System.Security.Cryptography.DSA use System.Security.Cryptography.DSA"
		alias
			"Create"
		end

	import_parameters (parameters: DSAPARAMETERS) is
		external
			"IL deferred signature (System.Security.Cryptography.DSAParameters): System.Void use System.Security.Cryptography.DSA"
		alias
			"ImportParameters"
		end

	from_xml_string (xml_string: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Security.Cryptography.DSA"
		alias
			"FromXmlString"
		end

	create_signature (rgb_hash: NATIVE_ARRAY [INTEGER_8]): NATIVE_ARRAY [INTEGER_8] is
		external
			"IL deferred signature (System.Byte[]): System.Byte[] use System.Security.Cryptography.DSA"
		alias
			"CreateSignature"
		end

	verify_signature (rgb_hash: NATIVE_ARRAY [INTEGER_8]; rgb_signature: NATIVE_ARRAY [INTEGER_8]): BOOLEAN is
		external
			"IL deferred signature (System.Byte[], System.Byte[]): System.Boolean use System.Security.Cryptography.DSA"
		alias
			"VerifySignature"
		end

	frozen create__dsa: DSA is
		external
			"IL static signature (): System.Security.Cryptography.DSA use System.Security.Cryptography.DSA"
		alias
			"Create"
		end

	to_xml_string (include_private_parameters: BOOLEAN): SYSTEM_STRING is
		external
			"IL signature (System.Boolean): System.String use System.Security.Cryptography.DSA"
		alias
			"ToXmlString"
		end

end -- class DSA
