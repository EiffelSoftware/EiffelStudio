indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Security.Cryptography.TripleDESCryptoServiceProvider"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	TRIPLE_DESCRYPTO_SERVICE_PROVIDER

inherit
	TRIPLE_DES
	IDISPOSABLE
		rename
			dispose as system_idisposable_dispose
		end

create
	make_triple_descrypto_service_provider

feature {NONE} -- Initialization

	frozen make_triple_descrypto_service_provider is
		external
			"IL creator use System.Security.Cryptography.TripleDESCryptoServiceProvider"
		end

feature -- Basic Operations

	create_encryptor_array_byte (rgb_key: NATIVE_ARRAY [INTEGER_8]; rgb_iv: NATIVE_ARRAY [INTEGER_8]): ICRYPTO_TRANSFORM is
		external
			"IL signature (System.Byte[], System.Byte[]): System.Security.Cryptography.ICryptoTransform use System.Security.Cryptography.TripleDESCryptoServiceProvider"
		alias
			"CreateEncryptor"
		end

	create_decryptor_array_byte (rgb_key: NATIVE_ARRAY [INTEGER_8]; rgb_iv: NATIVE_ARRAY [INTEGER_8]): ICRYPTO_TRANSFORM is
		external
			"IL signature (System.Byte[], System.Byte[]): System.Security.Cryptography.ICryptoTransform use System.Security.Cryptography.TripleDESCryptoServiceProvider"
		alias
			"CreateDecryptor"
		end

	generate_key is
		external
			"IL signature (): System.Void use System.Security.Cryptography.TripleDESCryptoServiceProvider"
		alias
			"GenerateKey"
		end

	generate_iv is
		external
			"IL signature (): System.Void use System.Security.Cryptography.TripleDESCryptoServiceProvider"
		alias
			"GenerateIV"
		end

end -- class TRIPLE_DESCRYPTO_SERVICE_PROVIDER
