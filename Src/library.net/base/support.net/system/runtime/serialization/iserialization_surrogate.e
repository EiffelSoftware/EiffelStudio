indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.Serialization.ISerializationSurrogate"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	ISERIALIZATION_SURROGATE

inherit
	SYSTEM_OBJECT
		undefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end

feature -- Basic Operations

	get_object_data (obj: SYSTEM_OBJECT; info: SERIALIZATION_INFO; context: STREAMING_CONTEXT) is
		external
			"IL deferred signature (System.Object, System.Runtime.Serialization.SerializationInfo, System.Runtime.Serialization.StreamingContext): System.Void use System.Runtime.Serialization.ISerializationSurrogate"
		alias
			"GetObjectData"
		end

	set_object_data (obj: SYSTEM_OBJECT; info: SERIALIZATION_INFO; context: STREAMING_CONTEXT; selector: ISURROGATE_SELECTOR): SYSTEM_OBJECT is
		external
			"IL deferred signature (System.Object, System.Runtime.Serialization.SerializationInfo, System.Runtime.Serialization.StreamingContext, System.Runtime.Serialization.ISurrogateSelector): System.Object use System.Runtime.Serialization.ISerializationSurrogate"
		alias
			"SetObjectData"
		end

end -- class ISERIALIZATION_SURROGATE
