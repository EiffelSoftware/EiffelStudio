indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Security.Cryptography.ICryptoTransform"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	ICRYPTO_TRANSFORM

inherit
	IDISPOSABLE

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

	get_can_reuse_transform: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use System.Security.Cryptography.ICryptoTransform"
		alias
			"get_CanReuseTransform"
		end

	get_can_transform_multiple_blocks: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use System.Security.Cryptography.ICryptoTransform"
		alias
			"get_CanTransformMultipleBlocks"
		end

feature -- Basic Operations

	transform_block (input_buffer: NATIVE_ARRAY [INTEGER_8]; input_offset: INTEGER; input_count: INTEGER; output_buffer: NATIVE_ARRAY [INTEGER_8]; output_offset: INTEGER): INTEGER is
		external
			"IL deferred signature (System.Byte[], System.Int32, System.Int32, System.Byte[], System.Int32): System.Int32 use System.Security.Cryptography.ICryptoTransform"
		alias
			"TransformBlock"
		end

	transform_final_block (input_buffer: NATIVE_ARRAY [INTEGER_8]; input_offset: INTEGER; input_count: INTEGER): NATIVE_ARRAY [INTEGER_8] is
		external
			"IL deferred signature (System.Byte[], System.Int32, System.Int32): System.Byte[] use System.Security.Cryptography.ICryptoTransform"
		alias
			"TransformFinalBlock"
		end

end -- class ICRYPTO_TRANSFORM
