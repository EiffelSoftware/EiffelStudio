indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.Remoting.Channels.ClientChannelSinkStack"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	CLIENT_CHANNEL_SINK_STACK

inherit
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end
	ICLIENT_CHANNEL_SINK_STACK
	ICLIENT_RESPONSE_CHANNEL_SINK_STACK

create
	make,
	make_1

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.Runtime.Remoting.Channels.ClientChannelSinkStack"
		end

	frozen make_1 (reply_sink: IMESSAGE_SINK) is
		external
			"IL creator signature (System.Runtime.Remoting.Messaging.IMessageSink) use System.Runtime.Remoting.Channels.ClientChannelSinkStack"
		end

feature -- Basic Operations

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Runtime.Remoting.Channels.ClientChannelSinkStack"
		alias
			"ToString"
		end

	frozen push (sink: ICLIENT_CHANNEL_SINK; state: SYSTEM_OBJECT) is
		external
			"IL signature (System.Runtime.Remoting.Channels.IClientChannelSink, System.Object): System.Void use System.Runtime.Remoting.Channels.ClientChannelSinkStack"
		alias
			"Push"
		end

	frozen pop (sink: ICLIENT_CHANNEL_SINK): SYSTEM_OBJECT is
		external
			"IL signature (System.Runtime.Remoting.Channels.IClientChannelSink): System.Object use System.Runtime.Remoting.Channels.ClientChannelSinkStack"
		alias
			"Pop"
		end

	frozen async_process_response (headers: ITRANSPORT_HEADERS; stream: SYSTEM_STREAM) is
		external
			"IL signature (System.Runtime.Remoting.Channels.ITransportHeaders, System.IO.Stream): System.Void use System.Runtime.Remoting.Channels.ClientChannelSinkStack"
		alias
			"AsyncProcessResponse"
		end

	frozen dispatch_exception (e: EXCEPTION) is
		external
			"IL signature (System.Exception): System.Void use System.Runtime.Remoting.Channels.ClientChannelSinkStack"
		alias
			"DispatchException"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Runtime.Remoting.Channels.ClientChannelSinkStack"
		alias
			"Equals"
		end

	frozen dispatch_reply_message (msg: IMESSAGE) is
		external
			"IL signature (System.Runtime.Remoting.Messaging.IMessage): System.Void use System.Runtime.Remoting.Channels.ClientChannelSinkStack"
		alias
			"DispatchReplyMessage"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Runtime.Remoting.Channels.ClientChannelSinkStack"
		alias
			"GetHashCode"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use System.Runtime.Remoting.Channels.ClientChannelSinkStack"
		alias
			"Finalize"
		end

end -- class CLIENT_CHANNEL_SINK_STACK
