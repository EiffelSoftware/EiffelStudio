indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.IntPtr"

frozen expanded external class
	POINTER

inherit
	SYSTEM_VALUETYPE
		redefine
			get_hash_code,
			is_equal,
			to_string
		end
	SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZABLE
		rename
			get_object_data as system_runtime_serialization_iserializable_get_object_data
		end



feature {NONE} -- Initialization

	frozen make_intptr_1 (value: INTEGER_64) is
		external
			"IL creator signature (System.Int64) use System.IntPtr"
		end

	frozen make_intptr (value: INTEGER) is
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

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.IntPtr"
		alias
			"GetHashCode"
		end

	is_equal (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.IntPtr"
		alias
			"Equals"
		end

	to_string: STRING is
		external
			"IL signature (): System.String use System.IntPtr"
		alias
			"ToString"
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

	frozen op_explicit (value: INTEGER): POINTER is
		external
			"IL static signature (System.Int32): System.IntPtr use System.IntPtr"
		alias
			"op_Explicit"
		end

feature {NONE} -- Implementation

	frozen system_runtime_serialization_iserializable_get_object_data (info: SYSTEM_RUNTIME_SERIALIZATION_SERIALIZATIONINFO; context: SYSTEM_RUNTIME_SERIALIZATION_STREAMINGCONTEXT) is
		external
			"IL signature (System.Runtime.Serialization.SerializationInfo, System.Runtime.Serialization.StreamingContext): System.Void use System.IntPtr"
		alias
			"System.Runtime.Serialization.ISerializable.GetObjectData"
		end

end -- class POINTER
