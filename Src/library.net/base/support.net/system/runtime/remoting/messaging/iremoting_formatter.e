indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.Remoting.Messaging.IRemotingFormatter"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	IREMOTING_FORMATTER

inherit
	IFORMATTER

feature -- Basic Operations

	serialize_stream_object_array_header (serialization_stream: SYSTEM_STREAM; graph: SYSTEM_OBJECT; headers: NATIVE_ARRAY [HEADER]) is
		external
			"IL deferred signature (System.IO.Stream, System.Object, System.Runtime.Remoting.Messaging.Header[]): System.Void use System.Runtime.Remoting.Messaging.IRemotingFormatter"
		alias
			"Serialize"
		end

	deserialize_stream_header_handler (serialization_stream: SYSTEM_STREAM; handler: HEADER_HANDLER): SYSTEM_OBJECT is
		external
			"IL deferred signature (System.IO.Stream, System.Runtime.Remoting.Messaging.HeaderHandler): System.Object use System.Runtime.Remoting.Messaging.IRemotingFormatter"
		alias
			"Deserialize"
		end

end -- class IREMOTING_FORMATTER
