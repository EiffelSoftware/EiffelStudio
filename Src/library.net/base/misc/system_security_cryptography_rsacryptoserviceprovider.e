indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Security.Cryptography.RSACryptoServiceProvider"

frozen external class
	SYSTEM_SECURITY_CRYPTOGRAPHY_RSACRYPTOSERVICEPROVIDER

inherit
	SYSTEM_SECURITY_CRYPTOGRAPHY_RSA
		redefine
			get_key_size,
			finalize
		end

create
	make_rsacryptoserviceprovider_3,
	make_rsacryptoserviceprovider_2,
	make_rsacryptoserviceprovider_1,
	make_rsacryptoserviceprovider

feature {NONE} -- Initialization

	frozen make_rsacryptoserviceprovider_3 (dw_key_size: INTEGER; parameters: SYSTEM_SECURITY_CRYPTOGRAPHY_CSPPARAMETERS) is
		external
			"IL creator signature (System.Int32, System.Security.Cryptography.CspParameters) use System.Security.Cryptography.RSACryptoServiceProvider"
		end

	frozen make_rsacryptoserviceprovider_2 (parameters: SYSTEM_SECURITY_CRYPTOGRAPHY_CSPPARAMETERS) is
		external
			"IL creator signature (System.Security.Cryptography.CspParameters) use System.Security.Cryptography.RSACryptoServiceProvider"
		end

	frozen make_rsacryptoserviceprovider_1 (dw_key_size: INTEGER) is
		external
			"IL creator signature (System.Int32) use System.Security.Cryptography.RSACryptoServiceProvider"
		end

	frozen make_rsacryptoserviceprovider is
		external
			"IL creator use System.Security.Cryptography.RSACryptoServiceProvider"
		end

feature -- Access

	frozen get_persist_key_in_csp: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Security.Cryptography.RSACryptoServiceProvider"
		alias
			"get_PersistKeyInCsp"
		end

	get_signature_algorithm: STRING is
		external
			"IL signature (): System.String use System.Security.Cryptography.RSACryptoServiceProvider"
		alias
			"get_SignatureAlgorithm"
		end

	get_key_size: INTEGER is
		external
			"IL signature (): System.Int32 use System.Security.Cryptography.RSACryptoServiceProvider"
		alias
			"get_KeySize"
		end

	get_key_exchange_algorithm: STRING is
		external
			"IL signature (): System.String use System.Security.Cryptography.RSACryptoServiceProvider"
		alias
			"get_KeyExchangeAlgorithm"
		end

feature -- Element Change

	frozen set_persist_key_in_csp (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Security.Cryptography.RSACryptoServiceProvider"
		alias
			"set_PersistKeyInCsp"
		end

feature -- Basic Operations

	export_parameters (include_private_parameters: BOOLEAN): SYSTEM_SECURITY_CRYPTOGRAPHY_RSAPARAMETERS is
		external
			"IL signature (System.Boolean): System.Security.Cryptography.RSAParameters use System.Security.Cryptography.RSACryptoServiceProvider"
		alias
			"ExportParameters"
		end

	frozen decrypt (rgb: ARRAY [INTEGER_8]; f_oaep: BOOLEAN): ARRAY [INTEGER_8] is
		external
			"IL signature (System.Byte[], System.Boolean): System.Byte[] use System.Security.Cryptography.RSACryptoServiceProvider"
		alias
			"Decrypt"
		end

	frozen verify_data (rgb_data: ARRAY [INTEGER_8]; halg: ANY; rgb_signature: ARRAY [INTEGER_8]): BOOLEAN is
		external
			"IL signature (System.Byte[], System.Object, System.Byte[]): System.Boolean use System.Security.Cryptography.RSACryptoServiceProvider"
		alias
			"VerifyData"
		end

	import_parameters (parameters: SYSTEM_SECURITY_CRYPTOGRAPHY_RSAPARAMETERS) is
		external
			"IL signature (System.Security.Cryptography.RSAParameters): System.Void use System.Security.Cryptography.RSACryptoServiceProvider"
		alias
			"ImportParameters"
		end

	frozen verify_hash (rgb_hash: ARRAY [INTEGER_8]; str: STRING; rgb_signature: ARRAY [INTEGER_8]): BOOLEAN is
		external
			"IL signature (System.Byte[], System.String, System.Byte[]): System.Boolean use System.Security.Cryptography.RSACryptoServiceProvider"
		alias
			"VerifyHash"
		end

	frozen sign_data_stream (input_stream: SYSTEM_IO_STREAM; halg: ANY): ARRAY [INTEGER_8] is
		external
			"IL signature (System.IO.Stream, System.Object): System.Byte[] use System.Security.Cryptography.RSACryptoServiceProvider"
		alias
			"SignData"
		end

	frozen sign_data_array_byte_int32 (buffer: ARRAY [INTEGER_8]; offset: INTEGER; count: INTEGER; halg: ANY): ARRAY [INTEGER_8] is
		external
			"IL signature (System.Byte[], System.Int32, System.Int32, System.Object): System.Byte[] use System.Security.Cryptography.RSACryptoServiceProvider"
		alias
			"SignData"
		end

	frozen sign_hash (rgb_hash: ARRAY [INTEGER_8]; str: STRING): ARRAY [INTEGER_8] is
		external
			"IL signature (System.Byte[], System.String): System.Byte[] use System.Security.Cryptography.RSACryptoServiceProvider"
		alias
			"SignHash"
		end

	encrypt_value (rgb: ARRAY [INTEGER_8]): ARRAY [INTEGER_8] is
		external
			"IL signature (System.Byte[]): System.Byte[] use System.Security.Cryptography.RSACryptoServiceProvider"
		alias
			"EncryptValue"
		end

	frozen sign_data (buffer: ARRAY [INTEGER_8]; halg: ANY): ARRAY [INTEGER_8] is
		external
			"IL signature (System.Byte[], System.Object): System.Byte[] use System.Security.Cryptography.RSACryptoServiceProvider"
		alias
			"SignData"
		end

	decrypt_value (rgb: ARRAY [INTEGER_8]): ARRAY [INTEGER_8] is
		external
			"IL signature (System.Byte[]): System.Byte[] use System.Security.Cryptography.RSACryptoServiceProvider"
		alias
			"DecryptValue"
		end

	frozen encrypt (rgb: ARRAY [INTEGER_8]; f_oaep: BOOLEAN): ARRAY [INTEGER_8] is
		external
			"IL signature (System.Byte[], System.Boolean): System.Byte[] use System.Security.Cryptography.RSACryptoServiceProvider"
		alias
			"Encrypt"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use System.Security.Cryptography.RSACryptoServiceProvider"
		alias
			"Finalize"
		end

end -- class SYSTEM_SECURITY_CRYPTOGRAPHY_RSACRYPTOSERVICEPROVIDER
