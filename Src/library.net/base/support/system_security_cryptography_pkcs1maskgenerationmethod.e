indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Security.Cryptography.PKCS1MaskGenerationMethod"

external class
	SYSTEM_SECURITY_CRYPTOGRAPHY_PKCS1MASKGENERATIONMETHOD

inherit
	SYSTEM_SECURITY_CRYPTOGRAPHY_MASKGENERATIONMETHOD

create
	make_pkcs1maskgenerationmethod

feature {NONE} -- Initialization

	frozen make_pkcs1maskgenerationmethod is
		external
			"IL creator use System.Security.Cryptography.PKCS1MaskGenerationMethod"
		end

feature -- Access

	frozen get_hash_name: STRING is
		external
			"IL signature (): System.String use System.Security.Cryptography.PKCS1MaskGenerationMethod"
		alias
			"get_HashName"
		end

feature -- Element Change

	frozen set_hash_name (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Security.Cryptography.PKCS1MaskGenerationMethod"
		alias
			"set_HashName"
		end

feature -- Basic Operations

	generate_mask (rgb_seed: ARRAY [INTEGER_8]; cb_return: INTEGER): ARRAY [INTEGER_8] is
		external
			"IL signature (System.Byte[], System.Int32): System.Byte[] use System.Security.Cryptography.PKCS1MaskGenerationMethod"
		alias
			"GenerateMask"
		end

end -- class SYSTEM_SECURITY_CRYPTOGRAPHY_PKCS1MASKGENERATIONMETHOD
