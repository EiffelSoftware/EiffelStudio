indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Runtime.Remoting.Channels.BinaryClientFormatterSink"

external class
	SYSTEM_RUNTIME_REMOTING_CHANNELS_BINARYCLIENTFORMATTERSINK

inherit
	ANY
		redefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end
	SYSTEM_RUNTIME_REMOTING_CHANNELS_ICLIENTCHANNELSINK
	SYSTEM_RUNTIME_REMOTING_MESSAGING_IMESSAGESINK
	SYSTEM_RUNTIME_REMOTING_CHANNELS_ICHANNELSINKBASE
	SYSTEM_RUNTIME_REMOTING_CHANNELS_ICLIENTFORMATTERSINK

create
	make

feature {NONE} -- Initialization

	frozen make (next_sink: SYSTEM_RUNTIME_REMOTING_CHANNELS_ICLIENTCHANNELSINK) is
		external
			"IL creator signature (System.Runtime.Remoting.Channels.IClientChannelSink) use System.Runtime.Remoting.Channels.BinaryClientFormatterSink"
		end

feature -- Access

	frozen get_next_channel_sink: SYSTEM_RUNTIME_REMOTING_CHANNELS_ICLIENTCHANNELSINK is
		external
			"IL signature (): System.Runtime.Remoting.Channels.IClientChannelSink use System.Runtime.Remoting.Channels.BinaryClientFormatterSink"
		alias
			"get_NextChannelSink"
		end

	frozen get_next_sink: SYSTEM_RUNTIME_REMOTING_MESSAGING_IMESSAGESINK is
		external
			"IL signature (): System.Runtime.Remoting.Messaging.IMessageSink use System.Runtime.Remoting.Channels.BinaryClientFormatterSink"
		alias
			"get_NextSink"
		end

	frozen get_properties: SYSTEM_COLLECTIONS_IDICTIONARY is
		external
			"IL signature (): System.Collections.IDictionary use System.Runtime.Remoting.Channels.BinaryClientFormatterSink"
		alias
			"get_Properties"
		end

feature -- Basic Operations

	to_string: STRING is
		external
			"IL signature (): System.String use System.Runtime.Remoting.Channels.BinaryClientFormatterSink"
		alias
			"ToString"
		end

	frozen async_process_request (sink_stack: SYSTEM_RUNTIME_REMOTING_CHANNELS_ICLIENTCHANNELSINKSTACK; msg: SYSTEM_RUNTIME_REMOTING_MESSAGING_IMESSAGE; headers: SYSTEM_RUNTIME_REMOTING_CHANNELS_ITRANSPORTHEADERS; stream: SYSTEM_IO_STREAM) is
		external
			"IL signature (System.Runtime.Remoting.Channels.IClientChannelSinkStack, System.Runtime.Remoting.Messaging.IMessage, System.Runtime.Remoting.Channels.ITransportHeaders, System.IO.Stream): System.Void use System.Runtime.Remoting.Channels.BinaryClientFormatterSink"
		alias
			"AsyncProcessRequest"
		end

	frozen sync_process_message (msg: SYSTEM_RUNTIME_REMOTING_MESSAGING_IMESSAGE): SYSTEM_RUNTIME_REMOTING_MESSAGING_IMESSAGE is
		external
			"IL signature (System.Runtime.Remoting.Messaging.IMessage): System.Runtime.Remoting.Messaging.IMessage use System.Runtime.Remoting.Channels.BinaryClientFormatterSink"
		alias
			"SyncProcessMessage"
		end

	frozen async_process_message (msg: SYSTEM_RUNTIME_REMOTING_MESSAGING_IMESSAGE; reply_sink: SYSTEM_RUNTIME_REMOTING_MESSAGING_IMESSAGESINK): SYSTEM_RUNTIME_REMOTING_MESSAGING_IMESSAGECTRL is
		external
			"IL signature (System.Runtime.Remoting.Messaging.IMessage, System.Runtime.Remoting.Messaging.IMessageSink): System.Runtime.Remoting.Messaging.IMessageCtrl use System.Runtime.Remoting.Channels.BinaryClientFormatterSink"
		alias
			"AsyncProcessMessage"
		end

	frozen get_request_stream (msg: SYSTEM_RUNTIME_REMOTING_MESSAGING_IMESSAGE; headers: SYSTEM_RUNTIME_REMOTING_CHANNELS_ITRANSPORTHEADERS): SYSTEM_IO_STREAM is
		external
			"IL signature (System.Runtime.Remoting.Messaging.IMessage, System.Runtime.Remoting.Channels.ITransportHeaders): System.IO.Stream use System.Runtime.Remoting.Channels.BinaryClientFormatterSink"
		alias
			"GetRequestStream"
		end

	frozen async_process_response (sink_stack: SYSTEM_RUNTIME_REMOTING_CHANNELS_ICLIENTRESPONSECHANNELSINKSTACK; state: ANY; headers: SYSTEM_RUNTIME_REMOTING_CHANNELS_ITRANSPORTHEADERS; stream: SYSTEM_IO_STREAM) is
		external
			"IL signature (System.Runtime.Remoting.Channels.IClientResponseChannelSinkStack, System.Object, System.Runtime.Remoting.Channels.ITransportHeaders, System.IO.Stream): System.Void use System.Runtime.Remoting.Channels.BinaryClientFormatterSink"
		alias
			"AsyncProcessResponse"
		end

	frozen process_message (msg: SYSTEM_RUNTIME_REMOTING_MESSAGING_IMESSAGE; request_headers: SYSTEM_RUNTIME_REMOTING_CHANNELS_ITRANSPORTHEADERS; request_stream: SYSTEM_IO_STREAM; response_headers: SYSTEM_RUNTIME_REMOTING_CHANNELS_ITRANSPORTHEADERS; response_stream: SYSTEM_IO_STREAM) is
		external
			"IL signature (System.Runtime.Remoting.Messaging.IMessage, System.Runtime.Remoting.Channels.ITransportHeaders, System.IO.Stream, System.Runtime.Remoting.Channels.ITransportHeaders&, System.IO.Stream&): System.Void use System.Runtime.Remoting.Channels.BinaryClientFormatterSink"
		alias
			"ProcessMessage"
		end

	is_equal (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Runtime.Remoting.Channels.BinaryClientFormatterSink"
		alias
			"Equals"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Runtime.Remoting.Channels.BinaryClientFormatterSink"
		alias
			"GetHashCode"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use System.Runtime.Remoting.Channels.BinaryClientFormatterSink"
		alias
			"Finalize"
		end

end -- class SYSTEM_RUNTIME_REMOTING_CHANNELS_BINARYCLIENTFORMATTERSINK
