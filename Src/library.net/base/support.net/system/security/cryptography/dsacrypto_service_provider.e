indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Security.Cryptography.DSACryptoServiceProvider"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	DSACRYPTO_SERVICE_PROVIDER

inherit
	DSA
		redefine
			get_legal_key_sizes,
			get_key_size,
			finalize
		end
	IDISPOSABLE
		rename
			dispose as system_idisposable_dispose
		end

create
	make_dsacrypto_service_provider,
	make_dsacrypto_service_provider_1,
	make_dsacrypto_service_provider_3,
	make_dsacrypto_service_provider_2

feature {NONE} -- Initialization

	frozen make_dsacrypto_service_provider is
		external
			"IL creator use System.Security.Cryptography.DSACryptoServiceProvider"
		end

	frozen make_dsacrypto_service_provider_1 (dw_key_size: INTEGER) is
		external
			"IL creator signature (System.Int32) use System.Security.Cryptography.DSACryptoServiceProvider"
		end

	frozen make_dsacrypto_service_provider_3 (dw_key_size: INTEGER; parameters: CSP_PARAMETERS) is
		external
			"IL creator signature (System.Int32, System.Security.Cryptography.CspParameters) use System.Security.Cryptography.DSACryptoServiceProvider"
		end

	frozen make_dsacrypto_service_provider_2 (parameters: CSP_PARAMETERS) is
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

	get_signature_algorithm: SYSTEM_STRING is
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

	get_legal_key_sizes: NATIVE_ARRAY [KEY_SIZES] is
		external
			"IL signature (): System.Security.Cryptography.KeySizes[] use System.Security.Cryptography.DSACryptoServiceProvider"
		alias
			"get_LegalKeySizes"
		end

	get_key_exchange_algorithm: SYSTEM_STRING is
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

	export_parameters (include_private_parameters: BOOLEAN): DSAPARAMETERS is
		external
			"IL signature (System.Boolean): System.Security.Cryptography.DSAParameters use System.Security.Cryptography.DSACryptoServiceProvider"
		alias
			"ExportParameters"
		end

	frozen verify_data (rgb_data: NATIVE_ARRAY [INTEGER_8]; rgb_signature: NATIVE_ARRAY [INTEGER_8]): BOOLEAN is
		external
			"IL signature (System.Byte[], System.Byte[]): System.Boolean use System.Security.Cryptography.DSACryptoServiceProvider"
		alias
			"VerifyData"
		end

	import_parameters (parameters: DSAPARAMETERS) is
		external
			"IL signature (System.Security.Cryptography.DSAParameters): System.Void use System.Security.Cryptography.DSACryptoServiceProvider"
		alias
			"ImportParameters"
		end

	create_signature (rgb_hash: NATIVE_ARRAY [INTEGER_8]): NATIVE_ARRAY [INTEGER_8] is
		external
			"IL signature (System.Byte[]): System.Byte[] use System.Security.Cryptography.DSACryptoServiceProvider"
		alias
			"CreateSignature"
		end

	frozen verify_hash (rgb_hash: NATIVE_ARRAY [INTEGER_8]; str: SYSTEM_STRING; rgb_signature: NATIVE_ARRAY [INTEGER_8]): BOOLEAN is
		external
			"IL signature (System.Byte[], System.String, System.Byte[]): System.Boolean use System.Security.Cryptography.DSACryptoServiceProvider"
		alias
			"VerifyHash"
		end

	frozen sign_data_array_byte_int32 (buffer: NATIVE_ARRAY [INTEGER_8]; offset: INTEGER; count: INTEGER): NATIVE_ARRAY [INTEGER_8] is
		external
			"IL signature (System.Byte[], System.Int32, System.Int32): System.Byte[] use System.Security.Cryptography.DSACryptoServiceProvider"
		alias
			"SignData"
		end

	frozen sign_data (input_stream: SYSTEM_STREAM): NATIVE_ARRAY [INTEGER_8] is
		external
			"IL signature (System.IO.Stream): System.Byte[] use System.Security.Cryptography.DSACryptoServiceProvider"
		alias
			"SignData"
		end

	verify_signature (rgb_hash: NATIVE_ARRAY [INTEGER_8]; rgb_signature: NATIVE_ARRAY [INTEGER_8]): BOOLEAN is
		external
			"IL signature (System.Byte[], System.Byte[]): System.Boolean use System.Security.Cryptography.DSACryptoServiceProvider"
		alias
			"VerifySignature"
		end

	frozen sign_hash (rgb_hash: NATIVE_ARRAY [INTEGER_8]; str: SYSTEM_STRING): NATIVE_ARRAY [INTEGER_8] is
		external
			"IL signature (System.Byte[], System.String): System.Byte[] use System.Security.Cryptography.DSACryptoServiceProvider"
		alias
			"SignHash"
		end

	frozen sign_data_array_byte (buffer: NATIVE_ARRAY [INTEGER_8]): NATIVE_ARRAY [INTEGER_8] is
		external
			"IL signature (System.Byte[]): System.Byte[] use System.Security.Cryptography.DSACryptoServiceProvider"
		alias
			"SignData"
		end

feature {NONE} -- Implementation

	dispose (disposing: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Security.Cryptography.DSACryptoServiceProvider"
		alias
			"Dispose"
		end

	finalize is
		external
			"IL signature (): System.Void use System.Security.Cryptography.DSACryptoServiceProvider"
		alias
			"Finalize"
		end

end -- class DSACRYPTO_SERVICE_PROVIDER
