indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.Remoting.Channels.IChannelReceiverHook"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	ICHANNEL_RECEIVER_HOOK

inherit
	SYSTEM_OBJECT
		undefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end

feature -- Access

	get_wants_to_listen: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use System.Runtime.Remoting.Channels.IChannelReceiverHook"
		alias
			"get_WantsToListen"
		end

	get_channel_sink_chain: ISERVER_CHANNEL_SINK is
		external
			"IL deferred signature (): System.Runtime.Remoting.Channels.IServerChannelSink use System.Runtime.Remoting.Channels.IChannelReceiverHook"
		alias
			"get_ChannelSinkChain"
		end

	get_channel_scheme: SYSTEM_STRING is
		external
			"IL deferred signature (): System.String use System.Runtime.Remoting.Channels.IChannelReceiverHook"
		alias
			"get_ChannelScheme"
		end

feature -- Basic Operations

	add_hook_channel_uri (channel_uri: SYSTEM_STRING) is
		external
			"IL deferred signature (System.String): System.Void use System.Runtime.Remoting.Channels.IChannelReceiverHook"
		alias
			"AddHookChannelUri"
		end

end -- class ICHANNEL_RECEIVER_HOOK
