indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.Remoting.Channels.IClientChannelSink"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	ICLIENT_CHANNEL_SINK

inherit
	ICHANNEL_SINK_BASE

feature -- Access

	get_next_channel_sink: ICLIENT_CHANNEL_SINK is
		external
			"IL deferred signature (): System.Runtime.Remoting.Channels.IClientChannelSink use System.Runtime.Remoting.Channels.IClientChannelSink"
		alias
			"get_NextChannelSink"
		end

feature -- Basic Operations

	process_message (msg: IMESSAGE; request_headers: ITRANSPORT_HEADERS; request_stream: SYSTEM_STREAM; response_headers: ITRANSPORT_HEADERS; response_stream: SYSTEM_STREAM) is
		external
			"IL deferred signature (System.Runtime.Remoting.Messaging.IMessage, System.Runtime.Remoting.Channels.ITransportHeaders, System.IO.Stream, System.Runtime.Remoting.Channels.ITransportHeaders&, System.IO.Stream&): System.Void use System.Runtime.Remoting.Channels.IClientChannelSink"
		alias
			"ProcessMessage"
		end

	async_process_request (sink_stack: ICLIENT_CHANNEL_SINK_STACK; msg: IMESSAGE; headers: ITRANSPORT_HEADERS; stream: SYSTEM_STREAM) is
		external
			"IL deferred signature (System.Runtime.Remoting.Channels.IClientChannelSinkStack, System.Runtime.Remoting.Messaging.IMessage, System.Runtime.Remoting.Channels.ITransportHeaders, System.IO.Stream): System.Void use System.Runtime.Remoting.Channels.IClientChannelSink"
		alias
			"AsyncProcessRequest"
		end

	async_process_response (sink_stack: ICLIENT_RESPONSE_CHANNEL_SINK_STACK; state: SYSTEM_OBJECT; headers: ITRANSPORT_HEADERS; stream: SYSTEM_STREAM) is
		external
			"IL deferred signature (System.Runtime.Remoting.Channels.IClientResponseChannelSinkStack, System.Object, System.Runtime.Remoting.Channels.ITransportHeaders, System.IO.Stream): System.Void use System.Runtime.Remoting.Channels.IClientChannelSink"
		alias
			"AsyncProcessResponse"
		end

	get_request_stream (msg: IMESSAGE; headers: ITRANSPORT_HEADERS): SYSTEM_STREAM is
		external
			"IL deferred signature (System.Runtime.Remoting.Messaging.IMessage, System.Runtime.Remoting.Channels.ITransportHeaders): System.IO.Stream use System.Runtime.Remoting.Channels.IClientChannelSink"
		alias
			"GetRequestStream"
		end

end -- class ICLIENT_CHANNEL_SINK
