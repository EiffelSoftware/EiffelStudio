indexing
	Generator: "Eiffel Emitter 2.5b2"
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

	get_response_stream (sinkStack: SYSTEM_RUNTIME_REMOTING_CHANNELS_ISERVERRESPONSECHANNELSINKSTACK; state: ANY; msg: SYSTEM_RUNTIME_REMOTING_MESSAGING_IMESSAGE; headers: SYSTEM_RUNTIME_REMOTING_CHANNELS_ITRANSPORTHEADERS): SYSTEM_IO_STREAM is
		external
			"IL deferred signature (System.Runtime.Remoting.Channels.IServerResponseChannelSinkStack, System.Object, System.Runtime.Remoting.Messaging.IMessage, System.Runtime.Remoting.Channels.ITransportHeaders): System.IO.Stream use System.Runtime.Remoting.Channels.IServerChannelSink"
		alias
			"GetResponseStream"
		end

	async_process_response (sinkStack: SYSTEM_RUNTIME_REMOTING_CHANNELS_ISERVERRESPONSECHANNELSINKSTACK; state: ANY; msg: SYSTEM_RUNTIME_REMOTING_MESSAGING_IMESSAGE; headers: SYSTEM_RUNTIME_REMOTING_CHANNELS_ITRANSPORTHEADERS; stream: SYSTEM_IO_STREAM) is
		external
			"IL deferred signature (System.Runtime.Remoting.Channels.IServerResponseChannelSinkStack, System.Object, System.Runtime.Remoting.Messaging.IMessage, System.Runtime.Remoting.Channels.ITransportHeaders, System.IO.Stream): System.Void use System.Runtime.Remoting.Channels.IServerChannelSink"
		alias
			"AsyncProcessResponse"
		end

	process_message (sinkStack: SYSTEM_RUNTIME_REMOTING_CHANNELS_ISERVERCHANNELSINKSTACK; requestHeaders: SYSTEM_RUNTIME_REMOTING_CHANNELS_ITRANSPORTHEADERS; requestStream: SYSTEM_IO_STREAM; msg: SYSTEM_RUNTIME_REMOTING_MESSAGING_IMESSAGE; responseHeaders: SYSTEM_RUNTIME_REMOTING_CHANNELS_ITRANSPORTHEADERS; responseStream: SYSTEM_IO_STREAM): INTEGER is
		external
			"IL deferred signature (System.Runtime.Remoting.Channels.IServerChannelSinkStack, System.Runtime.Remoting.Channels.ITransportHeaders, System.IO.Stream, System.Runtime.Remoting.Messaging.IMessage&, System.Runtime.Remoting.Channels.ITransportHeaders&, System.IO.Stream&): enum System.Runtime.Remoting.Channels.ServerProcessing use System.Runtime.Remoting.Channels.IServerChannelSink"
		alias
			"ProcessMessage"
		ensure
			valid_server_processing: Result = 0 or Result = 1 or Result = 2
		end

end -- class SYSTEM_RUNTIME_REMOTING_CHANNELS_ISERVERCHANNELSINK
