indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Security.Cryptography.PKCS1MaskGenerationMethod"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	PKCS1_MASK_GENERATION_METHOD

inherit
	MASK_GENERATION_METHOD

create
	make_pkcs1_mask_generation_method

feature {NONE} -- Initialization

	frozen make_pkcs1_mask_generation_method is
		external
			"IL creator use System.Security.Cryptography.PKCS1MaskGenerationMethod"
		end

feature -- Access

	frozen get_hash_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Security.Cryptography.PKCS1MaskGenerationMethod"
		alias
			"get_HashName"
		end

feature -- Element Change

	frozen set_hash_name (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Security.Cryptography.PKCS1MaskGenerationMethod"
		alias
			"set_HashName"
		end

feature -- Basic Operations

	generate_mask (rgb_seed: NATIVE_ARRAY [INTEGER_8]; cb_return: INTEGER): NATIVE_ARRAY [INTEGER_8] is
		external
			"IL signature (System.Byte[], System.Int32): System.Byte[] use System.Security.Cryptography.PKCS1MaskGenerationMethod"
		alias
			"GenerateMask"
		end

end -- class PKCS1_MASK_GENERATION_METHOD
