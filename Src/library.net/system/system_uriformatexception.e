indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.UriFormatException"

external class
	SYSTEM_URIFORMATEXCEPTION

inherit
	SYSTEM_EXCEPTION
		rename
			get_object_data as system_runtime_serialization_iserializable_get_object_data
		redefine
			system_runtime_serialization_iserializable_get_object_data
		end
	SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZABLE
		rename
			get_object_data as system_runtime_serialization_iserializable_get_object_data
		end

create
	make_uriformatexception,
	make_uriformatexception_1

feature {NONE} -- Initialization

	frozen make_uriformatexception is
		external
			"IL creator use System.UriFormatException"
		end

	frozen make_uriformatexception_1 (text_string: STRING) is
		external
			"IL creator signature (System.String) use System.UriFormatException"
		end

feature {NONE} -- Implementation

	frozen system_runtime_serialization_iserializable_get_object_data (serialization_info: SYSTEM_RUNTIME_SERIALIZATION_SERIALIZATIONINFO; streaming_context: SYSTEM_RUNTIME_SERIALIZATION_STREAMINGCONTEXT) is
		external
			"IL signature (System.Runtime.Serialization.SerializationInfo, System.Runtime.Serialization.StreamingContext): System.Void use System.UriFormatException"
		alias
			"System.Runtime.Serialization.ISerializable.GetObjectData"
		end

end -- class SYSTEM_URIFORMATEXCEPTION
