indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Runtime.Remoting.Channels.IClientResponseChannelSinkStack"

deferred external class
	SYSTEM_RUNTIME_REMOTING_CHANNELS_ICLIENTRESPONSECHANNELSINKSTACK

inherit
	ANY
		undefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end

feature -- Basic Operations

	dispatch_exception (e: SYSTEM_EXCEPTION) is
		external
			"IL deferred signature (System.Exception): System.Void use System.Runtime.Remoting.Channels.IClientResponseChannelSinkStack"
		alias
			"DispatchException"
		end

	dispatch_reply_message (msg: SYSTEM_RUNTIME_REMOTING_MESSAGING_IMESSAGE) is
		external
			"IL deferred signature (System.Runtime.Remoting.Messaging.IMessage): System.Void use System.Runtime.Remoting.Channels.IClientResponseChannelSinkStack"
		alias
			"DispatchReplyMessage"
		end

	async_process_response (headers: SYSTEM_RUNTIME_REMOTING_CHANNELS_ITRANSPORTHEADERS; stream: SYSTEM_IO_STREAM) is
		external
			"IL deferred signature (System.Runtime.Remoting.Channels.ITransportHeaders, System.IO.Stream): System.Void use System.Runtime.Remoting.Channels.IClientResponseChannelSinkStack"
		alias
			"AsyncProcessResponse"
		end

end -- class SYSTEM_RUNTIME_REMOTING_CHANNELS_ICLIENTRESPONSECHANNELSINKSTACK
