indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Security.Cryptography.HashAlgorithm"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	HASH_ALGORITHM

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

feature -- Access

	get_hash_size: INTEGER is
		external
			"IL signature (): System.Int32 use System.Security.Cryptography.HashAlgorithm"
		alias
			"get_HashSize"
		end

	get_input_block_size: INTEGER is
		external
			"IL signature (): System.Int32 use System.Security.Cryptography.HashAlgorithm"
		alias
			"get_InputBlockSize"
		end

	get_output_block_size: INTEGER is
		external
			"IL signature (): System.Int32 use System.Security.Cryptography.HashAlgorithm"
		alias
			"get_OutputBlockSize"
		end

	get_can_reuse_transform: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Security.Cryptography.HashAlgorithm"
		alias
			"get_CanReuseTransform"
		end

	get_hash: NATIVE_ARRAY [INTEGER_8] is
		external
			"IL signature (): System.Byte[] use System.Security.Cryptography.HashAlgorithm"
		alias
			"get_Hash"
		end

	get_can_transform_multiple_blocks: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Security.Cryptography.HashAlgorithm"
		alias
			"get_CanTransformMultipleBlocks"
		end

feature -- Basic Operations

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Security.Cryptography.HashAlgorithm"
		alias
			"ToString"
		end

	frozen compute_hash (input_stream: SYSTEM_STREAM): NATIVE_ARRAY [INTEGER_8] is
		external
			"IL signature (System.IO.Stream): System.Byte[] use System.Security.Cryptography.HashAlgorithm"
		alias
			"ComputeHash"
		end

	initialize is
		external
			"IL deferred signature (): System.Void use System.Security.Cryptography.HashAlgorithm"
		alias
			"Initialize"
		end

	frozen compute_hash_array_byte (buffer: NATIVE_ARRAY [INTEGER_8]): NATIVE_ARRAY [INTEGER_8] is
		external
			"IL signature (System.Byte[]): System.Byte[] use System.Security.Cryptography.HashAlgorithm"
		alias
			"ComputeHash"
		end

	frozen transform_final_block (input_buffer: NATIVE_ARRAY [INTEGER_8]; input_offset: INTEGER; input_count: INTEGER): NATIVE_ARRAY [INTEGER_8] is
		external
			"IL signature (System.Byte[], System.Int32, System.Int32): System.Byte[] use System.Security.Cryptography.HashAlgorithm"
		alias
			"TransformFinalBlock"
		end

	frozen create__string (hash_name: SYSTEM_STRING): HASH_ALGORITHM is
		external
			"IL static signature (System.String): System.Security.Cryptography.HashAlgorithm use System.Security.Cryptography.HashAlgorithm"
		alias
			"Create"
		end

	frozen create_: HASH_ALGORITHM is
		external
			"IL static signature (): System.Security.Cryptography.HashAlgorithm use System.Security.Cryptography.HashAlgorithm"
		alias
			"Create"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Security.Cryptography.HashAlgorithm"
		alias
			"Equals"
		end

	frozen compute_hash_array_byte_int32 (buffer: NATIVE_ARRAY [INTEGER_8]; offset: INTEGER; count: INTEGER): NATIVE_ARRAY [INTEGER_8] is
		external
			"IL signature (System.Byte[], System.Int32, System.Int32): System.Byte[] use System.Security.Cryptography.HashAlgorithm"
		alias
			"ComputeHash"
		end

	frozen clear is
		external
			"IL signature (): System.Void use System.Security.Cryptography.HashAlgorithm"
		alias
			"Clear"
		end

	frozen transform_block (input_buffer: NATIVE_ARRAY [INTEGER_8]; input_offset: INTEGER; input_count: INTEGER; output_buffer: NATIVE_ARRAY [INTEGER_8]; output_offset: INTEGER): INTEGER is
		external
			"IL signature (System.Byte[], System.Int32, System.Int32, System.Byte[], System.Int32): System.Int32 use System.Security.Cryptography.HashAlgorithm"
		alias
			"TransformBlock"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Security.Cryptography.HashAlgorithm"
		alias
			"GetHashCode"
		end

feature {NONE} -- Implementation

	hash_core (array: NATIVE_ARRAY [INTEGER_8]; ib_start: INTEGER; cb_size: INTEGER) is
		external
			"IL deferred signature (System.Byte[], System.Int32, System.Int32): System.Void use System.Security.Cryptography.HashAlgorithm"
		alias
			"HashCore"
		end

	hash_final: NATIVE_ARRAY [INTEGER_8] is
		external
			"IL deferred signature (): System.Byte[] use System.Security.Cryptography.HashAlgorithm"
		alias
			"HashFinal"
		end

	dispose (disposing: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Security.Cryptography.HashAlgorithm"
		alias
			"Dispose"
		end

	frozen system_idisposable_dispose is
		external
			"IL signature (): System.Void use System.Security.Cryptography.HashAlgorithm"
		alias
			"System.IDisposable.Dispose"
		end

	finalize is
		external
			"IL signature (): System.Void use System.Security.Cryptography.HashAlgorithm"
		alias
			"Finalize"
		end

end -- class HASH_ALGORITHM
