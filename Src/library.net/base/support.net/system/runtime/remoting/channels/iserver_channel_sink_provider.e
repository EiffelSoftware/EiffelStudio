indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.Remoting.Channels.IServerChannelSinkProvider"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	ISERVER_CHANNEL_SINK_PROVIDER

inherit
	SYSTEM_OBJECT
		undefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end

feature -- Access

	get_next: ISERVER_CHANNEL_SINK_PROVIDER is
		external
			"IL deferred signature (): System.Runtime.Remoting.Channels.IServerChannelSinkProvider use System.Runtime.Remoting.Channels.IServerChannelSinkProvider"
		alias
			"get_Next"
		end

feature -- Element Change

	set_next (value: ISERVER_CHANNEL_SINK_PROVIDER) is
		external
			"IL deferred signature (System.Runtime.Remoting.Channels.IServerChannelSinkProvider): System.Void use System.Runtime.Remoting.Channels.IServerChannelSinkProvider"
		alias
			"set_Next"
		end

feature -- Basic Operations

	create_sink (channel: ICHANNEL_RECEIVER): ISERVER_CHANNEL_SINK is
		external
			"IL deferred signature (System.Runtime.Remoting.Channels.IChannelReceiver): System.Runtime.Remoting.Channels.IServerChannelSink use System.Runtime.Remoting.Channels.IServerChannelSinkProvider"
		alias
			"CreateSink"
		end

	get_channel_data (channel_data: ICHANNEL_DATA_STORE) is
		external
			"IL deferred signature (System.Runtime.Remoting.Channels.IChannelDataStore): System.Void use System.Runtime.Remoting.Channels.IServerChannelSinkProvider"
		alias
			"GetChannelData"
		end

end -- class ISERVER_CHANNEL_SINK_PROVIDER
