indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Runtime.Remoting.Channels.IServerChannelSink"

deferred external class
	SYSTEM_RUNTIME_REMOTING_CHANNELS_ISERVERCHANNELSINK

inherit
	SYSTEM_RUNTIME_REMOTING_CHANNELS_ICHANNELSINKBASE

feature -- Access

	get_next_channel_sink: SYSTEM_RUNTIME_REMOTING_CHANNELS_ISERVERCHANNELSINK is
		external
			"IL deferred signature (): System.Runtime.Remoting.Channels.IServerChannelSink use System.Runtime.Remoting.Channels.IServerChannelSink"
		alias
			"get_NextChannelSink"
		end

feature -- Basic Operations

	process_message (sink_stack: SYSTEM_RUNTIME_REMOTING_CHANNELS_ISERVERCHANNELSINKSTACK; request_headers: SYSTEM_RUNTIME_REMOTING_CHANNELS_ITRANSPORTHEADERS; request_stream: SYSTEM_IO_STREAM; msg: SYSTEM_RUNTIME_REMOTING_MESSAGING_IMESSAGE; response_headers: SYSTEM_RUNTIME_REMOTING_CHANNELS_ITRANSPORTHEADERS; response_stream: SYSTEM_IO_STREAM): SYSTEM_RUNTIME_REMOTING_CHANNELS_SERVERPROCESSING is
		external
			"IL deferred signature (System.Runtime.Remoting.Channels.IServerChannelSinkStack, System.Runtime.Remoting.Channels.ITransportHeaders, System.IO.Stream, System.Runtime.Remoting.Messaging.IMessage&, System.Runtime.Remoting.Channels.ITransportHeaders&, System.IO.Stream&): System.Runtime.Remoting.Channels.ServerProcessing use System.Runtime.Remoting.Channels.IServerChannelSink"
		alias
			"ProcessMessage"
		end

	async_process_response (sink_stack: SYSTEM_RUNTIME_REMOTING_CHANNELS_ISERVERRESPONSECHANNELSINKSTACK; state: ANY; msg: SYSTEM_RUNTIME_REMOTING_MESSAGING_IMESSAGE; headers: SYSTEM_RUNTIME_REMOTING_CHANNELS_ITRANSPORTHEADERS; stream: SYSTEM_IO_STREAM) is
		external
			"IL deferred signature (System.Runtime.Remoting.Channels.IServerResponseChannelSinkStack, System.Object, System.Runtime.Remoting.Messaging.IMessage, System.Runtime.Remoting.Channels.ITransportHeaders, System.IO.Stream): System.Void use System.Runtime.Remoting.Channels.IServerChannelSink"
		alias
			"AsyncProcessResponse"
		end

	get_response_stream (sink_stack: SYSTEM_RUNTIME_REMOTING_CHANNELS_ISERVERRESPONSECHANNELSINKSTACK; state: ANY; msg: SYSTEM_RUNTIME_REMOTING_MESSAGING_IMESSAGE; headers: SYSTEM_RUNTIME_REMOTING_CHANNELS_ITRANSPORTHEADERS): SYSTEM_IO_STREAM is
		external
			"IL deferred signature (System.Runtime.Remoting.Channels.IServerResponseChannelSinkStack, System.Object, System.Runtime.Remoting.Messaging.IMessage, System.Runtime.Remoting.Channels.ITransportHeaders): System.IO.Stream use System.Runtime.Remoting.Channels.IServerChannelSink"
		alias
			"GetResponseStream"
		end

end -- class SYSTEM_RUNTIME_REMOTING_CHANNELS_ISERVERCHANNELSINK
