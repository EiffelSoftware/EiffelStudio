indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.Remoting.Channels.IClientChannelSinkProvider"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	ICLIENT_CHANNEL_SINK_PROVIDER

inherit
	SYSTEM_OBJECT
		undefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end

feature -- Access

	get_next: ICLIENT_CHANNEL_SINK_PROVIDER is
		external
			"IL deferred signature (): System.Runtime.Remoting.Channels.IClientChannelSinkProvider use System.Runtime.Remoting.Channels.IClientChannelSinkProvider"
		alias
			"get_Next"
		end

feature -- Element Change

	set_next (value: ICLIENT_CHANNEL_SINK_PROVIDER) is
		external
			"IL deferred signature (System.Runtime.Remoting.Channels.IClientChannelSinkProvider): System.Void use System.Runtime.Remoting.Channels.IClientChannelSinkProvider"
		alias
			"set_Next"
		end

feature -- Basic Operations

	create_sink (channel: ICHANNEL_SENDER; url: SYSTEM_STRING; remote_channel_data: SYSTEM_OBJECT): ICLIENT_CHANNEL_SINK is
		external
			"IL deferred signature (System.Runtime.Remoting.Channels.IChannelSender, System.String, System.Object): System.Runtime.Remoting.Channels.IClientChannelSink use System.Runtime.Remoting.Channels.IClientChannelSinkProvider"
		alias
			"CreateSink"
		end

end -- class ICLIENT_CHANNEL_SINK_PROVIDER
