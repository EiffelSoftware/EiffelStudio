indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.Remoting.Channels.IServerChannelSink"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	ISERVER_CHANNEL_SINK

inherit
	ICHANNEL_SINK_BASE

feature -- Access

	get_next_channel_sink: ISERVER_CHANNEL_SINK is
		external
			"IL deferred signature (): System.Runtime.Remoting.Channels.IServerChannelSink use System.Runtime.Remoting.Channels.IServerChannelSink"
		alias
			"get_NextChannelSink"
		end

feature -- Basic Operations

	process_message (sink_stack: ISERVER_CHANNEL_SINK_STACK; request_msg: IMESSAGE; request_headers: ITRANSPORT_HEADERS; request_stream: SYSTEM_STREAM; response_msg: IMESSAGE; response_headers: ITRANSPORT_HEADERS; response_stream: SYSTEM_STREAM): SERVER_PROCESSING is
		external
			"IL deferred signature (System.Runtime.Remoting.Channels.IServerChannelSinkStack, System.Runtime.Remoting.Messaging.IMessage, System.Runtime.Remoting.Channels.ITransportHeaders, System.IO.Stream, System.Runtime.Remoting.Messaging.IMessage&, System.Runtime.Remoting.Channels.ITransportHeaders&, System.IO.Stream&): System.Runtime.Remoting.Channels.ServerProcessing use System.Runtime.Remoting.Channels.IServerChannelSink"
		alias
			"ProcessMessage"
		end

	async_process_response (sink_stack: ISERVER_RESPONSE_CHANNEL_SINK_STACK; state: SYSTEM_OBJECT; msg: IMESSAGE; headers: ITRANSPORT_HEADERS; stream: SYSTEM_STREAM) is
		external
			"IL deferred signature (System.Runtime.Remoting.Channels.IServerResponseChannelSinkStack, System.Object, System.Runtime.Remoting.Messaging.IMessage, System.Runtime.Remoting.Channels.ITransportHeaders, System.IO.Stream): System.Void use System.Runtime.Remoting.Channels.IServerChannelSink"
		alias
			"AsyncProcessResponse"
		end

	get_response_stream (sink_stack: ISERVER_RESPONSE_CHANNEL_SINK_STACK; state: SYSTEM_OBJECT; msg: IMESSAGE; headers: ITRANSPORT_HEADERS): SYSTEM_STREAM is
		external
			"IL deferred signature (System.Runtime.Remoting.Channels.IServerResponseChannelSinkStack, System.Object, System.Runtime.Remoting.Messaging.IMessage, System.Runtime.Remoting.Channels.ITransportHeaders): System.IO.Stream use System.Runtime.Remoting.Channels.IServerChannelSink"
		alias
			"GetResponseStream"
		end

end -- class ISERVER_CHANNEL_SINK
