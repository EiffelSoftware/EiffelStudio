indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Runtime.Remoting.Channels.IClientChannelSink"

deferred external class
	SYSTEM_RUNTIME_REMOTING_CHANNELS_ICLIENTCHANNELSINK

inherit
	SYSTEM_RUNTIME_REMOTING_CHANNELS_ICHANNELSINKBASE

feature -- Access

	get_next_channel_sink: SYSTEM_RUNTIME_REMOTING_CHANNELS_ICLIENTCHANNELSINK is
		external
			"IL deferred signature (): System.Runtime.Remoting.Channels.IClientChannelSink use System.Runtime.Remoting.Channels.IClientChannelSink"
		alias
			"get_NextChannelSink"
		end

feature -- Basic Operations

	process_message (msg: SYSTEM_RUNTIME_REMOTING_MESSAGING_IMESSAGE; request_headers: SYSTEM_RUNTIME_REMOTING_CHANNELS_ITRANSPORTHEADERS; request_stream: SYSTEM_IO_STREAM; response_headers: SYSTEM_RUNTIME_REMOTING_CHANNELS_ITRANSPORTHEADERS; response_stream: SYSTEM_IO_STREAM) is
		external
			"IL deferred signature (System.Runtime.Remoting.Messaging.IMessage, System.Runtime.Remoting.Channels.ITransportHeaders, System.IO.Stream, System.Runtime.Remoting.Channels.ITransportHeaders&, System.IO.Stream&): System.Void use System.Runtime.Remoting.Channels.IClientChannelSink"
		alias
			"ProcessMessage"
		end

	async_process_request (sink_stack: SYSTEM_RUNTIME_REMOTING_CHANNELS_ICLIENTCHANNELSINKSTACK; msg: SYSTEM_RUNTIME_REMOTING_MESSAGING_IMESSAGE; headers: SYSTEM_RUNTIME_REMOTING_CHANNELS_ITRANSPORTHEADERS; stream: SYSTEM_IO_STREAM) is
		external
			"IL deferred signature (System.Runtime.Remoting.Channels.IClientChannelSinkStack, System.Runtime.Remoting.Messaging.IMessage, System.Runtime.Remoting.Channels.ITransportHeaders, System.IO.Stream): System.Void use System.Runtime.Remoting.Channels.IClientChannelSink"
		alias
			"AsyncProcessRequest"
		end

	async_process_response (sink_stack: SYSTEM_RUNTIME_REMOTING_CHANNELS_ICLIENTRESPONSECHANNELSINKSTACK; state: ANY; headers: SYSTEM_RUNTIME_REMOTING_CHANNELS_ITRANSPORTHEADERS; stream: SYSTEM_IO_STREAM) is
		external
			"IL deferred signature (System.Runtime.Remoting.Channels.IClientResponseChannelSinkStack, System.Object, System.Runtime.Remoting.Channels.ITransportHeaders, System.IO.Stream): System.Void use System.Runtime.Remoting.Channels.IClientChannelSink"
		alias
			"AsyncProcessResponse"
		end

	get_request_stream (msg: SYSTEM_RUNTIME_REMOTING_MESSAGING_IMESSAGE; headers: SYSTEM_RUNTIME_REMOTING_CHANNELS_ITRANSPORTHEADERS): SYSTEM_IO_STREAM is
		external
			"IL deferred signature (System.Runtime.Remoting.Messaging.IMessage, System.Runtime.Remoting.Channels.ITransportHeaders): System.IO.Stream use System.Runtime.Remoting.Channels.IClientChannelSink"
		alias
			"GetRequestStream"
		end

end -- class SYSTEM_RUNTIME_REMOTING_CHANNELS_ICLIENTCHANNELSINK
