indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.Remoting.Channels.IServerResponseChannelSinkStack"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	ISERVER_RESPONSE_CHANNEL_SINK_STACK

inherit
	SYSTEM_OBJECT
		undefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end

feature -- Basic Operations

	async_process_response (msg: IMESSAGE; headers: ITRANSPORT_HEADERS; stream: SYSTEM_STREAM) is
		external
			"IL deferred signature (System.Runtime.Remoting.Messaging.IMessage, System.Runtime.Remoting.Channels.ITransportHeaders, System.IO.Stream): System.Void use System.Runtime.Remoting.Channels.IServerResponseChannelSinkStack"
		alias
			"AsyncProcessResponse"
		end

	get_response_stream (msg: IMESSAGE; headers: ITRANSPORT_HEADERS): SYSTEM_STREAM is
		external
			"IL deferred signature (System.Runtime.Remoting.Messaging.IMessage, System.Runtime.Remoting.Channels.ITransportHeaders): System.IO.Stream use System.Runtime.Remoting.Channels.IServerResponseChannelSinkStack"
		alias
			"GetResponseStream"
		end

end -- class ISERVER_RESPONSE_CHANNEL_SINK_STACK
