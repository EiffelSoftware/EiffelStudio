indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Security.Cryptography.DSACryptoServiceProvider"

external class
	SYSTEM_SECURITY_CRYPTOGRAPHY_DSACRYPTOSERVICEPROVIDER

inherit
	SYSTEM_SECURITY_CRYPTOGRAPHY_DSA
		redefine
			get_legal_key_sizes,
			get_key_size,
			finalize
		end

create
	make_dsacryptoserviceprovider_1,
	make_dsacryptoserviceprovider,
	make_dsacryptoserviceprovider_3,
	make_dsacryptoserviceprovider_2

feature {NONE} -- Initialization

	frozen make_dsacryptoserviceprovider_1 (dw_key_size: INTEGER) is
		external
			"IL creator signature (System.Int32) use System.Security.Cryptography.DSACryptoServiceProvider"
		end

	frozen make_dsacryptoserviceprovider is
		external
			"IL creator use System.Security.Cryptography.DSACryptoServiceProvider"
		end

	frozen make_dsacryptoserviceprovider_3 (dw_key_size: INTEGER; parameters: SYSTEM_SECURITY_CRYPTOGRAPHY_CSPPARAMETERS) is
		external
			"IL creator signature (System.Int32, System.Security.Cryptography.CspParameters) use System.Security.Cryptography.DSACryptoServiceProvider"
		end

	frozen make_dsacryptoserviceprovider_2 (parameters: SYSTEM_SECURITY_CRYPTOGRAPHY_CSPPARAMETERS) is
		external
			"IL creator signature (System.Security.Cryptography.CspParameters) use System.Security.Cryptography.DSACryptoServiceProvider"
		end

feature -- Access

	frozen get_persist_key_in_csp: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Security.Cryptography.DSACryptoServiceProvider"
		alias
			"get_PersistKeyInCsp"
		end

	get_signature_algorithm: STRING is
		external
			"IL signature (): System.String use System.Security.Cryptography.DSACryptoServiceProvider"
		alias
			"get_SignatureAlgorithm"
		end

	get_key_size: INTEGER is
		external
			"IL signature (): System.Int32 use System.Security.Cryptography.DSACryptoServiceProvider"
		alias
			"get_KeySize"
		end

	get_legal_key_sizes: ARRAY [SYSTEM_SECURITY_CRYPTOGRAPHY_KEYSIZES] is
		external
			"IL signature (): System.Security.Cryptography.KeySizes[] use System.Security.Cryptography.DSACryptoServiceProvider"
		alias
			"get_LegalKeySizes"
		end

	get_key_exchange_algorithm: STRING is
		external
			"IL signature (): System.String use System.Security.Cryptography.DSACryptoServiceProvider"
		alias
			"get_KeyExchangeAlgorithm"
		end

feature -- Element Change

	frozen set_persist_key_in_csp (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Security.Cryptography.DSACryptoServiceProvider"
		alias
			"set_PersistKeyInCsp"
		end

feature -- Basic Operations

	export_parameters (include_private_parameters: BOOLEAN): SYSTEM_SECURITY_CRYPTOGRAPHY_DSAPARAMETERS is
		external
			"IL signature (System.Boolean): System.Security.Cryptography.DSAParameters use System.Security.Cryptography.DSACryptoServiceProvider"
		alias
			"ExportParameters"
		end

	frozen verify_data (rgb_data: ARRAY [INTEGER_8]; rgb_signature: ARRAY [INTEGER_8]): BOOLEAN is
		external
			"IL signature (System.Byte[], System.Byte[]): System.Boolean use System.Security.Cryptography.DSACryptoServiceProvider"
		alias
			"VerifyData"
		end

	import_parameters (parameters: SYSTEM_SECURITY_CRYPTOGRAPHY_DSAPARAMETERS) is
		external
			"IL signature (System.Security.Cryptography.DSAParameters): System.Void use System.Security.Cryptography.DSACryptoServiceProvider"
		alias
			"ImportParameters"
		end

	create_signature (rgb_hash: ARRAY [INTEGER_8]): ARRAY [INTEGER_8] is
		external
			"IL signature (System.Byte[]): System.Byte[] use System.Security.Cryptography.DSACryptoServiceProvider"
		alias
			"CreateSignature"
		end

	frozen sign_data_stream (input_stream: SYSTEM_IO_STREAM): ARRAY [INTEGER_8] is
		external
			"IL signature (System.IO.Stream): System.Byte[] use System.Security.Cryptography.DSACryptoServiceProvider"
		alias
			"SignData"
		end

	frozen sign_data_array_byte_int32 (buffer: ARRAY [INTEGER_8]; offset: INTEGER; count: INTEGER): ARRAY [INTEGER_8] is
		external
			"IL signature (System.Byte[], System.Int32, System.Int32): System.Byte[] use System.Security.Cryptography.DSACryptoServiceProvider"
		alias
			"SignData"
		end

	verify_signature (rgb_hash: ARRAY [INTEGER_8]; rgb_signature: ARRAY [INTEGER_8]): BOOLEAN is
		external
			"IL signature (System.Byte[], System.Byte[]): System.Boolean use System.Security.Cryptography.DSACryptoServiceProvider"
		alias
			"VerifySignature"
		end

	frozen sign_hash (rgb_hash: ARRAY [INTEGER_8]; str: STRING): ARRAY [INTEGER_8] is
		external
			"IL signature (System.Byte[], System.String): System.Byte[] use System.Security.Cryptography.DSACryptoServiceProvider"
		alias
			"SignHash"
		end

	frozen sign_data (buffer: ARRAY [INTEGER_8]): ARRAY [INTEGER_8] is
		external
			"IL signature (System.Byte[]): System.Byte[] use System.Security.Cryptography.DSACryptoServiceProvider"
		alias
			"SignData"
		end

	frozen verify_hash (rgb_hash: ARRAY [INTEGER_8]; str: STRING; rgb_signature: ARRAY [INTEGER_8]): BOOLEAN is
		external
			"IL signature (System.Byte[], System.String, System.Byte[]): System.Boolean use System.Security.Cryptography.DSACryptoServiceProvider"
		alias
			"VerifyHash"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use System.Security.Cryptography.DSACryptoServiceProvider"
		alias
			"Finalize"
		end

end -- class SYSTEM_SECURITY_CRYPTOGRAPHY_DSACRYPTOSERVICEPROVIDER
