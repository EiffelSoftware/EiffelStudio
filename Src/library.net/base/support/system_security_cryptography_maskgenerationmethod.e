indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Security.Cryptography.MaskGenerationMethod"

deferred external class
	SYSTEM_SECURITY_CRYPTOGRAPHY_MASKGENERATIONMETHOD

feature -- Basic Operations

	generate_mask (rgb_seed: ARRAY [INTEGER_8]; cb_return: INTEGER): ARRAY [INTEGER_8] is
		external
			"IL deferred signature (System.Byte[], System.Int32): System.Byte[] use System.Security.Cryptography.MaskGenerationMethod"
		alias
			"GenerateMask"
		end

end -- class SYSTEM_SECURITY_CRYPTOGRAPHY_MASKGENERATIONMETHOD
