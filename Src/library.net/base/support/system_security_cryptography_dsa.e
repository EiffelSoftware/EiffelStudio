indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Security.Cryptography.DSA"

deferred external class
	SYSTEM_SECURITY_CRYPTOGRAPHY_DSA

inherit
	SYSTEM_SECURITY_CRYPTOGRAPHY_ASYMMETRICALGORITHM

feature -- Basic Operations

	export_parameters (include_private_parameters: BOOLEAN): SYSTEM_SECURITY_CRYPTOGRAPHY_DSAPARAMETERS is
		external
			"IL deferred signature (System.Boolean): System.Security.Cryptography.DSAParameters use System.Security.Cryptography.DSA"
		alias
			"ExportParameters"
		end

	frozen create__string2 (alg_name: STRING): SYSTEM_SECURITY_CRYPTOGRAPHY_DSA is
		external
			"IL static signature (System.String): System.Security.Cryptography.DSA use System.Security.Cryptography.DSA"
		alias
			"Create"
		end

	import_parameters (parameters: SYSTEM_SECURITY_CRYPTOGRAPHY_DSAPARAMETERS) is
		external
			"IL deferred signature (System.Security.Cryptography.DSAParameters): System.Void use System.Security.Cryptography.DSA"
		alias
			"ImportParameters"
		end

	from_xml_string (xml_string: STRING) is
		external
			"IL signature (System.String): System.Void use System.Security.Cryptography.DSA"
		alias
			"FromXmlString"
		end

	create_signature (rgb_hash: ARRAY [INTEGER_8]): ARRAY [INTEGER_8] is
		external
			"IL deferred signature (System.Byte[]): System.Byte[] use System.Security.Cryptography.DSA"
		alias
			"CreateSignature"
		end

	verify_signature (rgb_hash: ARRAY [INTEGER_8]; rgb_signature: ARRAY [INTEGER_8]): BOOLEAN is
		external
			"IL deferred signature (System.Byte[], System.Byte[]): System.Boolean use System.Security.Cryptography.DSA"
		alias
			"VerifySignature"
		end

	frozen create__dsa: SYSTEM_SECURITY_CRYPTOGRAPHY_DSA is
		external
			"IL static signature (): System.Security.Cryptography.DSA use System.Security.Cryptography.DSA"
		alias
			"Create"
		end

	to_xml_string (include_private_parameters: BOOLEAN): STRING is
		external
			"IL signature (System.Boolean): System.String use System.Security.Cryptography.DSA"
		alias
			"ToXmlString"
		end

end -- class SYSTEM_SECURITY_CRYPTOGRAPHY_DSA
