indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Runtime.Remoting.Channels.IClientChannelSinkStack"

deferred external class
	SYSTEM_RUNTIME_REMOTING_CHANNELS_ICLIENTCHANNELSINKSTACK

inherit
	SYSTEM_RUNTIME_REMOTING_CHANNELS_ICLIENTRESPONSECHANNELSINKSTACK

feature -- Basic Operations

	put (sink: SYSTEM_RUNTIME_REMOTING_CHANNELS_ICLIENTCHANNELSINK; state: ANY) is
		external
			"IL deferred signature (System.Runtime.Remoting.Channels.IClientChannelSink, System.Object): System.Void use System.Runtime.Remoting.Channels.IClientChannelSinkStack"
		alias
			"Push"
		end

	remove (sink: SYSTEM_RUNTIME_REMOTING_CHANNELS_ICLIENTCHANNELSINK): ANY is
		external
			"IL deferred signature (System.Runtime.Remoting.Channels.IClientChannelSink): System.Object use System.Runtime.Remoting.Channels.IClientChannelSinkStack"
		alias
			"Pop"
		end

end -- class SYSTEM_RUNTIME_REMOTING_CHANNELS_ICLIENTCHANNELSINKSTACK
