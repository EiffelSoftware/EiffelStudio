indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Runtime.Remoting.Channels.ClientChannelSinkStack"

external class
	SYSTEM_RUNTIME_REMOTING_CHANNELS_CLIENTCHANNELSINKSTACK

inherit
	ANY
		redefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end
	SYSTEM_RUNTIME_REMOTING_CHANNELS_ICLIENTCHANNELSINKSTACK
	SYSTEM_RUNTIME_REMOTING_CHANNELS_ICLIENTRESPONSECHANNELSINKSTACK

create
	make,
	make_1

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.Runtime.Remoting.Channels.ClientChannelSinkStack"
		end

	frozen make_1 (replySink: SYSTEM_RUNTIME_REMOTING_MESSAGING_IMESSAGESINK) is
		external
			"IL creator signature (System.Runtime.Remoting.Messaging.IMessageSink) use System.Runtime.Remoting.Channels.ClientChannelSinkStack"
		end

feature -- Basic Operations

	frozen remove (sink: SYSTEM_RUNTIME_REMOTING_CHANNELS_ICLIENTCHANNELSINK): ANY is
		external
			"IL signature (System.Runtime.Remoting.Channels.IClientChannelSink): System.Object use System.Runtime.Remoting.Channels.ClientChannelSinkStack"
		alias
			"Pop"
		end

	frozen put (sink: SYSTEM_RUNTIME_REMOTING_CHANNELS_ICLIENTCHANNELSINK; state: ANY) is
		external
			"IL signature (System.Runtime.Remoting.Channels.IClientChannelSink, System.Object): System.Void use System.Runtime.Remoting.Channels.ClientChannelSinkStack"
		alias
			"Push"
		end

	is_equal (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Runtime.Remoting.Channels.ClientChannelSinkStack"
		alias
			"Equals"
		end

	frozen dispatch_exception (e: SYSTEM_EXCEPTION) is
		external
			"IL signature (System.Exception): System.Void use System.Runtime.Remoting.Channels.ClientChannelSinkStack"
		alias
			"DispatchException"
		end

	frozen dispatch_reply_message (msg: SYSTEM_RUNTIME_REMOTING_MESSAGING_IMESSAGE) is
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

	frozen async_process_response (headers: SYSTEM_RUNTIME_REMOTING_CHANNELS_ITRANSPORTHEADERS; stream: SYSTEM_IO_STREAM) is
		external
			"IL signature (System.Runtime.Remoting.Channels.ITransportHeaders, System.IO.Stream): System.Void use System.Runtime.Remoting.Channels.ClientChannelSinkStack"
		alias
			"AsyncProcessResponse"
		end

	to_string: STRING is
		external
			"IL signature (): System.String use System.Runtime.Remoting.Channels.ClientChannelSinkStack"
		alias
			"ToString"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use System.Runtime.Remoting.Channels.ClientChannelSinkStack"
		alias
			"Finalize"
		end

end -- class SYSTEM_RUNTIME_REMOTING_CHANNELS_CLIENTCHANNELSINKSTACK
