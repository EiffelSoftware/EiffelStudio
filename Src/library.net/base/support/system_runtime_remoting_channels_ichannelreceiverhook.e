indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Runtime.Remoting.Channels.IChannelReceiverHook"

deferred external class
	SYSTEM_RUNTIME_REMOTING_CHANNELS_ICHANNELRECEIVERHOOK

inherit
	ANY
		undefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end

feature -- Access

	get_wants_to_listen: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use System.Runtime.Remoting.Channels.IChannelReceiverHook"
		alias
			"get_WantsToListen"
		end

	get_channel_sink_chain: SYSTEM_RUNTIME_REMOTING_CHANNELS_ISERVERCHANNELSINK is
		external
			"IL deferred signature (): System.Runtime.Remoting.Channels.IServerChannelSink use System.Runtime.Remoting.Channels.IChannelReceiverHook"
		alias
			"get_ChannelSinkChain"
		end

	get_channel_scheme: STRING is
		external
			"IL deferred signature (): System.String use System.Runtime.Remoting.Channels.IChannelReceiverHook"
		alias
			"get_ChannelScheme"
		end

feature -- Basic Operations

	add_hook_channel_uri (channelUri: STRING) is
		external
			"IL deferred signature (System.String): System.Void use System.Runtime.Remoting.Channels.IChannelReceiverHook"
		alias
			"AddHookChannelUri"
		end

end -- class SYSTEM_RUNTIME_REMOTING_CHANNELS_ICHANNELRECEIVERHOOK
