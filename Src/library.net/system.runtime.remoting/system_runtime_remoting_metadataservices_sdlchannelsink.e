indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Runtime.Remoting.MetadataServices.SdlChannelSink"

external class
	SYSTEM_RUNTIME_REMOTING_METADATASERVICES_SDLCHANNELSINK

inherit
	ANY
		redefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end
	SYSTEM_RUNTIME_REMOTING_CHANNELS_ICHANNELSINKBASE
	SYSTEM_RUNTIME_REMOTING_CHANNELS_ISERVERCHANNELSINK

create
	make

feature {NONE} -- Initialization

	frozen make (receiver: SYSTEM_RUNTIME_REMOTING_CHANNELS_ICHANNELRECEIVER; next_sink: SYSTEM_RUNTIME_REMOTING_CHANNELS_ISERVERCHANNELSINK) is
		external
			"IL creator signature (System.Runtime.Remoting.Channels.IChannelReceiver, System.Runtime.Remoting.Channels.IServerChannelSink) use System.Runtime.Remoting.MetadataServices.SdlChannelSink"
		end

feature -- Access

	frozen get_next_channel_sink: SYSTEM_RUNTIME_REMOTING_CHANNELS_ISERVERCHANNELSINK is
		external
			"IL signature (): System.Runtime.Remoting.Channels.IServerChannelSink use System.Runtime.Remoting.MetadataServices.SdlChannelSink"
		alias
			"get_NextChannelSink"
		end

	frozen get_properties: SYSTEM_COLLECTIONS_IDICTIONARY is
		external
			"IL signature (): System.Collections.IDictionary use System.Runtime.Remoting.MetadataServices.SdlChannelSink"
		alias
			"get_Properties"
		end

feature -- Basic Operations

	frozen process_message (sink_stack: SYSTEM_RUNTIME_REMOTING_CHANNELS_ISERVERCHANNELSINKSTACK; request_headers: SYSTEM_RUNTIME_REMOTING_CHANNELS_ITRANSPORTHEADERS; request_stream: SYSTEM_IO_STREAM; msg: SYSTEM_RUNTIME_REMOTING_MESSAGING_IMESSAGE; response_headers: SYSTEM_RUNTIME_REMOTING_CHANNELS_ITRANSPORTHEADERS; response_stream: SYSTEM_IO_STREAM): SYSTEM_RUNTIME_REMOTING_CHANNELS_SERVERPROCESSING is
		external
			"IL signature (System.Runtime.Remoting.Channels.IServerChannelSinkStack, System.Runtime.Remoting.Channels.ITransportHeaders, System.IO.Stream, System.Runtime.Remoting.Messaging.IMessage&, System.Runtime.Remoting.Channels.ITransportHeaders&, System.IO.Stream&): System.Runtime.Remoting.Channels.ServerProcessing use System.Runtime.Remoting.MetadataServices.SdlChannelSink"
		alias
			"ProcessMessage"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Runtime.Remoting.MetadataServices.SdlChannelSink"
		alias
			"GetHashCode"
		end

	frozen async_process_response (sink_stack: SYSTEM_RUNTIME_REMOTING_CHANNELS_ISERVERRESPONSECHANNELSINKSTACK; state: ANY; msg: SYSTEM_RUNTIME_REMOTING_MESSAGING_IMESSAGE; headers: SYSTEM_RUNTIME_REMOTING_CHANNELS_ITRANSPORTHEADERS; stream: SYSTEM_IO_STREAM) is
		external
			"IL signature (System.Runtime.Remoting.Channels.IServerResponseChannelSinkStack, System.Object, System.Runtime.Remoting.Messaging.IMessage, System.Runtime.Remoting.Channels.ITransportHeaders, System.IO.Stream): System.Void use System.Runtime.Remoting.MetadataServices.SdlChannelSink"
		alias
			"AsyncProcessResponse"
		end

	to_string: STRING is
		external
			"IL signature (): System.String use System.Runtime.Remoting.MetadataServices.SdlChannelSink"
		alias
			"ToString"
		end

	frozen get_response_stream (sink_stack: SYSTEM_RUNTIME_REMOTING_CHANNELS_ISERVERRESPONSECHANNELSINKSTACK; state: ANY; msg: SYSTEM_RUNTIME_REMOTING_MESSAGING_IMESSAGE; headers: SYSTEM_RUNTIME_REMOTING_CHANNELS_ITRANSPORTHEADERS): SYSTEM_IO_STREAM is
		external
			"IL signature (System.Runtime.Remoting.Channels.IServerResponseChannelSinkStack, System.Object, System.Runtime.Remoting.Messaging.IMessage, System.Runtime.Remoting.Channels.ITransportHeaders): System.IO.Stream use System.Runtime.Remoting.MetadataServices.SdlChannelSink"
		alias
			"GetResponseStream"
		end

	is_equal (obj: ANY): BOOLEAN is
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

end -- class SYSTEM_RUNTIME_REMOTING_METADATASERVICES_SDLCHANNELSINK
