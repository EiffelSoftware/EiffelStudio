indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.Remoting.MetadataServices.SdlChannelSink"
	assembly: "System.Runtime.Remoting", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	RT_REMOTING_SDL_CHANNEL_SINK

inherit
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end
	ISERVER_CHANNEL_SINK
	ICHANNEL_SINK_BASE

create
	make

feature {NONE} -- Initialization

	frozen make (receiver: ICHANNEL_RECEIVER; next_sink: ISERVER_CHANNEL_SINK) is
		external
			"IL creator signature (System.Runtime.Remoting.Channels.IChannelReceiver, System.Runtime.Remoting.Channels.IServerChannelSink) use System.Runtime.Remoting.MetadataServices.SdlChannelSink"
		end

feature -- Access

	frozen get_next_channel_sink: ISERVER_CHANNEL_SINK is
		external
			"IL signature (): System.Runtime.Remoting.Channels.IServerChannelSink use System.Runtime.Remoting.MetadataServices.SdlChannelSink"
		alias
			"get_NextChannelSink"
		end

	frozen get_properties: IDICTIONARY is
		external
			"IL signature (): System.Collections.IDictionary use System.Runtime.Remoting.MetadataServices.SdlChannelSink"
		alias
			"get_Properties"
		end

feature -- Basic Operations

	frozen process_message (sink_stack: ISERVER_CHANNEL_SINK_STACK; request_msg: IMESSAGE; request_headers: ITRANSPORT_HEADERS; request_stream: SYSTEM_STREAM; response_msg: IMESSAGE; response_headers: ITRANSPORT_HEADERS; response_stream: SYSTEM_STREAM): SERVER_PROCESSING is
		external
			"IL signature (System.Runtime.Remoting.Channels.IServerChannelSinkStack, System.Runtime.Remoting.Messaging.IMessage, System.Runtime.Remoting.Channels.ITransportHeaders, System.IO.Stream, System.Runtime.Remoting.Messaging.IMessage&, System.Runtime.Remoting.Channels.ITransportHeaders&, System.IO.Stream&): System.Runtime.Remoting.Channels.ServerProcessing use System.Runtime.Remoting.MetadataServices.SdlChannelSink"
		alias
			"ProcessMessage"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Runtime.Remoting.MetadataServices.SdlChannelSink"
		alias
			"GetHashCode"
		end

	frozen async_process_response (sink_stack: ISERVER_RESPONSE_CHANNEL_SINK_STACK; state: SYSTEM_OBJECT; msg: IMESSAGE; headers: ITRANSPORT_HEADERS; stream: SYSTEM_STREAM) is
		external
			"IL signature (System.Runtime.Remoting.Channels.IServerResponseChannelSinkStack, System.Object, System.Runtime.Remoting.Messaging.IMessage, System.Runtime.Remoting.Channels.ITransportHeaders, System.IO.Stream): System.Void use System.Runtime.Remoting.MetadataServices.SdlChannelSink"
		alias
			"AsyncProcessResponse"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Runtime.Remoting.MetadataServices.SdlChannelSink"
		alias
			"ToString"
		end

	frozen get_response_stream (sink_stack: ISERVER_RESPONSE_CHANNEL_SINK_STACK; state: SYSTEM_OBJECT; msg: IMESSAGE; headers: ITRANSPORT_HEADERS): SYSTEM_STREAM is
		external
			"IL signature (System.Runtime.Remoting.Channels.IServerResponseChannelSinkStack, System.Object, System.Runtime.Remoting.Messaging.IMessage, System.Runtime.Remoting.Channels.ITransportHeaders): System.IO.Stream use System.Runtime.Remoting.MetadataServices.SdlChannelSink"
		alias
			"GetResponseStream"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Runtime.Remoting.MetadataServices.SdlChannelSink"
		alias
			"Equals"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use System.Runtime.Remoting.MetadataServices.SdlChannelSink"
		alias
			"Finalize"
		end

end -- class RT_REMOTING_SDL_CHANNEL_SINK
