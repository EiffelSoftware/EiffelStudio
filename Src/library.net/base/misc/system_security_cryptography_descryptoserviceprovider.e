indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Security.Cryptography.DESCryptoServiceProvider"

frozen external class
	SYSTEM_SECURITY_CRYPTOGRAPHY_DESCRYPTOSERVICEPROVIDER

inherit
	SYSTEM_SECURITY_CRYPTOGRAPHY_DES

create
	make_descryptoserviceprovider

feature {NONE} -- Initialization

	frozen make_descryptoserviceprovider is
		external
			"IL creator use System.Security.Cryptography.DESCryptoServiceProvider"
		end

feature -- Basic Operations

	create_encryptor_array_byte (rgb_key: ARRAY [INTEGER_8]; rgb_iv: ARRAY [INTEGER_8]): SYSTEM_SECURITY_CRYPTOGRAPHY_ICRYPTOTRANSFORM is
		external
			"IL signature (System.Byte[], System.Byte[]): System.Security.Cryptography.ICryptoTransform use System.Security.Cryptography.DESCryptoServiceProvider"
		alias
			"CreateEncryptor"
		end

	create_decryptor_array_byte (rgb_key: ARRAY [INTEGER_8]; rgb_iv: ARRAY [INTEGER_8]): SYSTEM_SECURITY_CRYPTOGRAPHY_ICRYPTOTRANSFORM is
		external
			"IL signature (System.Byte[], System.Byte[]): System.Security.Cryptography.ICryptoTransform use System.Security.Cryptography.DESCryptoServiceProvider"
		alias
			"CreateDecryptor"
		end

	generate_key is
		external
			"IL signature (): System.Void use System.Security.Cryptography.DESCryptoServiceProvider"
		alias
			"GenerateKey"
		end

	generate_iv is
		external
			"IL signature (): System.Void use System.Security.Cryptography.DESCryptoServiceProvider"
		alias
			"GenerateIV"
		end

end -- class SYSTEM_SECURITY_CRYPTOGRAPHY_DESCRYPTOSERVICEPROVIDER
