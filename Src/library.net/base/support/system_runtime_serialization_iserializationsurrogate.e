indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Runtime.Serialization.ISerializationSurrogate"

deferred external class
	SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZATIONSURROGATE

inherit
	ANY
		undefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end

feature -- Basic Operations

	get_object_data (obj: ANY; info: SYSTEM_RUNTIME_SERIALIZATION_SERIALIZATIONINFO; context: SYSTEM_RUNTIME_SERIALIZATION_STREAMINGCONTEXT) is
		external
			"IL deferred signature (System.Object, System.Runtime.Serialization.SerializationInfo, System.Runtime.Serialization.StreamingContext): System.Void use System.Runtime.Serialization.ISerializationSurrogate"
		alias
			"GetObjectData"
		end

	set_object_data (obj: ANY; info: SYSTEM_RUNTIME_SERIALIZATION_SERIALIZATIONINFO; context: SYSTEM_RUNTIME_SERIALIZATION_STREAMINGCONTEXT; selector: SYSTEM_RUNTIME_SERIALIZATION_ISURROGATESELECTOR): ANY is
		external
			"IL deferred signature (System.Object, System.Runtime.Serialization.SerializationInfo, System.Runtime.Serialization.StreamingContext, System.Runtime.Serialization.ISurrogateSelector): System.Object use System.Runtime.Serialization.ISerializationSurrogate"
		alias
			"SetObjectData"
		end

end -- class SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZATIONSURROGATE
