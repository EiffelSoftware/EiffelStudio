indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Runtime.Serialization.ISerializable"

deferred external class
	SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZABLE

inherit
	ANY
		undefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end

feature -- Basic Operations

	get_object_data (info: SYSTEM_RUNTIME_SERIALIZATION_SERIALIZATIONINFO; context: SYSTEM_RUNTIME_SERIALIZATION_STREAMINGCONTEXT) is
		external
			"IL deferred signature (System.Runtime.Serialization.SerializationInfo, System.Runtime.Serialization.StreamingContext): System.Void use System.Runtime.Serialization.ISerializable"
		alias
			"GetObjectData"
		end

end -- class SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZABLE
