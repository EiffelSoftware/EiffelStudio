indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Runtime.Remoting.Messaging.IRemotingFormatter"

deferred external class
	SYSTEM_RUNTIME_REMOTING_MESSAGING_IREMOTINGFORMATTER

inherit
	SYSTEM_RUNTIME_SERIALIZATION_IFORMATTER

feature -- Basic Operations

	serialize_stream_object_array_header (serialization_stream: SYSTEM_IO_STREAM; graph: ANY; headers: ARRAY [SYSTEM_RUNTIME_REMOTING_MESSAGING_HEADER]) is
		external
			"IL deferred signature (System.IO.Stream, System.Object, System.Runtime.Remoting.Messaging.Header[]): System.Void use System.Runtime.Remoting.Messaging.IRemotingFormatter"
		alias
			"Serialize"
		end

	deserialize_stream_header_handler (serialization_stream: SYSTEM_IO_STREAM; handler: SYSTEM_RUNTIME_REMOTING_MESSAGING_HEADERHANDLER): ANY is
		external
			"IL deferred signature (System.IO.Stream, System.Runtime.Remoting.Messaging.HeaderHandler): System.Object use System.Runtime.Remoting.Messaging.IRemotingFormatter"
		alias
			"Deserialize"
		end

end -- class SYSTEM_RUNTIME_REMOTING_MESSAGING_IREMOTINGFORMATTER
