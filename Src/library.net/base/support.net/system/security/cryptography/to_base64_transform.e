indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Security.Cryptography.ToBase64Transform"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	TO_BASE64_TRANSFORM

inherit
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end
	ICRYPTO_TRANSFORM
		rename
			dispose as system_idisposable_dispose
		end
	IDISPOSABLE
		rename
			dispose as system_idisposable_dispose
		end

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.Security.Cryptography.ToBase64Transform"
		end

feature -- Access

	frozen get_input_block_size: INTEGER is
		external
			"IL signature (): System.Int32 use System.Security.Cryptography.ToBase64Transform"
		alias
			"get_InputBlockSize"
		end

	frozen get_output_block_size: INTEGER is
		external
			"IL signature (): System.Int32 use System.Security.Cryptography.ToBase64Transform"
		alias
			"get_OutputBlockSize"
		end

	get_can_reuse_transform: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Security.Cryptography.ToBase64Transform"
		alias
			"get_CanReuseTransform"
		end

	frozen get_can_transform_multiple_blocks: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Security.Cryptography.ToBase64Transform"
		alias
			"get_CanTransformMultipleBlocks"
		end

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Security.Cryptography.ToBase64Transform"
		alias
			"GetHashCode"
		end

	frozen transform_block (input_buffer: NATIVE_ARRAY [INTEGER_8]; input_offset: INTEGER; input_count: INTEGER; output_buffer: NATIVE_ARRAY [INTEGER_8]; output_offset: INTEGER): INTEGER is
		external
			"IL signature (System.Byte[], System.Int32, System.Int32, System.Byte[], System.Int32): System.Int32 use System.Security.Cryptography.ToBase64Transform"
		alias
			"TransformBlock"
		end

	frozen transform_final_block (input_buffer: NATIVE_ARRAY [INTEGER_8]; input_offset: INTEGER; input_count: INTEGER): NATIVE_ARRAY [INTEGER_8] is
		external
			"IL signature (System.Byte[], System.Int32, System.Int32): System.Byte[] use System.Security.Cryptography.ToBase64Transform"
		alias
			"TransformFinalBlock"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Security.Cryptography.ToBase64Transform"
		alias
			"ToString"
		end

	frozen clear is
		external
			"IL signature (): System.Void use System.Security.Cryptography.ToBase64Transform"
		alias
			"Clear"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Security.Cryptography.ToBase64Transform"
		alias
			"Equals"
		end

feature {NONE} -- Implementation

	dispose (disposing: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Security.Cryptography.ToBase64Transform"
		alias
			"Dispose"
		end

	finalize is
		external
			"IL signature (): System.Void use System.Security.Cryptography.ToBase64Transform"
		alias
			"Finalize"
		end

	frozen system_idisposable_dispose is
		external
			"IL signature (): System.Void use System.Security.Cryptography.ToBase64Transform"
		alias
			"System.IDisposable.Dispose"
		end

end -- class TO_BASE64_TRANSFORM
