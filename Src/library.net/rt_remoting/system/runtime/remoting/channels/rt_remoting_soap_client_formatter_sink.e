indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.Remoting.Channels.SoapClientFormatterSink"
	assembly: "System.Runtime.Remoting", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	RT_REMOTING_SOAP_CLIENT_FORMATTER_SINK

inherit
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end
	ICLIENT_FORMATTER_SINK
	IMESSAGE_SINK
	ICLIENT_CHANNEL_SINK
	ICHANNEL_SINK_BASE

create
	make

feature {NONE} -- Initialization

	frozen make (next_sink: ICLIENT_CHANNEL_SINK) is
		external
			"IL creator signature (System.Runtime.Remoting.Channels.IClientChannelSink) use System.Runtime.Remoting.Channels.SoapClientFormatterSink"
		end

feature -- Access

	frozen get_next_channel_sink: ICLIENT_CHANNEL_SINK is
		external
			"IL signature (): System.Runtime.Remoting.Channels.IClientChannelSink use System.Runtime.Remoting.Channels.SoapClientFormatterSink"
		alias
			"get_NextChannelSink"
		end

	frozen get_next_sink: IMESSAGE_SINK is
		external
			"IL signature (): System.Runtime.Remoting.Messaging.IMessageSink use System.Runtime.Remoting.Channels.SoapClientFormatterSink"
		alias
			"get_NextSink"
		end

	frozen get_properties: IDICTIONARY is
		external
			"IL signature (): System.Collections.IDictionary use System.Runtime.Remoting.Channels.SoapClientFormatterSink"
		alias
			"get_Properties"
		end

feature -- Basic Operations

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Runtime.Remoting.Channels.SoapClientFormatterSink"
		alias
			"ToString"
		end

	frozen async_process_request (sink_stack: ICLIENT_CHANNEL_SINK_STACK; msg: IMESSAGE; headers: ITRANSPORT_HEADERS; stream: SYSTEM_STREAM) is
		external
			"IL signature (System.Runtime.Remoting.Channels.IClientChannelSinkStack, System.Runtime.Remoting.Messaging.IMessage, System.Runtime.Remoting.Channels.ITransportHeaders, System.IO.Stream): System.Void use System.Runtime.Remoting.Channels.SoapClientFormatterSink"
		alias
			"AsyncProcessRequest"
		end

	frozen sync_process_message (msg: IMESSAGE): IMESSAGE is
		external
			"IL signature (System.Runtime.Remoting.Messaging.IMessage): System.Runtime.Remoting.Messaging.IMessage use System.Runtime.Remoting.Channels.SoapClientFormatterSink"
		alias
			"SyncProcessMessage"
		end

	frozen async_process_message (msg: IMESSAGE; reply_sink: IMESSAGE_SINK): IMESSAGE_CTRL is
		external
			"IL signature (System.Runtime.Remoting.Messaging.IMessage, System.Runtime.Remoting.Messaging.IMessageSink): System.Runtime.Remoting.Messaging.IMessageCtrl use System.Runtime.Remoting.Channels.SoapClientFormatterSink"
		alias
			"AsyncProcessMessage"
		end

	frozen get_request_stream (msg: IMESSAGE; headers: ITRANSPORT_HEADERS): SYSTEM_STREAM is
		external
			"IL signature (System.Runtime.Remoting.Messaging.IMessage, System.Runtime.Remoting.Channels.ITransportHeaders): System.IO.Stream use System.Runtime.Remoting.Channels.SoapClientFormatterSink"
		alias
			"GetRequestStream"
		end

	frozen async_process_response (sink_stack: ICLIENT_RESPONSE_CHANNEL_SINK_STACK; state: SYSTEM_OBJECT; headers: ITRANSPORT_HEADERS; stream: SYSTEM_STREAM) is
		external
			"IL signature (System.Runtime.Remoting.Channels.IClientResponseChannelSinkStack, System.Object, System.Runtime.Remoting.Channels.ITransportHeaders, System.IO.Stream): System.Void use System.Runtime.Remoting.Channels.SoapClientFormatterSink"
		alias
			"AsyncProcessResponse"
		end

	frozen process_message (msg: IMESSAGE; request_headers: ITRANSPORT_HEADERS; request_stream: SYSTEM_STREAM; response_headers: ITRANSPORT_HEADERS; response_stream: SYSTEM_STREAM) is
		external
			"IL signature (System.Runtime.Remoting.Messaging.IMessage, System.Runtime.Remoting.Channels.ITransportHeaders, System.IO.Stream, System.Runtime.Remoting.Channels.ITransportHeaders&, System.IO.Stream&): System.Void use System.Runtime.Remoting.Channels.SoapClientFormatterSink"
		alias
			"ProcessMessage"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Runtime.Remoting.Channels.SoapClientFormatterSink"
		alias
			"Equals"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Runtime.Remoting.Channels.SoapClientFormatterSink"
		alias
			"GetHashCode"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use System.Runtime.Remoting.Channels.SoapClientFormatterSink"
		alias
			"Finalize"
		end

end -- class RT_REMOTING_SOAP_CLIENT_FORMATTER_SINK
