indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Security.Cryptography.RSACryptoServiceProvider"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	RSACRYPTO_SERVICE_PROVIDER

inherit
	RSA
		redefine
			get_key_size,
			finalize
		end
	IDISPOSABLE
		rename
			dispose as system_idisposable_dispose
		end

create
	make_rsacrypto_service_provider,
	make_rsacrypto_service_provider_3,
	make_rsacrypto_service_provider_2,
	make_rsacrypto_service_provider_1

feature {NONE} -- Initialization

	frozen make_rsacrypto_service_provider is
		external
			"IL creator use System.Security.Cryptography.RSACryptoServiceProvider"
		end

	frozen make_rsacrypto_service_provider_3 (dw_key_size: INTEGER; parameters: CSP_PARAMETERS) is
		external
			"IL creator signature (System.Int32, System.Security.Cryptography.CspParameters) use System.Security.Cryptography.RSACryptoServiceProvider"
		end

	frozen make_rsacrypto_service_provider_2 (parameters: CSP_PARAMETERS) is
		external
			"IL creator signature (System.Security.Cryptography.CspParameters) use System.Security.Cryptography.RSACryptoServiceProvider"
		end

	frozen make_rsacrypto_service_provider_1 (dw_key_size: INTEGER) is
		external
			"IL creator signature (System.Int32) use System.Security.Cryptography.RSACryptoServiceProvider"
		end

feature -- Access

	frozen get_persist_key_in_csp: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Security.Cryptography.RSACryptoServiceProvider"
		alias
			"get_PersistKeyInCsp"
		end

	get_signature_algorithm: SYSTEM_STRING is
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

	get_key_exchange_algorithm: SYSTEM_STRING is
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

	export_parameters (include_private_parameters: BOOLEAN): RSAPARAMETERS is
		external
			"IL signature (System.Boolean): System.Security.Cryptography.RSAParameters use System.Security.Cryptography.RSACryptoServiceProvider"
		alias
			"ExportParameters"
		end

	frozen decrypt (rgb: NATIVE_ARRAY [INTEGER_8]; f_oaep: BOOLEAN): NATIVE_ARRAY [INTEGER_8] is
		external
			"IL signature (System.Byte[], System.Boolean): System.Byte[] use System.Security.Cryptography.RSACryptoServiceProvider"
		alias
			"Decrypt"
		end

	frozen verify_data (buffer: NATIVE_ARRAY [INTEGER_8]; halg: SYSTEM_OBJECT; signature: NATIVE_ARRAY [INTEGER_8]): BOOLEAN is
		external
			"IL signature (System.Byte[], System.Object, System.Byte[]): System.Boolean use System.Security.Cryptography.RSACryptoServiceProvider"
		alias
			"VerifyData"
		end

	import_parameters (parameters: RSAPARAMETERS) is
		external
			"IL signature (System.Security.Cryptography.RSAParameters): System.Void use System.Security.Cryptography.RSACryptoServiceProvider"
		alias
			"ImportParameters"
		end

	frozen sign_hash (rgb_hash: NATIVE_ARRAY [INTEGER_8]; str: SYSTEM_STRING): NATIVE_ARRAY [INTEGER_8] is
		external
			"IL signature (System.Byte[], System.String): System.Byte[] use System.Security.Cryptography.RSACryptoServiceProvider"
		alias
			"SignHash"
		end

	frozen verify_hash (rgb_hash: NATIVE_ARRAY [INTEGER_8]; str: SYSTEM_STRING; rgb_signature: NATIVE_ARRAY [INTEGER_8]): BOOLEAN is
		external
			"IL signature (System.Byte[], System.String, System.Byte[]): System.Boolean use System.Security.Cryptography.RSACryptoServiceProvider"
		alias
			"VerifyHash"
		end

	frozen sign_data_array_byte_int32 (buffer: NATIVE_ARRAY [INTEGER_8]; offset: INTEGER; count: INTEGER; halg: SYSTEM_OBJECT): NATIVE_ARRAY [INTEGER_8] is
		external
			"IL signature (System.Byte[], System.Int32, System.Int32, System.Object): System.Byte[] use System.Security.Cryptography.RSACryptoServiceProvider"
		alias
			"SignData"
		end

	frozen sign_data (input_stream: SYSTEM_STREAM; halg: SYSTEM_OBJECT): NATIVE_ARRAY [INTEGER_8] is
		external
			"IL signature (System.IO.Stream, System.Object): System.Byte[] use System.Security.Cryptography.RSACryptoServiceProvider"
		alias
			"SignData"
		end

	encrypt_value (rgb: NATIVE_ARRAY [INTEGER_8]): NATIVE_ARRAY [INTEGER_8] is
		external
			"IL signature (System.Byte[]): System.Byte[] use System.Security.Cryptography.RSACryptoServiceProvider"
		alias
			"EncryptValue"
		end

	frozen sign_data_array_byte_object (buffer: NATIVE_ARRAY [INTEGER_8]; halg: SYSTEM_OBJECT): NATIVE_ARRAY [INTEGER_8] is
		external
			"IL signature (System.Byte[], System.Object): System.Byte[] use System.Security.Cryptography.RSACryptoServiceProvider"
		alias
			"SignData"
		end

	decrypt_value (rgb: NATIVE_ARRAY [INTEGER_8]): NATIVE_ARRAY [INTEGER_8] is
		external
			"IL signature (System.Byte[]): System.Byte[] use System.Security.Cryptography.RSACryptoServiceProvider"
		alias
			"DecryptValue"
		end

	frozen encrypt (rgb: NATIVE_ARRAY [INTEGER_8]; f_oaep: BOOLEAN): NATIVE_ARRAY [INTEGER_8] is
		external
			"IL signature (System.Byte[], System.Boolean): System.Byte[] use System.Security.Cryptography.RSACryptoServiceProvider"
		alias
			"Encrypt"
		end

feature {NONE} -- Implementation

	dispose (disposing: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Security.Cryptography.RSACryptoServiceProvider"
		alias
			"Dispose"
		end

	finalize is
		external
			"IL signature (): System.Void use System.Security.Cryptography.RSACryptoServiceProvider"
		alias
			"Finalize"
		end

end -- class RSACRYPTO_SERVICE_PROVIDER
