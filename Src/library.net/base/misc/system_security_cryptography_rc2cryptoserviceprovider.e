indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Security.Cryptography.RC2CryptoServiceProvider"

frozen external class
	SYSTEM_SECURITY_CRYPTOGRAPHY_RC2CRYPTOSERVICEPROVIDER

inherit
	SYSTEM_SECURITY_CRYPTOGRAPHY_RC2
		redefine
			set_effective_key_size,
			get_effective_key_size
		end

create
	make_rc2cryptoserviceprovider

feature {NONE} -- Initialization

	frozen make_rc2cryptoserviceprovider is
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

	create_encryptor_array_byte (rgb_key: ARRAY [INTEGER_8]; rgb_iv: ARRAY [INTEGER_8]): SYSTEM_SECURITY_CRYPTOGRAPHY_ICRYPTOTRANSFORM is
		external
			"IL signature (System.Byte[], System.Byte[]): System.Security.Cryptography.ICryptoTransform use System.Security.Cryptography.RC2CryptoServiceProvider"
		alias
			"CreateEncryptor"
		end

	create_decryptor_array_byte (rgb_key: ARRAY [INTEGER_8]; rgb_iv: ARRAY [INTEGER_8]): SYSTEM_SECURITY_CRYPTOGRAPHY_ICRYPTOTRANSFORM is
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

end -- class SYSTEM_SECURITY_CRYPTOGRAPHY_RC2CRYPTOSERVICEPROVIDER
