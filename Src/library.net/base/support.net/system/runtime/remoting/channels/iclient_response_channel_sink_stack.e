indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.Remoting.Channels.IClientResponseChannelSinkStack"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	ICLIENT_RESPONSE_CHANNEL_SINK_STACK

inherit
	SYSTEM_OBJECT
		undefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end

feature -- Basic Operations

	dispatch_exception (e: EXCEPTION) is
		external
			"IL deferred signature (System.Exception): System.Void use System.Runtime.Remoting.Channels.IClientResponseChannelSinkStack"
		alias
			"DispatchException"
		end

	dispatch_reply_message (msg: IMESSAGE) is
		external
			"IL deferred signature (System.Runtime.Remoting.Messaging.IMessage): System.Void use System.Runtime.Remoting.Channels.IClientResponseChannelSinkStack"
		alias
			"DispatchReplyMessage"
		end

	async_process_response (headers: ITRANSPORT_HEADERS; stream: SYSTEM_STREAM) is
		external
			"IL deferred signature (System.Runtime.Remoting.Channels.ITransportHeaders, System.IO.Stream): System.Void use System.Runtime.Remoting.Channels.IClientResponseChannelSinkStack"
		alias
			"AsyncProcessResponse"
		end

end -- class ICLIENT_RESPONSE_CHANNEL_SINK_STACK
