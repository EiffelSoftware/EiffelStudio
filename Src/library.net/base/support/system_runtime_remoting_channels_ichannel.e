indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Runtime.Remoting.Channels.IChannel"

deferred external class
	SYSTEM_RUNTIME_REMOTING_CHANNELS_ICHANNEL

inherit
	ANY
		undefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end

feature -- Access

	get_channel_name: STRING is
		external
			"IL deferred signature (): System.String use System.Runtime.Remoting.Channels.IChannel"
		alias
			"get_ChannelName"
		end

	get_channel_priority: INTEGER is
		external
			"IL deferred signature (): System.Int32 use System.Runtime.Remoting.Channels.IChannel"
		alias
			"get_ChannelPriority"
		end

feature -- Basic Operations

	parse (url: STRING; objectURI: STRING): STRING is
		external
			"IL deferred signature (System.String, System.String&): System.String use System.Runtime.Remoting.Channels.IChannel"
		alias
			"Parse"
		end

end -- class SYSTEM_RUNTIME_REMOTING_CHANNELS_ICHANNEL
