indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Security.Cryptography.MaskGenerationMethod"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	MASK_GENERATION_METHOD

inherit
	SYSTEM_OBJECT

feature -- Basic Operations

	generate_mask (rgb_seed: NATIVE_ARRAY [INTEGER_8]; cb_return: INTEGER): NATIVE_ARRAY [INTEGER_8] is
		external
			"IL deferred signature (System.Byte[], System.Int32): System.Byte[] use System.Security.Cryptography.MaskGenerationMethod"
		alias
			"GenerateMask"
		end

end -- class MASK_GENERATION_METHOD
