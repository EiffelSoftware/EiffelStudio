indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Net.ProtocolViolationException"

external class
	SYSTEM_NET_PROTOCOLVIOLATIONEXCEPTION

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
	make_protocolviolationexception_1,
	make_protocolviolationexception

feature {NONE} -- Initialization

	frozen make_protocolviolationexception_1 (message: STRING) is
		external
			"IL creator signature (System.String) use System.Net.ProtocolViolationException"
		end

	frozen make_protocolviolationexception is
		external
			"IL creator use System.Net.ProtocolViolationException"
		end

feature {NONE} -- Implementation

	frozen system_runtime_serialization_iserializable_get_object_data (serialization_info: SYSTEM_RUNTIME_SERIALIZATION_SERIALIZATIONINFO; streaming_context: SYSTEM_RUNTIME_SERIALIZATION_STREAMINGCONTEXT) is
		external
			"IL signature (System.Runtime.Serialization.SerializationInfo, System.Runtime.Serialization.StreamingContext): System.Void use System.Net.ProtocolViolationException"
		alias
			"System.Runtime.Serialization.ISerializable.GetObjectData"
		end

end -- class SYSTEM_NET_PROTOCOLVIOLATIONEXCEPTION
