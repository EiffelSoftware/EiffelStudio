indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Runtime.Remoting.Channels.IServerChannelSinkProvider"

deferred external class
	SYSTEM_RUNTIME_REMOTING_CHANNELS_ISERVERCHANNELSINKPROVIDER

inherit
	ANY
		undefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end

feature -- Access

	get_next: SYSTEM_RUNTIME_REMOTING_CHANNELS_ISERVERCHANNELSINKPROVIDER is
		external
			"IL deferred signature (): System.Runtime.Remoting.Channels.IServerChannelSinkProvider use System.Runtime.Remoting.Channels.IServerChannelSinkProvider"
		alias
			"get_Next"
		end

feature -- Element Change

	set_next (value: SYSTEM_RUNTIME_REMOTING_CHANNELS_ISERVERCHANNELSINKPROVIDER) is
		external
			"IL deferred signature (System.Runtime.Remoting.Channels.IServerChannelSinkProvider): System.Void use System.Runtime.Remoting.Channels.IServerChannelSinkProvider"
		alias
			"set_Next"
		end

feature -- Basic Operations

	create_sink (channel: SYSTEM_RUNTIME_REMOTING_CHANNELS_ICHANNELRECEIVER): SYSTEM_RUNTIME_REMOTING_CHANNELS_ISERVERCHANNELSINK is
		external
			"IL deferred signature (System.Runtime.Remoting.Channels.IChannelReceiver): System.Runtime.Remoting.Channels.IServerChannelSink use System.Runtime.Remoting.Channels.IServerChannelSinkProvider"
		alias
			"CreateSink"
		end

	get_channel_data (channelData: SYSTEM_RUNTIME_REMOTING_CHANNELS_ICHANNELDATASTORE) is
		external
			"IL deferred signature (System.Runtime.Remoting.Channels.IChannelDataStore): System.Void use System.Runtime.Remoting.Channels.IServerChannelSinkProvider"
		alias
			"GetChannelData"
		end

end -- class SYSTEM_RUNTIME_REMOTING_CHANNELS_ISERVERCHANNELSINKPROVIDER
