indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.RuntimeTypeHandle"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen expanded external class
	RUNTIME_TYPE_HANDLE

inherit
	VALUE_TYPE
	ISERIALIZABLE

feature -- Access

	frozen get_value: POINTER is
		external
			"IL signature (): System.IntPtr use System.RuntimeTypeHandle"
		alias
			"get_Value"
		end

feature -- Basic Operations

	frozen get_object_data (info: SERIALIZATION_INFO; context: STREAMING_CONTEXT) is
		external
			"IL signature (System.Runtime.Serialization.SerializationInfo, System.Runtime.Serialization.StreamingContext): System.Void use System.RuntimeTypeHandle"
		alias
			"GetObjectData"
		end

end -- class RUNTIME_TYPE_HANDLE
