indexing
	Generator: "Eiffel Emitter 2.5b2"
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

	get_request_stream (msg: SYSTEM_RUNTIME_REMOTING_MESSAGING_IMESSAGE; headers: SYSTEM_RUNTIME_REMOTING_CHANNELS_ITRANSPORTHEADERS): SYSTEM_IO_STREAM is
		external
			"IL deferred signature (System.Runtime.Remoting.Messaging.IMessage, System.Runtime.Remoting.Channels.ITransportHeaders): System.IO.Stream use System.Runtime.Remoting.Channels.IClientChannelSink"
		alias
			"GetRequestStream"
		end

	process_message (msg: SYSTEM_RUNTIME_REMOTING_MESSAGING_IMESSAGE; requestHeaders: SYSTEM_RUNTIME_REMOTING_CHANNELS_ITRANSPORTHEADERS; requestStream: SYSTEM_IO_STREAM; responseHeaders: SYSTEM_RUNTIME_REMOTING_CHANNELS_ITRANSPORTHEADERS; responseStream: SYSTEM_IO_STREAM) is
		external
			"IL deferred signature (System.Runtime.Remoting.Messaging.IMessage, System.Runtime.Remoting.Channels.ITransportHeaders, System.IO.Stream, System.Runtime.Remoting.Channels.ITransportHeaders&, System.IO.Stream&): System.Void use System.Runtime.Remoting.Channels.IClientChannelSink"
		alias
			"ProcessMessage"
		end

	async_process_response (sinkStack: SYSTEM_RUNTIME_REMOTING_CHANNELS_ICLIENTRESPONSECHANNELSINKSTACK; state: ANY; headers: SYSTEM_RUNTIME_REMOTING_CHANNELS_ITRANSPORTHEADERS; stream: SYSTEM_IO_STREAM) is
		external
			"IL deferred signature (System.Runtime.Remoting.Channels.IClientResponseChannelSinkStack, System.Object, System.Runtime.Remoting.Channels.ITransportHeaders, System.IO.Stream): System.Void use System.Runtime.Remoting.Channels.IClientChannelSink"
		alias
			"AsyncProcessResponse"
		end

	async_process_request (sinkStack: SYSTEM_RUNTIME_REMOTING_CHANNELS_ICLIENTCHANNELSINKSTACK; msg: SYSTEM_RUNTIME_REMOTING_MESSAGING_IMESSAGE; headers: SYSTEM_RUNTIME_REMOTING_CHANNELS_ITRANSPORTHEADERS; stream: SYSTEM_IO_STREAM) is
		external
			"IL deferred signature (System.Runtime.Remoting.Channels.IClientChannelSinkStack, System.Runtime.Remoting.Messaging.IMessage, System.Runtime.Remoting.Channels.ITransportHeaders, System.IO.Stream): System.Void use System.Runtime.Remoting.Channels.IClientChannelSink"
		alias
			"AsyncProcessRequest"
		end

end -- class SYSTEM_RUNTIME_REMOTING_CHANNELS_ICLIENTCHANNELSINK
