indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Security.Cryptography.RijndaelManaged"

frozen external class
	SYSTEM_SECURITY_CRYPTOGRAPHY_RIJNDAELMANAGED

inherit
	SYSTEM_SECURITY_CRYPTOGRAPHY_RIJNDAEL

create
	make_rijndaelmanaged

feature {NONE} -- Initialization

	frozen make_rijndaelmanaged is
		external
			"IL creator use System.Security.Cryptography.RijndaelManaged"
		end

feature -- Basic Operations

	create_encryptor_array_byte (rgb_key: ARRAY [INTEGER_8]; rgb_iv: ARRAY [INTEGER_8]): SYSTEM_SECURITY_CRYPTOGRAPHY_ICRYPTOTRANSFORM is
		external
			"IL signature (System.Byte[], System.Byte[]): System.Security.Cryptography.ICryptoTransform use System.Security.Cryptography.RijndaelManaged"
		alias
			"CreateEncryptor"
		end

	create_decryptor_array_byte (rgb_key: ARRAY [INTEGER_8]; rgb_iv: ARRAY [INTEGER_8]): SYSTEM_SECURITY_CRYPTOGRAPHY_ICRYPTOTRANSFORM is
		external
			"IL signature (System.Byte[], System.Byte[]): System.Security.Cryptography.ICryptoTransform use System.Security.Cryptography.RijndaelManaged"
		alias
			"CreateDecryptor"
		end

	generate_key is
		external
			"IL signature (): System.Void use System.Security.Cryptography.RijndaelManaged"
		alias
			"GenerateKey"
		end

	generate_iv is
		external
			"IL signature (): System.Void use System.Security.Cryptography.RijndaelManaged"
		alias
			"GenerateIV"
		end

end -- class SYSTEM_SECURITY_CRYPTOGRAPHY_RIJNDAELMANAGED
