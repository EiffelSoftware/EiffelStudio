indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.Remoting.Channels.IChannel"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	ICHANNEL

inherit
	SYSTEM_OBJECT
		undefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end

feature -- Access

	get_channel_name: SYSTEM_STRING is
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

	parse (url: SYSTEM_STRING; object_uri: SYSTEM_STRING): SYSTEM_STRING is
		external
			"IL deferred signature (System.String, System.String&): System.String use System.Runtime.Remoting.Channels.IChannel"
		alias
			"Parse"
		end

end -- class ICHANNEL
