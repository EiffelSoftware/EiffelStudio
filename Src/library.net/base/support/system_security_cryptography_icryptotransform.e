indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Security.Cryptography.ICryptoTransform"

deferred external class
	SYSTEM_SECURITY_CRYPTOGRAPHY_ICRYPTOTRANSFORM

inherit
	ANY
		undefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end

feature -- Access

	get_input_block_size: INTEGER is
		external
			"IL deferred signature (): System.Int32 use System.Security.Cryptography.ICryptoTransform"
		alias
			"get_InputBlockSize"
		end

	get_output_block_size: INTEGER is
		external
			"IL deferred signature (): System.Int32 use System.Security.Cryptography.ICryptoTransform"
		alias
			"get_OutputBlockSize"
		end

	get_can_transform_multiple_blocks: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use System.Security.Cryptography.ICryptoTransform"
		alias
			"get_CanTransformMultipleBlocks"
		end

feature -- Basic Operations

	transform_block (input_buffer: ARRAY [INTEGER_8]; input_offset: INTEGER; input_count: INTEGER; output_buffer: ARRAY [INTEGER_8]; output_offset: INTEGER): INTEGER is
		external
			"IL deferred signature (System.Byte[], System.Int32, System.Int32, System.Byte[], System.Int32): System.Int32 use System.Security.Cryptography.ICryptoTransform"
		alias
			"TransformBlock"
		end

	transform_final_block (input_buffer: ARRAY [INTEGER_8]; input_offset: INTEGER; input_count: INTEGER): ARRAY [INTEGER_8] is
		external
			"IL deferred signature (System.Byte[], System.Int32, System.Int32): System.Byte[] use System.Security.Cryptography.ICryptoTransform"
		alias
			"TransformFinalBlock"
		end

end -- class SYSTEM_SECURITY_CRYPTOGRAPHY_ICRYPTOTRANSFORM
