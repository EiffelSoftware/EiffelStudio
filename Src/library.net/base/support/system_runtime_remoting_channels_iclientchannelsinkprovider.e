indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Runtime.Remoting.Channels.IClientChannelSinkProvider"

deferred external class
	SYSTEM_RUNTIME_REMOTING_CHANNELS_ICLIENTCHANNELSINKPROVIDER

inherit
	ANY
		undefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end

feature -- Access

	get_next: SYSTEM_RUNTIME_REMOTING_CHANNELS_ICLIENTCHANNELSINKPROVIDER is
		external
			"IL deferred signature (): System.Runtime.Remoting.Channels.IClientChannelSinkProvider use System.Runtime.Remoting.Channels.IClientChannelSinkProvider"
		alias
			"get_Next"
		end

feature -- Element Change

	set_next (value: SYSTEM_RUNTIME_REMOTING_CHANNELS_ICLIENTCHANNELSINKPROVIDER) is
		external
			"IL deferred signature (System.Runtime.Remoting.Channels.IClientChannelSinkProvider): System.Void use System.Runtime.Remoting.Channels.IClientChannelSinkProvider"
		alias
			"set_Next"
		end

feature -- Basic Operations

	create_sink (channel: SYSTEM_RUNTIME_REMOTING_CHANNELS_ICHANNELSENDER; url: STRING; remote_channel_data: ANY): SYSTEM_RUNTIME_REMOTING_CHANNELS_ICLIENTCHANNELSINK is
		external
			"IL deferred signature (System.Runtime.Remoting.Channels.IChannelSender, System.String, System.Object): System.Runtime.Remoting.Channels.IClientChannelSink use System.Runtime.Remoting.Channels.IClientChannelSinkProvider"
		alias
			"CreateSink"
		end

end -- class SYSTEM_RUNTIME_REMOTING_CHANNELS_ICLIENTCHANNELSINKPROVIDER
