indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Security.Cryptography.RC2CryptoServiceProvider"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	RC2_CRYPTO_SERVICE_PROVIDER

inherit
	RC2
		redefine
			set_effective_key_size,
			get_effective_key_size
		end
	IDISPOSABLE
		rename
			dispose as system_idisposable_dispose
		end

create
	make_rc2_crypto_service_provider

feature {NONE} -- Initialization

	frozen make_rc2_crypto_service_provider is
		external
			"IL creator use System.Security.Cryptography.RC2CryptoServiceProvider"
		end

feature -- Access

	get_effective_key_size: INTEGER is
		external
			"IL signature (): System.Int32 use System.Security.Cryptography.RC2CryptoServiceProvider"
		alias
			"get_EffectiveKeySize"
		end

feature -- Element Change

	set_effective_key_size (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Security.Cryptography.RC2CryptoServiceProvider"
		alias
			"set_EffectiveKeySize"
		end

feature -- Basic Operations

	create_encryptor_array_byte (rgb_key: NATIVE_ARRAY [INTEGER_8]; rgb_iv: NATIVE_ARRAY [INTEGER_8]): ICRYPTO_TRANSFORM is
		external
			"IL signature (System.Byte[], System.Byte[]): System.Security.Cryptography.ICryptoTransform use System.Security.Cryptography.RC2CryptoServiceProvider"
		alias
			"CreateEncryptor"
		end

	create_decryptor_array_byte (rgb_key: NATIVE_ARRAY [INTEGER_8]; rgb_iv: NATIVE_ARRAY [INTEGER_8]): ICRYPTO_TRANSFORM is
		external
			"IL signature (System.Byte[], System.Byte[]): System.Security.Cryptography.ICryptoTransform use System.Security.Cryptography.RC2CryptoServiceProvider"
		alias
			"CreateDecryptor"
		end

	generate_key is
		external
			"IL signature (): System.Void use System.Security.Cryptography.RC2CryptoServiceProvider"
		alias
			"GenerateKey"
		end

	generate_iv is
		external
			"IL signature (): System.Void use System.Security.Cryptography.RC2CryptoServiceProvider"
		alias
			"GenerateIV"
		end

end -- class RC2_CRYPTO_SERVICE_PROVIDER
