indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Runtime.Remoting.Channels.IServerResponseChannelSinkStack"

deferred external class
	SYSTEM_RUNTIME_REMOTING_CHANNELS_ISERVERRESPONSECHANNELSINKSTACK

inherit
	ANY
		undefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end

feature -- Basic Operations

	async_process_response (msg: SYSTEM_RUNTIME_REMOTING_MESSAGING_IMESSAGE; headers: SYSTEM_RUNTIME_REMOTING_CHANNELS_ITRANSPORTHEADERS; stream: SYSTEM_IO_STREAM) is
		external
			"IL deferred signature (System.Runtime.Remoting.Messaging.IMessage, System.Runtime.Remoting.Channels.ITransportHeaders, System.IO.Stream): System.Void use System.Runtime.Remoting.Channels.IServerResponseChannelSinkStack"
		alias
			"AsyncProcessResponse"
		end

	get_response_stream (msg: SYSTEM_RUNTIME_REMOTING_MESSAGING_IMESSAGE; headers: SYSTEM_RUNTIME_REMOTING_CHANNELS_ITRANSPORTHEADERS): SYSTEM_IO_STREAM is
		external
			"IL deferred signature (System.Runtime.Remoting.Messaging.IMessage, System.Runtime.Remoting.Channels.ITransportHeaders): System.IO.Stream use System.Runtime.Remoting.Channels.IServerResponseChannelSinkStack"
		alias
			"GetResponseStream"
		end

end -- class SYSTEM_RUNTIME_REMOTING_CHANNELS_ISERVERRESPONSECHANNELSINKSTACK
