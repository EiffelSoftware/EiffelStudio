indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.IntPtr"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen expanded external class
	POINTER

inherit
	VALUE_TYPE
		undefine
			finalize,
			get_hash_code,
			equals,
			to_string,
			memberwise_clone
		end
	ISERIALIZABLE
		rename
			get_object_data as system_runtime_serialization_iserializable_get_object_data
		undefine
			memberwise_clone
		end

	POINTER_REF

create {NONE}

feature -- Initialization

	frozen make_pointer_1 (value: INTEGER_64) is
		external
			"IL creator signature (System.Int64) use System.IntPtr"
		end

	frozen make_pointer (value: INTEGER) is
		external
			"IL creator signature (System.Int32) use System.IntPtr"
		end

feature -- Access

	frozen zero: POINTER is
		external
			"IL static_field signature :System.IntPtr use System.IntPtr"
		alias
			"Zero"
		end

	frozen get_size: INTEGER is
		external
			"IL static signature (): System.Int32 use System.IntPtr"
		alias
			"get_Size"
		end

feature -- Basic Operations

	frozen to_int64: INTEGER_64 is
		external
			"IL signature (): System.Int64 use System.IntPtr"
		alias
			"ToInt64"
		end

	frozen to_int32: INTEGER is
		external
			"IL signature (): System.Int32 use System.IntPtr"
		alias
			"ToInt32"
		end

feature -- Binary Operators

	frozen infix "#==" (value2: POINTER): BOOLEAN is
		external
			"IL operator signature (System.IntPtr): System.Boolean use System.IntPtr"
		alias
			"op_Equality"
		end

	frozen infix "|=" (value2: POINTER): BOOLEAN is
		external
			"IL operator signature (System.IntPtr): System.Boolean use System.IntPtr"
		alias
			"op_Inequality"
		end

feature -- Specials

	frozen op_explicit_int32 (value: INTEGER): POINTER is
		external
			"IL static signature (System.Int32): System.IntPtr use System.IntPtr"
		alias
			"op_Explicit"
		end

	frozen op_explicit_int_ptr (value: POINTER): INTEGER_64 is
		external
			"IL static signature (System.IntPtr): System.Int64 use System.IntPtr"
		alias
			"op_Explicit"
		end

	frozen op_explicit_int64 (value: INTEGER_64): POINTER is
		external
			"IL static signature (System.Int64): System.IntPtr use System.IntPtr"
		alias
			"op_Explicit"
		end

	frozen op_explicit (value: POINTER): INTEGER is
		external
			"IL static signature (System.IntPtr): System.Int32 use System.IntPtr"
		alias
			"op_Explicit"
		end

feature {NONE} -- Implementation

	frozen system_runtime_serialization_iserializable_get_object_data (info: SERIALIZATION_INFO; context: STREAMING_CONTEXT) is
		external
			"IL signature (System.Runtime.Serialization.SerializationInfo, System.Runtime.Serialization.StreamingContext): System.Void use System.IntPtr"
		alias
			"System.Runtime.Serialization.ISerializable.GetObjectData"
		end

end -- class POINTER
