indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Security.Cryptography.HashAlgorithm"

deferred external class
	SYSTEM_SECURITY_CRYPTOGRAPHY_HASHALGORITHM

inherit
	ANY
		redefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end
	SYSTEM_SECURITY_CRYPTOGRAPHY_ICRYPTOTRANSFORM

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

	get_hash: ARRAY [INTEGER_8] is
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

	to_string: STRING is
		external
			"IL signature (): System.String use System.Security.Cryptography.HashAlgorithm"
		alias
			"ToString"
		end

	frozen compute_hash (buffer: ARRAY [INTEGER_8]): ARRAY [INTEGER_8] is
		external
			"IL signature (System.Byte[]): System.Byte[] use System.Security.Cryptography.HashAlgorithm"
		alias
			"ComputeHash"
		end

	frozen Create_: SYSTEM_SECURITY_CRYPTOGRAPHY_HASHALGORITHM is
		external
			"IL static signature (): System.Security.Cryptography.HashAlgorithm use System.Security.Cryptography.HashAlgorithm"
		alias
			"Create"
		end

	initialize is
		external
			"IL deferred signature (): System.Void use System.Security.Cryptography.HashAlgorithm"
		alias
			"Initialize"
		end

	frozen transform_final_block (input_buffer: ARRAY [INTEGER_8]; input_offset: INTEGER; input_count: INTEGER): ARRAY [INTEGER_8] is
		external
			"IL signature (System.Byte[], System.Int32, System.Int32): System.Byte[] use System.Security.Cryptography.HashAlgorithm"
		alias
			"TransformFinalBlock"
		end

	frozen create__string (hash_name: STRING): SYSTEM_SECURITY_CRYPTOGRAPHY_HASHALGORITHM is
		external
			"IL static signature (System.String): System.Security.Cryptography.HashAlgorithm use System.Security.Cryptography.HashAlgorithm"
		alias
			"Create"
		end

	is_equal (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Security.Cryptography.HashAlgorithm"
		alias
			"Equals"
		end

	frozen compute_hash_array_byte_int32 (buffer: ARRAY [INTEGER_8]; offset: INTEGER; count: INTEGER): ARRAY [INTEGER_8] is
		external
			"IL signature (System.Byte[], System.Int32, System.Int32): System.Byte[] use System.Security.Cryptography.HashAlgorithm"
		alias
			"ComputeHash"
		end

	frozen transform_block (input_buffer: ARRAY [INTEGER_8]; input_offset: INTEGER; input_count: INTEGER; output_buffer: ARRAY [INTEGER_8]; output_offset: INTEGER): INTEGER is
		external
			"IL signature (System.Byte[], System.Int32, System.Int32, System.Byte[], System.Int32): System.Int32 use System.Security.Cryptography.HashAlgorithm"
		alias
			"TransformBlock"
		end

	frozen compute_hash_stream (input_stream: SYSTEM_IO_STREAM): ARRAY [INTEGER_8] is
		external
			"IL signature (System.IO.Stream): System.Byte[] use System.Security.Cryptography.HashAlgorithm"
		alias
			"ComputeHash"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Security.Cryptography.HashAlgorithm"
		alias
			"GetHashCode"
		end

feature {NONE} -- Implementation

	hash_core (array: ARRAY [INTEGER_8]; ib_start: INTEGER; cb_size: INTEGER) is
		external
			"IL deferred signature (System.Byte[], System.Int32, System.Int32): System.Void use System.Security.Cryptography.HashAlgorithm"
		alias
			"HashCore"
		end

	hash_final: ARRAY [INTEGER_8] is
		external
			"IL deferred signature (): System.Byte[] use System.Security.Cryptography.HashAlgorithm"
		alias
			"HashFinal"
		end

	finalize is
		external
			"IL signature (): System.Void use System.Security.Cryptography.HashAlgorithm"
		alias
			"Finalize"
		end

end -- class SYSTEM_SECURITY_CRYPTOGRAPHY_HASHALGORITHM
